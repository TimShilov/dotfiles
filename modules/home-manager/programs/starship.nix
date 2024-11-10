{
  programs.starship = {
    enable = false;
    enableZshIntegration = true;
    settings = {
      format = "$directory$git_branch$git_state$git_status$nix_shell$sudo$line_break$jobs$battery$character";
      right_format = "$cmd_duration";
      character = {
        success_symbol = "[>](bold green)";
        error_symbol = "[x](bold red)";
      };
      git_branch = {
        format = "[\\($branch(:$remote_branch)\\)]($style) ";
        symbol = " ";
      };
    };
  };
}
