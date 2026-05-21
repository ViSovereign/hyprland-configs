hl.config({
    general = {
        col = {
            active_border   = { colors = { "rgb({{colors.primary.default.hex_stripped}})", "rgb({{colors.secondary.default.hex_stripped}})" }, angle = 45 },
            inactive_border = "rgb({{colors.surface.default.hex_stripped}})",
        }
    },
    decoration = {

        shadow = {
            color = "rgb({{colors.surface.default.hex_stripped}})",
        },
    }

})
