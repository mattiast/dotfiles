function nb
    cd ~/progs/2020/notebooks
    source ~/kaggle/.venv/bin/activate.fish
    jupyter notebook
end
function allocations
    ~/kaggle/.venv/bin/python ~/Dropbox/reports/asset_allocation.py
end
set PATH $PATH $HOME/.pulumi/bin $HOME/.nix-profile/bin/
set fish_greeting
