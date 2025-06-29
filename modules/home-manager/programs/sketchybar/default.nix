{ config, pkgs, ... }:
{
  programs.sketchybar = {
    enable = true;
    config = {
      source = config.lib.file.mkOutOfStoreSymlink "${config.home.homeDirectory}/dotfiles/modules/home-manager/programs/sketchybar/config";
      recursive = true;
    };
    extraPackages = with pkgs; [
      bkt
      taskwarrior3
      notmuch
    ];
  };
}
