--    ╻ ╻╻┏┓╻╺┳┓┏━┓╻ ╻   ┏━┓╻ ╻╻  ┏━╸┏━┓
--    ┃╻┃┃┃┗┫ ┃┃┃ ┃┃╻┃   ┣┳┛┃ ┃┃  ┣╸ ┗━┓
--    ┗┻┛╹╹ ╹╺┻┛┗━┛┗┻┛   ╹┗╸┗━┛┗━╸┗━╸┗━┛
-- https://wiki.hypr.land/Configuring/Basics/Window-Rules/

hl.window_rule({
    name = "files",
    match = {
        class = "org.gnome.Nautilus"
    },
    keep_aspect_ratio = true,
    size = "1280 720",
    min_size = "1280 720",
    float = true
})

hl.window_rule({
    name = "popoutpicture",
    match = {
        title = "(Picture-in-Picture)"
    },
    keep_aspect_ratio = true,
    size = "427 240",
    min_size = "427 240",
    max_size = "1280 720",
    float = true,
    content = "video",
    opacity = "1.0 override",
    border_size = 0,
    rounding = 5,

})

hl.layer_rule({
    name = "noctalia",
    match = {
        namespace = "^noctalia-(bar-.+|notification|dock|panel|attached-panel|osd)$",
    },
    ignore_alpha = 0.5,
    blur = true,
    blur_popups = true,
})

hl.window_rule({
    name      = "discord-on-ws4",
    match     = { class = "^(vesktop)$" },
    workspace = "4 silent"
})
