-- Refer to https://wiki.hypr.land/Configuring/Basics/Variables/
local theme = require("theme")
hl.config({
    general = {
        gaps_in  = 2,
        gaps_out = 10,

        border_size = 2;

        col = {
            active_border = theme.mauve,
            inactive_border = theme.surface0,
        },

        -- Set to true to enable resizing windows by clicking and dragging on borders and gaps
        resize_on_border = false,

        -- Please see https://wiki.hypr.land/Configuring/Advanced-and-Cool/Tearing/ before you turn this on
        allow_tearing = false,

        layout = "dwindle",
    },

    dwindle = {
        preserve_split = true,
    },

    decoration = {
        rounding = 10,
        rounding_power = 2,

        -- Change transparency of focused and unfocused windows
        active_opacity = 1.0,
        inactive_opacity = 1.0,

        shadow = {
            enabled = false,
        },

        blur = {
            enabled  = true,
            size     = 20,
            passes   = 3,
            vibrancy = 0.1696,
        },
    },

    animations = {
        enabled = true,
    },

    cursor = {
        enable_hyprcursor = true;
    },
})
