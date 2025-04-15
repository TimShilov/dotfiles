{
  programs = {
    aerospace = {
      enable = true;
      userSettings = builtins.fromTOML (
        builtins.unsafeDiscardStringContext (builtins.readFile ./.aerospace.toml)
      );
    };
  };
}
