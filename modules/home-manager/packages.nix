{
  pkgs,
  ...
}:
{
  # The home.packages option allows you to install Nix packages into your
  # environment.
  home.packages = with pkgs; [
    asdf-vm
    parallel
    ast-grep
    bkt # Bash caching
    unixtools.watch
    fac # Git merge conflict resolution CLI
    fd
    fswatch
    glow # Markdown reader
    gnupg
    ncdu
    go
    gofumpt
    posting # API client
    grizzly
    imagemagick # For converting images (required by Snacks.image nvim plugin)
    jira-cli-go
    kubectx
    luarocks
    mysql84
    nerd-fonts.jetbrains-mono
    nixd
    nixfmt-rfc-style
    nodePackages.cspell
    taskopen
    tasksh
    taskwarrior-tui
    temporal-cli
    tlrc
    tokei
    tree
    vcal
    watchexec
    wget
    yq-go

    (google-cloud-sdk.withExtraComponents [ google-cloud-sdk.components.gke-gcloud-auth-plugin ])

    # # You can also create simple shell scripts directly inside your
    # # configuration. For example, this adds a command 'my-hello' to your
    # # environment:
    # (pkgs.writeShellScriptBin "my-hello" ''
    #   echo "Hello, ${config.home.username}!"
    # '')
  ];
}
