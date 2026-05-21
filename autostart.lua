--    ┏━┓╻ ╻╺┳╸┏━┓┏━┓╺┳╸┏━┓┏━┓╺┳╸
--    ┣━┫┃ ┃ ┃ ┃ ┃┗━┓ ┃ ┣━┫┣┳┛ ┃
--    ╹ ╹┗━┛ ╹ ┗━┛┗━┛ ╹ ╹ ╹╹┗╸ ╹
-- See https://wiki.hypr.land/Configuring/Basics/Autostart/

hl.on("hyprland.start", function()
    hl.exec_cmd("~/.config/hypr/scripts/xdg.sh")
    --hl.exec_cmd("qs -c noctalia-shell")
    hl.exec_cmd("noctalia")
    hl.exec_cmd("/usr/lib/polkit-gnome/polkit-gnome-authentication-agent-1")
    hl.exec_cmd("~/.config/hypr/scripts/gtk.sh")
    hl.exec_cmd("vicinae server")
end)
