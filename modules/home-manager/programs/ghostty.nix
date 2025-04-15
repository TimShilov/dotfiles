{
  programs = {
    ghostty = {
      enable = true;
      package = null; # Installed via homebrew as the Nixpkgs package is broken on MacOS
      enableZshIntegration = true;
      settings = {
        font-size = 16;
        auto-update = "download";

        macos-titlebar-style = "hidden";
        window-padding-x = "0";
        window-padding-y = "0";

        background-opacity = "0.90";
        background-blur-radius = "50";
        macos-window-shadow = "false";
        confirm-close-surface = "false";

        cursor-style = "block";
        shell-integration-features = "no-cursor";

        keybind = [
          "ctrl+f=unbind"
          "super+n=unbind"
          "super+shift+n=unbind"

          # \\x02 is Ctrl+b"
          # Previous tmux session (CMD + l)"
          "super+l=text:\\x02L"

          # Reload tmux config (CMD + r)"
          "super+r=text:\\x02r"

          # Open sesh (CMD + k)"
          "super+k=text:\\x02k"

          # Open Lazygit (CMD + g)"
          "super+g=text:\\x02g"

          # Open Jira CLI (CMD + j)"
          "super+j=text:\\x02j"

          # Open Jira CLI - hotfixes only (CMD + J)"
          "super+shift+j=text:\\x02J"

          # Open GitHub Dashboard (CMD + Shift + g)"
          "super+shift+g=text:\\x02G"

          # Split vertically (CMD + d)"
          "super+d=text:\\x02n"

          # Split horizontally (CMD + Shift + d)"
          "super+shift+d=text:\\x02N"

          # New tmux window (CMD + t)"
          "super+t=text:\\x02c"

          # Close tmux window (CMD + w)"
          "super+w=text:\\x02&"

          # tmux-fzf-url (CMD + u)"
          "super+u=text:\\x02u"

          # kubernetes (CMD + e)"
          "super+e=text:\\x02e"

          # Zoom in tmux pane (CMD + z)"
          "super+z=text:\\x02z"

          # Tmux window navigation (CMD + [/])"
          "super+left_bracket=text:\\x02p"
          "super+right_bracket=text:\\x02]"

          # Switch to tmux window (CMD + 1..5)"
          "super+1=text:\\x021"
          "super+2=text:\\x022"
          "super+3=text:\\x023"
          "super+4=text:\\x024"
          "super+5=text:\\x025"
        ];
      };
    };
  };
}
