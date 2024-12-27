{
  config,
  lib,
  ...
}:
{
  launchd = {
    enable = true;
    agents = {
      imapfilter = {
        enable = true;
        config = {
          Label = "dev.shilov.imapfilter.run";
          Program = "/opt/homebrew/bin/imapfilter";
          UserName = "tim.shilov";
          RunAtLoad = true;
          StartInterval = 900; # 15 minutes
          StandardErrorPath = "${config.home.homeDirectory}/logs/imapfilter.err";
          StandardOutPath = "${config.home.homeDirectory}/logs/imapfilter.out";
          EnvironmentVariables = {
            PATH = lib.concatStringsSep ":" [
              "${config.home.profileDirectory}/bin"
              "/usr/local/bin"
              "/opt/homebrew/bin/"
              "/usr/bin"
              "/bin"
            ];
            PASSWORD_STORE_DIR = "${config.xdg.dataHome}/password-store";
          };
        };
      };
    };
  };
}
