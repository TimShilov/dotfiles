{
  pkgs,
  ...
}:
{
  # The home.packages option allows you to install Nix packages into your
  # environment.
  home.packages = with pkgs; [
    argocd
    asdf-vm
    ast-grep
    bkt # Bash caching
    dbeaver-bin
    diff-so-fancy
    fac # Git merge conflict resolution CLI
    fd
    fswatch
    glow # Markdown reader
    gnupg
    go
    gofumpt
    grafanactl
    grizzly
    imagemagick # For converting images (required by Snacks.image nvim plugin)
    jira-cli-go
    kubectx
    luarocks
    mysql84
    ncdu
    nerd-fonts.jetbrains-mono
    nixd
    nixfmt-rfc-style
    nodePackages.cspell
    parallel
    posting # API client
    rainfrog
    snowflake-cli
    taskopen
    tasksh
    taskwarrior-tui
    temporal-cli
    tlrc
    tokei
    tree
    unixtools.watch
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
