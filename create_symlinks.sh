CURRENTDIR=$(pwd -P)
if [[ ! -e $HOME/.config/nvim ]]; then
    ln -s $CURRENTDIR/nvim $HOME/.config/nvim
fi

if [[ ! -e $HOME/.config/fish ]]; then
    ln -s $CURRENTDIR/fish $HOME/.config/fish
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
if [[ ! -e $HOME/.bashrc ]]; then
    ln -s $CURRENTDIR/core/bashrc $HOME/.bashrc
fi
if [[ ! -e $HOME/.bash_profile ]]; then
    ln -s $CURRENTDIR/core/bash_profile $HOME/.bash_profile
fi
if [[ ! -e $HOME/.zshrc ]]; then
    ln -s $CURRENTDIR/core/zshrc $HOME/.zshrc
fi
if [[ ! -e $HOME/.zprofile ]]; then
    ln -s $CURRENTDIR/core/zprofile $HOME/.zprofile
fi

# xmonad
if [[ ! -e $HOME/.xmobarrc ]]; then
    ln -s $CURRENTDIR/xmonad/xmobarrc $HOME/.xmobarrc
fi
if [[ ! -e $HOME/.xmonad ]]; then
    ln -s $CURRENTDIR/xmonad $HOME/.xmonad
fi
