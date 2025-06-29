{
  config,
  lib,
  ...
}:
{
  launchd = {
    enable = true;
    agents = {
      cleanupDownloads = {
        enable = true;
        config = {
          Label = "dev.shilov.cleanup.downloads";
          ProgramArguments = [
            "/bin/zsh"
            "-c"
            # bash
            ''
              'find ${config.home.homeDirectory}/Downloads -type f -mtime +30 -delete && find${config.home.homeDirectory}/Downloads -name .DS_Store -delete && find ${config.home.homeDirectory}/Downloads -type d -empty -delete
              '
            ''
          ];
          UserName = config.home.username;
          RunAtLoad = true;
          StartInterval = 86400; # 1 day
        };
      };
    };
  };
}
