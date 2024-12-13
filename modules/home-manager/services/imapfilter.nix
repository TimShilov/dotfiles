{
  config,
  ...
}:
{
  launchd = {
    enable = true;
    agents = {
      imapfilter = {
        enable = true;
        config = {
          Label = "tim.imapfilter.run";
          Program = "/opt/homebrew/bin/imapfilter";
          UserName = "tim.shilov";
          RunAtLoad = true;
          StartInterval = 900; # 15 minutes
          StandardErrorPath = "/Users/tim.shilov/imapfilter.err";
          StandardOutPath = "/Users/tim.shilov/imapfilter.out";
          EnvironmentVariables = {
            PATH = "${config.home.profileDirectory}/bin:/usr/local/bin:/usr/bin:/bin";
            PASSWORD_STORE_DIR = "/Users/tim.shilov/.password-store";
          };
        };
      };
    };
  };
}
