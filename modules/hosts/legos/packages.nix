{ config, pkgs, lib, ... }:

{
  environment.systemPackages = with pkgs; [
    acpi
    alacritty
    curl
    dejavu_fonts
    evtest
    git
    glxinfo
    htop
    iw
    kdePackages.kate
    kdePackages.dolphin
    kdePackages.kservice
    kdePackages.ark
    kdePackages.okular
    kdePackages.partitionmanager
    libinput
    lsof
    mesa-demos
    networkmanager
    nvtop
    pavucontrol
    pipewire-pulse
    powertop
    sudo
    vim
    vulkan-tools
    wget
    xdotool
  ];

  fonts.packages = with pkgs; [
    dejavu_fonts
    liberation_fonts
    noto-fonts
    noto-fonts-cjk
  ];

  hardware.bluetooth.enable = true;
  services.blueman.enable = true;
  services.avahi.enable = true;
}
