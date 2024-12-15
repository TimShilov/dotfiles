{
  config,
  ...
}:
{
  launchd = {
    enable = true;
    agents = {
      bugwarrior-pull = {
        enable = true;
        config = {
          Label = "dev.shilov.bugwarrior.pull";
          # TODO: Find a way to not use macOS's built-in Python
          Program = "/Users/tim.shilov/Library/Python/3.9/bin/bugwarrior-pull";
          RunAtLoad = true;
          StartInterval = 900; # 15 minutes
          StandardErrorPath = "/Users/tim.shilov/bugwarrior-pull.err";
          StandardOutPath = "/Users/tim.shilov/bugwarrior-pull.out";
          EnvironmentVariables = {
            PATH = "${config.home.profileDirectory}/bin:/usr/local/bin:/usr/bin:/bin";
          };
        };
      };
    };
  };
}
