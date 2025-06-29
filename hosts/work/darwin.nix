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

  # TODO: Move to the base darwin config when MacOS 26 compatibility is fixed
  services = {
    jankyborders = {
      # Catppuccin colors
      # active_color = "gradient(top_left=0xffcba6f7,bottom_right=0xfffab387)";
      # GitHub colors
      active_color = "gradient(top_left=0xff7C72FF,bottom_right=0xff2DA44E)";

      enable = true;
      hidpi = false;
      inactive_color = "0x00FFFFFF";
      order = "above";
      style = "round";
      width = 8.0;
    };
  };
}
