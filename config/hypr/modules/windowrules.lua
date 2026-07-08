-- See https://wiki.hypr.land/Configuring/Basics/Window-Rules/
-- and https://wiki.hypr.land/Configuring/Basics/Workspace-Rules/

local important = { "kitty", "brave-browser" }

hl.window_rule({
    name  = "unimportant",
    match = { class = ".*" },
    float = true,
    center = true,
    size = {"(monitor_w * 0.75)", "(monitor_h * 0.75)"},
})

for _, name in ipairs(important) do
    hl.window_rule({
        name = "important_" .. name,
        match = { class = "^" .. name .. "$" },
        tile = true,
    })
end

hl.window_rule({
    -- Ignore maximize requests from all apps.
    name  = "suppress-maximize-events",
    match = { class = ".*" },

    suppress_event = "maximize",
})

hl.window_rule({
    -- Fix some dragging issues with XWayland
    name  = "fix-xwayland-drags",
    match = {
        class      = "^$",
        title      = "^$",
        xwayland   = true,
        float      = true,
        fullscreen = false,
        pin        = false,
    },

    no_focus = true,
})

