{ config, pkgs, lib, ... }:

{
  environment.systemPackages = with pkgs; [
    adwaita-icon-theme
    android-tools
    alacritty
    aria2
    aseprite
    ayugram-desktop
    awww
    baobab
    brightnessctl
    cabextract
    calibre
    cliphist
    compose2nix
    curl
    davinci-resolve-studio
    ddrescue
    distrobox
    edl
    eden
    exfatprogs
    fastfetch
    kdePackages.fcitx5-configtool
    feh
    ffmpeg
    filezilla
    fzf
    gimp
    git
    go
    godot
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
    itch
    jdk21
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
    megabasterd
    mkvtoolnix
    mpv
    mullvad-vpn
    olympus
    p7zip
    patchelf
    pavucontrol
    pdfchain
    protonup-qt
    qbittorrent
    rar
    rofi
    ryubing
    samrewritten
    scarab
    stirling-pdf-desktop
    supertuxkart
    testdisk
    tealdeer
    tree
    unrar
    unzip
    usbutils
    vencord
    vesktop
    vim
    vscodium
    waybar
    wget
    wl-clipboard
    yt-dlp
    zenity
    zip
  ];

  fonts.packages = with pkgs; [
    font-awesome
  ];

  services.flatpak.enable = true;
  programs.ydotool.enable = true;
  services.mullvad-vpn = {
    enable = true;
    package = pkgs.mullvad-vpn;
  };
}
