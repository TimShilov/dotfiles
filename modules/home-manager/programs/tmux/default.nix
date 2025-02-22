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
      vim-tmux-navigator
    ];

    extraConfig = (builtins.readFile ./tmux.conf);
  };
}
