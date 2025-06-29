{ pkgs, ... }:
{
  system = {
    primaryUser = "tim.shilov";
  };

  system.activationScripts.postActivation.text = ''
    # Following line should allow us to avoid a logout/login cycle
    # TODO: Find a way to not hard-code the user name
    sudo -u tim.shilov /System/Library/PrivateFrameworks/SystemAdministration.framework/Resources/activateSettings -u
  '';

  security.pki.certificateFiles = [ "/etc/nix/ca_cert.pem" ];

  users.users."tim.shilov" = {
    name = "tim.shilov";
    home = "/Users/tim.shilov";
  };
}
