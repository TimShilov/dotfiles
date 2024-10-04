local wezterm = require("wezterm")
local act = wezterm.action
local config = wezterm.config_builder()

local tmuxKeymap = function(mods, key, tmuxHotkey)
    return {
        key = key,
        mods = mods,
        action = act.Multiple({
            act.SendKey({ mods = "CTRL", key = "b" }),
            act.SendKey({ key = tmuxHotkey }),
        }),
    }
end

config.color_scheme = "Catppuccin Mocha"
config.font_size = 18.0
config.font = wezterm.font({
    family = "JetBrainsMono Nerd Font",
    harfbuzz_features = { "calt=1", "clig=1", "liga=1" },
})

config.window_close_confirmation = "NeverPrompt"

config.enable_tab_bar = false
config.window_decorations = "RESIZE"
config.window_padding = {
    left = 0,
    right = 0,
    top = 0,
    bottom = 0,
}
config.keys = {
    -- Previous tmux session (CMD + l)
    tmuxKeymap("SUPER", "l", "L"),

    -- New tmux window (CMD + t)
    tmuxKeymap("SUPER", "t", "c"),
    -- Close tmux window (CMD + w)
    tmuxKeymap("SUPER", "w", "&"),

    -- Zoom in tmux pane (CMD + f)
    tmuxKeymap("SUPER", "f", "z"),

    -- Switch to tmux window (CMD + 1..4)
    tmuxKeymap("SUPER", "1", "1"),
    tmuxKeymap("SUPER", "2", "2"),
    tmuxKeymap("SUPER", "3", "3"),
    tmuxKeymap("SUPER", "4", "4"),
}

return config
