-- See https://wiki.hypr.land/Configuring/Basics/Window-Rules/
-- and https://wiki.hypr.land/Configuring/Basics/Workspace-Rules/

-- Important windows get to tile. Secondary windows float and tile in the magic workspace.
-- All other windows are unimportant and will just appear as a popup (float + center).
local important = { "kitty", "brave-browser" }
local secondary = { "discord", "spotify" }

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

for _, name in ipairs(secondary) do
    hl.window_rule({
        name = "secondary_" .. name,
        match = { class = "^" .. name .. "$" },
        workspace = "special:magic",
        tile = true,
        float = true,
        center = true,
        size = {"(monitor_w * 0.75)", "(monitor_h * 0.75)"},
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

-- Events --
hl.on("config.reloaded", function()
    hl.notification.create({ text = "Hyprland config reloaded", timeout = 5000, icon = "ok" })
end)

-- TODO
-- hl.on("window.fullscreen", function(w)
--     if w.class ~= "kitty" then return end
--
--     local opacity = w.fullscreen == 2 and 1.0 or 0.8
--     local cmd = string.format(
--         [[sh -c 'for s in /tmp/kitty-*; do kitten @ --to unix:"$s" set-background-opacity --match state:focused %s 2>/dev/null; done']],
--         opacity
--     )
--
--     hl.exec_cmd(cmd)
-- end)
