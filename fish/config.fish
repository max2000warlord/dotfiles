if status is-interactive
end

if test -z "$DBUS_SESSION_BUS_ADDRESS"
    set -gx DBUS_SESSION_BUS_ADDRESS "unix:path=$XDG_RUNTIME_DIR/bus"
end

set fish_greeting
set fish_key_bindings fish_default_key_bindings
set -U tide_os_icon \uf31f
zoxide init fish | source
fastfetch

################################
#####       ALIASES       ######
################################
#Format = alias xxx="something"
alias asd="paru"
alias asc="paru -Sua"
alias qwd="pacman -Qii"
alias zxc="sudo pacman -S"
alias zxcc="sudo pacman -S --needed --noconfirm"
alias cxz="sudo pacman -Rs"
alias gc="gix clone"
alias cd="z"
alias exe="sudo chmod +x"
alias nv="nvim"
alias gpg-test="echo \"test\" | gpg --clearsign"
alias cfg="sudo grub-mkconfig -o /boot/grub/grub.cfg"
alias qqq="loginctl reboot"
alias spt="spotify_player"
alias sss="source ~/.config/fish/config.fish"
alias sshh="eval (ssh-agent -c) && ssh-add ~/.ssh/id_ed25519"
alias fw="sudo firewall-cmd"
alias ls="lsd -Alh --color=auto"
alias az="yazi"
alias ccc='clear && fastfetch'
alias ctl='sudo dinitctl'
alias man='batman'
alias cat='bat'

#######################
### PATH stuff etc. ###
#######################
set NPM_PACKAGES "$HOME/.npm-packages"
set PATH $PATH $NPM_PACKAGES/bin
set -U fish_user_paths $HOME/.cargo/bin $fish_user_paths
set -U fish_user_paths $HOME/.local/bin $fish_user_paths
set -U fish_user_paths $HOME/.local/scripts/ $fish_user_paths
set -U EDITOR nvim
set MANPATH $NPM_PACKAGES/share/man $MANPATH
set -x SSH_AUTH_SOCK (ssh-agent)
set -gx GPG_TTY (tty)

#######################
###  ENV stuff etc. ###
#######################

if test "$XDG_SESSION_TYPE" = wayland
    set -x GDK_BACKEND wayland
end

# bun
set --export BUN_INSTALL "$HOME/.bun"
set --export PATH $BUN_INSTALL/bin $PATH
set -Ux fish_history_time_format "%Y-%m-%d %H:%M:%S"

set -gx OTEL_EXPORTER_OTLP_PROTOCOL http/protobuf
