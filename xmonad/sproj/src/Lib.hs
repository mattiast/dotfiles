{-# LANGUAGE ScopedTypeVariables #-}
module Lib  where
import System.IO
import Control.Monad(filterM)
import Data.List
import Data.Function((&))
import Data.Foldable(traverse_)
import Data.Maybe(listToMaybe)
import Data.Monoid((<>),mconcat)
import XMonad
import XMonad.Hooks.DynamicLog
import XMonad.Hooks.ManageDocks
import XMonad.Hooks.SetWMName(setWMName)
import XMonad.Util.Run(spawnPipe,safeSpawn)
import XMonad.Util.EZConfig(additionalKeysP, removeKeysP)
import XMonad.Util.Dmenu(menuArgs)
import XMonad.Prompt
import XMonad.Prompt.Ssh
import XMonad.Prompt.Shell
import XMonad.Layout.Tabbed
import qualified XMonad.StackSet as SS

myManageHook :: ManageHook
myManageHook = mconcat
    [ className =? "feh"            --> doFloat
    , title     =? "xterm"          --> doF SS.swapDown
    ]

myPromptConfig :: XPConfig
myPromptConfig = def { font = "-*-Fixed-Bold-R-Normal-*-13-*-*-*-*-*-*-*",
                                   bgColor = "black",
                                   fgColor = "green",
                                   promptBorderWidth = 0,
                                   historyFilter = uniqSort }

myLayout = Full ||| avoidStruts (Full ||| tiled ||| Mirror tiled ||| tabd)
  where
     --  Tall nmaster delta ratio
     tiled = Tall 1 (3/100) (72/100)
     tabd = tabbed shrinkText def { fontName =  "-*-Fixed-Bold-R-Normal-*-13-*-*-*-*-*-*-*" }

myKeys :: [(String, X ())]
myKeys = [ ("M-s", sshPrompt myPromptConfig)
         , ("M-p", shellPrompt myPromptConfig )
         , ("<XF86MonBrightnessDown>", spawn "xbacklight -5" )
         , ("<XF86MonBrightnessUp>", spawn "xbacklight +5" )
         , ("<Print>", chromeJump myChromePages )
         , ("<XF86Display>", getStuff )
         ]

getStuff :: X ()
getStuff = findWin (isSuffixOf "Google Chrome")
            >>= traverse_ focus

myChromePages :: [(String, String)]
myChromePages = [ ("Trello", "https://trello.com/b/39zd4rph/nextactions")
                , ("Mail", "https://mail.google.com/mail/")
                , ("Kasti", "http://46.101.45.150:3000/browse")
                , ("Rabbit", "http://www.rabbit-account.com:8000/report")
                , ("Tutorfair", "https://tutorfair.com")
                ]

chromeJump :: [(String, String)] -> X ()
chromeJump pages = do
    choice <- menuArgs "dmenu" ["-i"] (fmap fst pages)
    lookup choice pages
        & traverse_ (\url -> safeSpawn "google-chrome" [url] >> getStuff)

findWin :: (String -> Bool) -> X (Maybe Window)
findWin filt = do
    xState <- get
    let ws :: [ Window ]
        ws = xState
                & windowset
                & SS.allWindows
    matches <- filterM (fmap filt . runQuery title) ws
    return $ listToMaybe matches

main :: IO ()
main = do
    xmobar_proc <- spawnPipe "xmobar"
    xmonad $ docks $ def {
        startupHook = setWMName "LG3D",
        manageHook = myManageHook <> manageHook def,
        layoutHook = myLayout,
        logHook = dynamicLogWithPP $ xmobarPP {
            ppOutput = hPutStrLn xmobar_proc,
            ppTitle = xmobarColor "green" "" . shorten 85
        },
        terminal = "xterm",
        borderWidth = 0
    } `additionalKeysP` myKeys
      `removeKeysP` [ "M-<Return>" ]
