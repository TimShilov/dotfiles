{
  config,
  ...
}:
{
  launchd = {
    enable = true;
    agents = {
      podmanMachine = {
        enable = true;
        config = {
          Label = "dev.shilov.podman.machine.start";
          ProgramArguments = [
            "/opt/homebrew/bin/podman"
            "machine"
            "start"
          ];
          RunAtLoad = true;
          StandardErrorPath = "${config.home.homeDirectory}/logs/podman-machine.err";
          StandardOutPath = "${config.home.homeDirectory}/logs/podman-machine.out";
          EnvironmentVariables = {
            PATH = "${config.home.profileDirectory}/bin:/usr/local/bin:/usr/bin:/bin";
          };
        };
      };
    };
  };
}
