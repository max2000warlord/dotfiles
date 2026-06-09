function rearrange
    set dotfiles ~/!conf
    for dir in ghostty hypr matugen nvim rofi waybar
        cp -aR ~/.config/$dir $dotfiles/$dir
        rm -rf ~/.config/$dir
        ln -s $dotfiles/$dir ~/.config/$dir
    end
end
