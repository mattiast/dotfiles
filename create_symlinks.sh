CURRENTDIR=$(pwd -P)
if [[ ! -e $HOME/.config/nvim ]]; then
    ln -s $CURRENTDIR/nvim $HOME/.config/nvim
fi

# git
if [[ ! -e $HOME/.gitconfig ]]; then
    ln -s $CURRENTDIR/git/gitconfig $HOME/.gitconfig
fi
if [[ ! -e $HOME/.gitignore_global ]]; then
    ln -s $CURRENTDIR/git/gitignore_global $HOME/.gitignore_global
fi

# core
if [[ ! -e $HOME/.Xresources ]]; then
    ln -s $CURRENTDIR/core/Xresources $HOME/.Xresources
fi

# xmonad
if [[ ! -e $HOME/.xmobarrc ]]; then
    ln -s $CURRENTDIR/xmonad/xmobarrc $HOME/.xmobarrc
fi
