CURRENTDIR=$(pwd -P)
if [[ ! -e $HOME/.config/nvim ]]; then
    ln -s $CURRENTDIR/nvim $HOME/.config/nvim
fi


if [[ ! -e $HOME/.gitconfig ]]; then
    ln -s $CURRENTDIR/gitconfig $HOME/.gitconfig
fi

if [[ ! -e $HOME/.gitignore_global ]]; then
    ln -s $CURRENTDIR/gitignore_global $HOME/.gitignore_global
fi
