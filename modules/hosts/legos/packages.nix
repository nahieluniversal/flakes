{ config, pkgs, lib, ... }:

{
  environment.systemPackages = with pkgs; [
    git
    wget
    curl
    htop
    tmux
    vim
    sudo
    libinput
    xdotool
    evtest
    pavucontrol
    pipewire-pulse
    lsof
    glxinfo
    vulkan-tools
    mesa-demos
    networkmanager
    iw
    powertop
    acpi
    alacritty
    nvtop
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
