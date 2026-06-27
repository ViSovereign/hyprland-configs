-- See https://wiki.hypr.land/Configuring/Basics/Monitors/
hl.monitor({ output = "DP-1", mode = "2560x1440@144", position = "1440x520", scale = 1 })
hl.monitor({ output = "DP-2", mode = "2560x1440@59.95", position = "0x0", scale = 1, transform = 3 })

hl.workspace_rule({ workspace = "1", monitor = "DP-1", persistent = true, default = true })
hl.workspace_rule({ workspace = "2", monitor = "DP-1", persistent = true, layout = "master" })
hl.workspace_rule({ workspace = "3", monitor = "DP-1", persistent = true })
hl.workspace_rule({ workspace = "4", monitor = "DP-2", persistent = true, layout = "scrolling", default = true })
hl.workspace_rule({ workspace = "5", monitor = "DP-2", persistent = true, layout = "scrolling" })
hl.workspace_rule({ workspace = "6", monitor = "DP-2", persistent = true, layout = "scrolling" })
