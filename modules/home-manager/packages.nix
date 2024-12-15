{
  pkgs,
  ...
}:
{
  # The home.packages option allows you to install Nix packages into your
  # environment.
  home.packages = with pkgs; [
    asdf-vm
    ast-grep
    atac
    bkt # Bash caching
    fd
    fswatch
    gnupg
    go
    grizzly
    jira-cli-go
    lynx
    kondo
    kubectx
    luarocks
    mysql84
    nodePackages.cspell
    nixfmt-rfc-style
    rainfrog # Database management TUI
    sleek
    sshs
    taskopen
    vcal
    tasksh
    taskwarrior-tui
    tlrc
    tokei
    tree
    watchexec
    wget
    yq-go

    nerd-fonts.jetbrains-mono

    # # You can also create simple shell scripts directly inside your
    # # configuration. For example, this adds a command 'my-hello' to your
    # # environment:
    # (pkgs.writeShellScriptBin "my-hello" ''
    #   echo "Hello, ${config.home.username}!"
    # '')
  ];
}
