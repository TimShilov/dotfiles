{
  config,
  pkgs,
  lib,
  ...
}:
let
  nerdFontWindowNamePlugin = pkgs.tmuxPlugins.mkTmuxPlugin {
    pluginName = "tmux-nerd-font-window-name";
    version = "v2.1.2";
    rtpFilePath = "tmux-nerd-font-window-name.tmux";
    src = pkgs.fetchFromGitHub {
      owner = "joshmedeski";
      repo = "tmux-nerd-font-window-name";
      rev = "2f5131f01b6cc052069211f6dce02c3fec564da2";
      sha256 = "sha256-bnlOAfdBv5Rg4z1hu1jtdx5oZ6kAZE40K4zqLxmyYQE=";
    };
  };
in
{
  programs.tmux = {
    enable = true;
    mouse = true;
    baseIndex = 1;
    clock24 = true;
    keyMode = "vi";
    plugins = with pkgs.tmuxPlugins; [
      nerdFontWindowNamePlugin
      fzf-tmux-url
      sensible
      resurrect
      continuum
      vim-tmux-navigator
    ];
    terminal = "wezterm";
    catppuccin = {
      extraConfig = # bash
        ''
          set -g @catppuccin_status_background "none"
          # TODO: Make sure that all the options are correct as they were changed in 2.0.0 (@see https://github.com/catppuccin/tmux/blob/main/docs/reference/configuration.md)
          set -g @catppuccin_status_modules_right "session"

          set -g @catppuccin_window_current_text " #W"
          set -g @catppuccin_window_flags "icon"
          set -g @catppuccin_window_flags_icon_activity "󱅫"
          set -g @catppuccin_window_flags_icon_bell "󰂞"
          set -g @catppuccin_window_flags_icon_current ""
          set -g @catppuccin_window_flags_icon_last ""
          set -g @catppuccin_window_flags_icon_zoom "󰁌 "
          set -g @catppuccin_window_text " #W"

          TASK_CMD="task rc.gc=off"
          GITHUB_PR_COUNT="#(bkt --ttl=1m --discard-failures -- $TASK_CMD githubnumber +READY count)"
          JIRA_TICKET_COUNT="#(bkt --ttl=1m --discard-failures -- $TASK_CMD jiraid +READY count)"
          JIRA_HOTFIX_COUNT="#(bkt --ttl=1m --discard-failures -- $TASK_CMD jiraissuetype:HotFix +READY count)"

          STATUS_SEPARATOR=" "

          set -g status-right "#[fg=#{@thm_subtext_1},align=centre]#($TASK_CMD _get $($TASK_CMD next limit:1 | tail -n +4 | head -n 1 | sed 's/^ //' | cut -d ' ' -f1).description)#[align=right]"

          set -ag status-right "#[fg=#{@thm_blue}]󰌃 "
          set -ag status-right "#[fg=#{@thm_red}]#{?#{>:$JIRA_HOTFIX_COUNT,0},$JIRA_HOTFIX_COUNT ,}"
          set -ag status-right "#[fg=#{@thm_blue}]$JIRA_TICKET_COUNT "
          set -ag status-right "$STATUS_SEPARATOR"

          set -ag status-right "#[fg=#{@thm_peach}] "
          set -ag status-right "#[fg=#{@thm_peach}]$GITHUB_PR_COUNT "
          set -ag status-right "$STATUS_SEPARATOR"

          set -ag status-right "#{E:@catppuccin_status_session}"
        '';
    };

    extraConfig = (builtins.readFile ./tmux.conf);
  };
}
