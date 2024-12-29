local wezterm = require("wezterm")
local act = wezterm.action
local config = wezterm.config_builder()

config.max_fps = 120

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

config = {
    color_scheme = "Catppuccin Mocha",
    term = "wezterm",
    font_size = 17.0,
    font = wezterm.font({
        family = "JetBrainsMono NF",
        harfbuzz_features = { "calt=1", "clig=1", "liga=1" },
    }),
    window_close_confirmation = "NeverPrompt",
    front_end = "WebGpu",
    enable_tab_bar = false,
    window_decorations = "RESIZE",
    window_padding = {
        left = 0,
        right = 0,
        top = 0,
        bottom = 0,
    },
    keys = {
        -- Previous tmux session (CMD + l)
        tmuxKeymap("SUPER", "l", "L"),

        -- Reload tmux config (CMD + r)
        tmuxKeymap("SUPER", "r", "r"),
        -- Open Lazygit (CMD + g)
        tmuxKeymap("SUPER", "g", "g"),
        -- Open Jira CLI (CMD + j)
        tmuxKeymap("SUPER", "j", "j"),
        -- Open Jira CLI - hotfixes only (CMD + J)
        tmuxKeymap("SUPER", "J", "J"),
        -- Open GitHub Dashboard (CMD + Shift + g)
        tmuxKeymap("SUPER", "G", "G"),

        -- Split vertically (CMD + n)
        tmuxKeymap("SUPER", "n", "n"),
        -- Split horizontally (CMD + Shift + n)
        tmuxKeymap("SUPER", "N", "N"),

        -- New tmux window (CMD + t)
        tmuxKeymap("SUPER", "t", "c"),
        -- Close tmux window (CMD + w)
        tmuxKeymap("SUPER", "w", "&"),

        -- tmux-fzf-url (CMD + u)
        tmuxKeymap("SUPER", "u", "u"),

        -- kubernetes (CMD + e)
        tmuxKeymap("SUPER", "e", "e"),

        -- Zoom in tmux pane (CMD + f)
        tmuxKeymap("SUPER", "f", "z"),

        -- Tmux window navigation (CMD + [/])
        tmuxKeymap("SUPER", "[", "p"),
        tmuxKeymap("SUPER", "]", "]"),

        -- Switch to tmux window (CMD + 1..5)
        tmuxKeymap("SUPER", "1", "1"),
        tmuxKeymap("SUPER", "2", "2"),
        tmuxKeymap("SUPER", "3", "3"),
        tmuxKeymap("SUPER", "4", "4"),
        tmuxKeymap("SUPER", "5", "5"),
    },
}

return config
