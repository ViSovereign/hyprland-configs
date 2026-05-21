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
    rounding = 0,

})

hl.layer_rule({
    match        = { namespace = "vicinae" },
    blur         = true,
    ignore_alpha = 0.25,
})

hl.layer_rule({
    match        = { namespace = "noctalia-background-.*$" },
    blur         = true,
    blur_popups  = false,
    ignore_alpha = 0.25,
})

hl.layer_rule({
    match        = { namespace = "noctalia.*$" },
    blur         = true,
    blur_popups  = false,
    ignore_alpha = 0.25,
})
