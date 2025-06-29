{ pkgs, ... }:
{
  system = {
    primaryUser = "tim";
  };

  system.activationScripts.postActivation.text = ''
    # Following line should allow us to avoid a logout/login cycle
    # TODO: Find a way to not hard-code the user name
    sudo -u tim /System/Library/PrivateFrameworks/SystemAdministration.framework/Resources/activateSettings -u
  '';

  users.users."tim" = {
    name = "tim";
    home = "/Users/tim";
  };
}
