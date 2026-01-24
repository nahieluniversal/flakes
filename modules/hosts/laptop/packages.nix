{ config, pkgs, lib, ... }:

{
  environment.systemPackages = with pkgs; [
    adwaita-icon-theme
    android-tools
    alacritty
    ayugram-desktop
    baobab
    cabextract
    cliphist
    curl
    davinci-resolve-studio
    ddrescue
    edl
    exfatprogs
    fastfetch
    feh
    ffmpeg
    filezilla
    fzf
    gimp
    git
    go
    pkgs.godot
    gst_all_1.gst-libav
    gst_all_1.gst-plugins-bad
    gst_all_1.gst-plugins-base
    gst_all_1.gst-plugins-good
    gst_all_1.gst-plugins-ugly
    gtk3
    home-manager
    hyprnotify
    hyprpaper
    hyprpolkitagent
    hyprshot
    kdePackages.kate
    kdePackages.dolphin
    kdePackages.kservice
    kdePackages.ark
    kdePackages.okular
    kdePackages.partitionmanager
    keepassxc
    libnotify
    libreoffice-qt-fresh
    localsend
    lshw
    lshw-gui
    material-icons
    pkgs.mkvtoolnix
    mullvad-vpn
    p7zip
    patchelf
    pavucontrol
    qbittorrent
    rar
    rofi
    ryubing
    samrewritten
    scarab
    swww
    testdisk
    tldr
    unrar
    unzip
    usbutils
    vencord
    vesktop
    vim
    vlc
    vscode
    waybar
    wget
    wl-clipboard
    zenity
    zip
    zoxide
  ];

  fonts.packages = with pkgs; [
    font-awesome
  ];

  services.flatpak.enable = true;

  services.mullvad-vpn = {
    enable = true;
    package = pkgs.mullvad-vpn;
  };

  services.syncthing = {
    enable = true;
    openDefaultPorts = true;
    overrideDevices = false;
    overrideFolders = false;
  };
}
