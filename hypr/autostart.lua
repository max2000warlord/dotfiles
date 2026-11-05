-------------------
---- AUTOSTART ----
-------------------

-- See https://wiki.hypr.land/Configuring/Basics/Autostart/

-- Autostart necessary processes (like notifications daemons, status bars, etc.)
-- Or execute your favorite apps at launch like this:

hl.on("hyprland.start", function()
	hl.exec_cmd("dbus-update-activation-environment --all")
	hl.exec_cmd("/usr/lib/polkit-gnome/polkit-gnome-authentication-agent-1")
	hl.exec_cmd("~/.config/hypr/inits/matugen.sh")
	hl.exec_cmd("hypridle")
	hl.exec_cmd("waybar")
	hl.exec_cmd("awww-daemon")
	hl.exec_cmd("nm-applet")
	hl.exec_cmd("blueman-applet")
	hl.exec_cmd("1password")
	hl.exec_cmd(
		[[fish -c 'set img (strings ~/.cache/awww/*/eDP-1 | string match -r "^/.*" | head -n1); test -n "$img"; and ln -sf $img ~/.cache/awww/current']]
	)
end)
