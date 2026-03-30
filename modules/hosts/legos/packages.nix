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
    keepassxc
    libinput
    lsof
    mesa-demos
    mpv
    networkmanager
    nvtop
    olympus
    pavucontrol
    pipewire-pulse
    protonup-qt
    powertop
    ryubing
    samrewritten
    scarab
    supertuxkart
    sudo
    tealdeer
    tree
    usbutils
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
  services.flatpak.enable = true;
  services.mullvad-vpn = {
    enable = true;
    package = pkgs.mullvad-vpn;
  };
  services.avahi.enable = true;
}
