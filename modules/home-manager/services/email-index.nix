{
  config,
  ...
}:
{
  launchd = {
    enable = true;
    agents = {
      indexEmail = {
        enable = true;
        config = {
          Label = "dev.shilov.email.index";
          ProgramArguments = [
            "${config.home.profileDirectory}/bin/notmuch"
            "new"
          ];
          UserName = config.home.username;
          RunAtLoad = true;
          StartInterval = 600; # 10 minutes
          StandardErrorPath = "${config.home.homeDirectory}/logs/email-index.err";
          StandardOutPath = "${config.home.homeDirectory}/logs/email-index.out";
          EnvironmentVariables = {
            PATH = "${config.home.profileDirectory}/bin:/usr/local/bin:/usr/bin:/bin";
          };
        };
      };
    };
  };
}
