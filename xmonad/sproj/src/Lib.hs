{-# LANGUAGE ScopedTypeVariables #-}

module Lib
  ( main
  ) where

import Control.Monad (filterM)
import Data.Foldable (traverse_)
import Data.Function ((&))
import Data.List
import Data.Maybe (listToMaybe)
import Data.Monoid ((<>), mconcat)
import System.IO
import XMonad
import XMonad.Hooks.DynamicLog
import XMonad.Hooks.ManageDocks
import XMonad.Hooks.SetWMName (setWMName)
import XMonad.Layout.Tabbed
import XMonad.Prompt hiding (pasteString)
import XMonad.Prompt.Shell
import XMonad.Prompt.Ssh
import qualified XMonad.StackSet as SS
import XMonad.Util.Dmenu (menuArgs)
import XMonad.Util.EZConfig (additionalKeysP, removeKeysP)
import XMonad.Util.Paste (pasteString)
import XMonad.Util.Run (runProcessWithInput, safeSpawn, spawnPipe)
import XMonad.Util.XSelection (getSelection)

myManageHook :: ManageHook
myManageHook =
  mconcat [className =? "feh" --> doFloat, title =? "xterm" --> doF SS.swapDown]

myPromptConfig :: XPConfig
myPromptConfig =
  def
  { font = "-*-Fixed-Bold-R-Normal-*-13-*-*-*-*-*-*-*"
  , bgColor = "black"
  , fgColor = "green"
  , promptBorderWidth = 0
  , historyFilter = uniqSort
  }

myLayout = avoidStruts (Full ||| tiled ||| Mirror tiled ||| tabd) ||| Full
     --  Tall nmaster delta ratio
  where
    tiled = Tall 1 (3 / 100) (72 / 100)
    tabd =
      tabbed
        shrinkText
        def {fontName = "-*-Fixed-Bold-R-Normal-*-13-*-*-*-*-*-*-*"}

myKeys :: [(String, X ())]
myKeys =
  [ ("M-s", sshPrompt myPromptConfig)
  , ("M-p", shellPrompt myPromptConfig)
  , ("<XF86AudioRaiseVolume>", spawn "amixer -q sset Master 3%+")
  , ("<XF86AudioLowerVolume>", spawn "amixer -q sset Master 3%-")
  , ("<XF86AudioMute>", spawn "amixer -q sset Master toggle")
  , ("<XF86MonBrightnessDown>", spawn "xbacklight -5")
  , ("<XF86MonBrightnessUp>", spawn "xbacklight +5")
  , ("<Print>", chromeJump myChromePages)
  , ("<XF86Display>", jutska)
  , ("<XF86AudioMicMute>", toggleVpn "smarkets")
  ]

jutska :: X ()
jutska = do
  input <- getSelection
  output <- runProcessWithInput "mysudoku" [] input
  pasteString output

checkVpn :: String -> X Bool
checkVpn name = do
  out <- runProcessWithInput "nmcli" ["-t", "con", "show", "--active"] ""
  return $ any (isPrefixOf (name <> ":")) (lines out)

toggleVpn :: String -> X ()
toggleVpn name = do
  on <- checkVpn name
  let upDown =
        if on
          then "down"
          else "up"
  safeSpawn "nmcli" ["con", upDown, name]

getStuff :: X ()
getStuff = findWin (isSuffixOf "Google Chrome") >>= traverse_ focus

myChromePages :: [(String, String)]
myChromePages =
  [ ("Trello", "https://trello.com/b/39zd4rph/nextactions")
  , ("Mail", "https://mail.google.com/mail/")
  , ("Kasti", "https://kasti.me.uk/continue")
  , ("Rabbit", "https://rabbit-account.com/all")
  ]

chromeJump :: [(String, String)] -> X ()
chromeJump pages = do
  choice <- menuArgs "dmenu" ["-i"] (fmap fst pages)
  lookup choice pages &
    traverse_ (\url -> safeSpawn "google-chrome" [url] >> getStuff)

findWin :: (String -> Bool) -> X (Maybe Window)
findWin filt = do
  xState <- get
  let ws :: [Window]
      ws = xState & windowset & SS.allWindows
  matches <- filterM (fmap filt . runQuery title) ws
  return $ listToMaybe matches

main :: IO ()
main = do
  xmobar_proc <- spawnPipe "xmobar"
  xmonad $
    docks $
    def
    { startupHook = setWMName "LG3D"
    , manageHook = myManageHook <> manageHook def
    , layoutHook = myLayout
    , logHook =
        dynamicLogWithPP $
        xmobarPP
        { ppOutput = hPutStrLn xmobar_proc
        , ppTitle = xmobarColor "green" "" . shorten 85
        }
    , terminal = "xterm"
    , borderWidth = 0
    } `additionalKeysP`
    myKeys `removeKeysP`
    ["M-<Return>"]
