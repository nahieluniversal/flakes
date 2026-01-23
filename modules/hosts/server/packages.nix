{ config, pkgs, lib, ... }:

{
  environment.systemPackages = with pkgs; [
    cabextract
    curl
    ddrescue
    exfatprogs
    fastfetch
    ffmpeg
    filezilla
    fzf
    git
    go
    gst_all_1.gst-libav
    gst_all_1.gst-plugins-bad
    gst_all_1.gst-plugins-base
    gst_all_1.gst-plugins-good
    gst_all_1.gst-plugins-ugly
    home-manager
    lshw
    mkvtoolnix
    mullvad-vpn
    p7zip
    patchelf
    qbittorrent
    rar
    testdisk
    tldr
    unrar
    unzip
    usbutils
    vim
    wget
    zenity
    zip
    zoxide
  ];

  #fonts.packages = with pkgs; [
  #];

  #services.flatpak.enable = true;

  services.mullvad-vpn = {
    enable = true;
    package = pkgs.mullvad-vpn;
  };

#  services.syncthing = {
#    enable = true;
#    openDefaultPorts = true;
#    overrideDevices = false;
#    overrideFolders = false;
#  };
}
