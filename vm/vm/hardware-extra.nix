{ config, pkgs, lib, ... }:

{
  # Hardware support
  #hardware.openrazer.enable = true;

  # VirtualBox
  #virtualisation.virtualbox.host.enable = true;
  #users.extraGroups.vboxusers.members = [ "olivernix" ];
  #virtualisation.virtualbox.host.enableExtensionPack = true;
  # Waydroid
  boot.initrd.checkJournalingFS = false;
  # Bluetooth
  hardware.bluetooth.enable = true;
  services.blueman.enable = true;
  # Audio
  services.pulseaudio.enable = false;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    wireplumber.enable = true;
    pulse.enable = true;
  };
}
