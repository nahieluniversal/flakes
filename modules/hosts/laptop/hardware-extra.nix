{ config, pkgs, lib, ... }:

{
  # Hardware support
  hardware.openrazer.enable = true;

  # VirtualBox
  virtualisation.virtualbox.host.enable = true;
  users.extraGroups.vboxusers.members = [ "olivernix" ];
  virtualisation.virtualbox.host.enableExtensionPack = true;

  # Docker
  virtualisation.docker.enable = true;

  # Waydroid
  virtualisation.waydroid = {
    enable = true;
    package = pkgs.waydroid-nftables;
  };

  # Bluetooth
  hardware.bluetooth.enable = true;
  services.blueman.enable = true;

  # Graphics and Nvidia
  hardware.graphics = {
    enable = true;
    enable32Bit = true;
  };

  hardware.nvidia = {
    modesetting.enable = true;
    powerManagement.enable = true;
    powerManagement.finegrained = true;
    open = false;
    nvidiaSettings = true;
    package = config.boot.kernelPackages.nvidiaPackages.stable;
  };

  hardware.nvidia.prime = {
    offload = {
      enable = true;
      enableOffloadCmd = true;
    };
    amdgpuBusId = "PCI:5:0:0";
    nvidiaBusId = "PCI:1:0:0";
  };

  services.xserver.videoDrivers = [
    "amdgpu"
    "nvidia"
  ];

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
