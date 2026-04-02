# Lenovo Legion Go S - Additional Hardware Configuration
{ config, pkgs, lib, ... }:

{

  services.libinput.enable = true;
  
  services.xserver = {
    videoDrivers = [ "modesetting" ];
  };

  services.logind.settings.Login = {
    HandleLidSwitch = "hybrid-sleep";
    HandleLidSwitchDocked = "lock";
    HandlePowerKey = "poweroff";
    HandlePowerKeyLongPress = "ignore";
  };

  services.throttled.enable = true;
  services.acpid.enable = true;
}
