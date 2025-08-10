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
      rev = "4c9e7a51387d0cead1465a3628244beb790a3c95";
      sha256 = "sha256-UcfEsq7BqJMeYXtGDNMoi/E+iEnEe9iM2KVoi7ektOE=";
    };
  };
in
{
  home.file = {
    ".config/tmux/tmux-nerd-font-window-name.yml" = {
      source = ./tmux-nerd-font-window-name.yml;
    };
  };
  programs.sesh = {
    enable = true;
    enableTmuxIntegration = true;
    tmuxKey = "k";
  };
  programs.tmux = {
    enable = true;
    mouse = true;
    baseIndex = 1;
    clock24 = true;
    keyMode = "vi";
    terminal = "tmux-256color";
    plugins = with pkgs.tmuxPlugins; [
      nerdFontWindowNamePlugin
      fzf-tmux-url
      sensible
      vim-tmux-navigator
      tmux-thumbs
    ];

    extraConfig = (builtins.readFile ./tmux.conf);
  };
}
