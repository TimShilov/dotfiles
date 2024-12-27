{
  config,
  ...
}:
{
  launchd = {
    enable = true;
    agents = {
      syncEmail = {
        enable = true;
        config = {
          Label = "dev.shilov.email.sync";
          ProgramArguments = [
            "${config.home.profileDirectory}/bin/mbsync"
            "-a"
          ];
          UserName = "tim.shilov";
          RunAtLoad = true;
          StartInterval = 600; # 10 minutes
          StandardErrorPath = "${config.home.homeDirectory}/logs/email-sync.err";
          StandardOutPath = "${config.home.homeDirectory}/logs/email-sync.out";
          EnvironmentVariables = {
            PATH = "${config.home.profileDirectory}/bin:/usr/local/bin:/usr/bin:/bin";
            PASSWORD_STORE_DIR = "${config.xdg.dataHome}/password-store";
          };
        };
      };
    };
  };
}
