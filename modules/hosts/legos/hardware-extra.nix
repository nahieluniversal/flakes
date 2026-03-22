# Lenovo Legion Go S - Additional Hardware Configuration
{ config, pkgs, lib, ... }:

{

  services.libinput.enable = true;
  services.libinput.touchpad.enabled = true;
  
  services.xserver = {
    videoDrivers = [ "modesetting" ];
  };

  services.logind.settings.Login = {
    HandleLidSwitch = "hybrid-sleep";
    HandleLidSwitchDocked = "lock";
    HandlePowerKey = "poweroff";
    HandlePowerKeyLongPress = "ignore";
  };

  services.tlp = {
    enable = true;
    settings = {
      CPU_SCALING_GOVERNOR_ON_AC = "performance";
      CPU_SCALING_GOVERNOR_ON_BAT = "powersave";
      CPU_BOOST_ON_AC = 1;
      CPU_BOOST_ON_BAT = 0;
      ENERGY_PERF_POLICY_ON_AC = "performance";
      ENERGY_PERF_POLICY_ON_BAT = "power";
      RADEON_POWER_PROFILE_ON_AC = "high";
      RADEON_POWER_PROFILE_ON_BAT = "low";
    };
  };

  services.battery-manager = {
    enable = true;
  };

  services.throttled.enable = true;
  services.acpid.enable = true;
}
