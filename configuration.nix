# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ config, pkgs, lib, ... }:

{
  imports =
    [ # Include the results of the hardware scan.
      ./hardware-configuration.nix
    ];

  # Bootloader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  # Use latest kernel.
  boot.kernelPackages = pkgs.linuxPackages;

  networking.hostName = "nixos"; # Define your hostname.
  # networking.wireless.enable = true;  # Enables wireless support via wpa_supplicant.

  # Configure network proxy if necessary
  # networking.proxy.default = "http://user:password@proxy:port/";
  # networking.proxy.noProxy = "127.0.0.1,localhost,internal.domain";

  # Enable networking
  networking.networkmanager.enable = true;
  networking.firewall.allowedTCPPorts = [ 80 443 1401 2200 47984 47989 47990 48010 53317 53318 ];
  networking.firewall.allowedUDPPorts = [ 53 1194 1195 1196 1197 1300 1301 1302 1303 1400 47984 47989 47990 48010 53317 53318 ];
  networking.nameservers = [ "1.1.1.1#one.one.one.one" "1.0.0.1#one.one.one.one" ];

services.resolved = {
  enable = true;
  dnssec = "true";
  domains = [ "~." ];
  fallbackDns = [ "1.1.1.1#one.one.one.one" "1.0.0.1#one.one.one.one" ];
  dnsovertls = "true";
  };


  # Set your time zone.
  time.timeZone = "Europe/Madrid";

  # Select internationalisation properties.
  i18n.defaultLocale = "es_ES.UTF-8";

  i18n.extraLocaleSettings = {
    LC_ADDRESS = "es_ES.UTF-8";
    LC_IDENTIFICATION = "es_ES.UTF-8";
    LC_MEASUREMENT = "es_ES.UTF-8";
    LC_MONETARY = "es_ES.UTF-8";
    LC_NAME = "es_ES.UTF-8";
    LC_NUMERIC = "es_ES.UTF-8";
    LC_PAPER = "es_ES.UTF-8";
    LC_TELEPHONE = "es_ES.UTF-8";
    LC_TIME = "es_ES.UTF-8";
  };
  # Configure console keymap
  console.keyMap = "es";

  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.
olivernix = {
    isNormalUser = true;
    description = "olivernix";
    extraGroups = [ "networkmanager" "wheel" "video" "docker" "plugdev" "audio" "openrazer" ];
    packages = with pkgs; [];
  };

  # Allow unfree packages
  nixpkgs.config.allowUnfree = true;
  #Flakes
  nix.settings = {
  experimental-features = [ "nix-command" "flakes"];
  auto-optimise-store = true;
  };
  nix.gc = {
  automatic = true;
  dates = "weekly";
  options = "--delete-older-than 7d";
  };
  services.mullvad-vpn = {
  enable = true;
  package = pkgs.mullvad-vpn;
  };
  services.btrfs.autoScrub = {
  enable = true;
  fileSystems = [ "/home" ];
  interval = "weekly";
  };
  hardware.openrazer.enable = true;
  #VirtualBox
  virtualisation.virtualbox.host.enable = true;
  users.extraGroups.vboxusers.members = [ "olivernix" ];
  virtualisation.virtualbox.host.enableExtensionPack = true;
  # List packages installed in system profile. To search, run:
  # $ nix search wget
  environment.systemPackages = with pkgs; [
    #(callPackage /home/olivernix/flakes/sddm-themes.nix {})
    vim
    wget
    kdePackages.dolphin
    kdePackages.kate
    waybar
    pkgs.alacritty
    pkgs.localsend
    pkgs.rofi
    pkgs.hyprshot
    pkgs.hyprpaper
    pkgs.hyprnotify
    pkgs.hyprpolkitagent
    pkgs.ppsspp
    pkgs.vlc
    pkgs.lshw-gui
    pkgs.lshw
    ffmpeg
    gst_all_1.gst-plugins-base
    gst_all_1.gst-plugins-good
    gst_all_1.gst-plugins-bad
    gst_all_1.gst-plugins-ugly
    gst_all_1.gst-libav
    pkgs.cliphist
    pkgs.pavucontrol
    pkgs.wl-clipboard
    font-awesome
    material-icons
    adwaita-icon-theme
    pkgs.lutris
    pkgs.heroic
    pkgs.ryubing
    pkgs.swww
    pkgs.vencord
    pkgs.mullvad-vpn
    pkgs.qbittorrent
    keepassxc
    pkgs.fastfetch
    pkgs.kdePackages.ark
    pkgs.libnotify
    pkgs.zenity
    pkgs.davinci-resolve-studio
    wineWowPackages.staging
    pkgs.gtk3
    pkgs.kdePackages.partitionmanager
    pkgs.exfatprogs
    pkgs.filezilla
    pkgs.ddrescue
    pkgs.testdisk
    pkgs.zip
    pkgs.unzip
    pkgs.libreoffice-qt-fresh
    pkgs.rar
    pkgs.unrar
    pkgs.gimp
    pkgs.feh
    pkgs.kdePackages.okular
    pkgs.p7zip
    pkgs.cabextract
    pkgs.winetricks
    pkgs.protontricks
    pkgs.vscode
    pkgs.git
    pkgs.vesktop
    pkgs.kdePackages.kservice
    pkgs.ayugram-desktop
    pkgs.patchelf
    pkgs.jdk25_headless
    pkgs.android-tools
    pkgs.gamescope
    pkgs.mangohud
    pkgs.go
    pkgs.zoxide
    pkgs.fzf
    pkgs.prismlauncher
    pkgs.curl
    pkgs.baobab
    pkgs.python312
    pkgs.scarab
    pkgs.samrewritten
  ];
  services.flatpak.enable = true;
  programs.steam = {
  enable = true;
  remotePlay.openFirewall = true; #pkgs.flatpak Open ports in the firewall for Steam Remote Play
  dedicatedServer.openFirewall = true; # Open ports in the firewall for Source Dedicated Server
  localNetworkGameTransfers.openFirewall = true;
  extraCompatPackages = with pkgs; [
  proton-ge-bin
    ];
  };
virtualisation.docker = {
  enable = true;
};
virtualisation.waydroid = {
    enable = true;
    package = pkgs.waydroid-nftables;
  };
hardware.bluetooth.enable = true;
services.blueman.enable = true;
    # rtkit (optional, recommended) allows Pipewire to use the realtime scheduler for increased performance.
  hardware.graphics.enable32Bit = true;
  security.rtkit.enable = true;
  services.pulseaudio.enable = false;
  services.pipewire = {
    enable = true; # if not already enabled
    alsa.enable = true;
    wireplumber.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
    #systemWide = true;
    # If you want to use JACK applications, uncomment the following
    #jack.enable = true;
  };
  #nvidia
  hardware.graphics = {
  enable = true;
  };
  hardware.nvidia = {
  modesetting.enable = true;
  powerManagement.enable = true;
  powerManagement.finegrained = true;
  open = false;
  nvidiaSettings = true;
  package = config.boot.kernelPackages.nvidiaPackages.stable;
  };
  services.xserver.videoDrivers = [
    "amdgpu"
    "nvidia"
  ];
  hardware.nvidia.prime ={
    offload = {
      enable = true;
      enableOffloadCmd = true;
    };
    amdgpuBusId = "PCI:5:0:0";
    nvidiaBusId = "PCI:1:0:0";
  };
  programs.hyprland.enable = true;
  environment.etc."wayland-sessions/Hyprland.desktop".text = ''
	[Desktop Entry]
	Name=Hyprland
	Comment=Hyprland Wayland compositor
	Exec=dbus-run-session Hyprland
	Type=Application
  '';
  services.displayManager.sddm.wayland.enable = true;
  security.polkit.enable = true ;
  services.udisks2.enable = true ;
  #services.xserver.enable = true;
  services.displayManager.sddm.enable = true;
  services.displayManager.sddm.settings = {
    General = {
	Session = "Hyprland.desktop";
  };
};
  # Some programs need SUID wrappers, can be configured further or are
  # started in user sessions.
  # programs.mtr.enable = true;
  # programs.gnupg.agent = {
  #   enable = true;
  #   enableSSHSupport = true;
  # };

  # List services that you want to enable:

  # Enable the OpenSSH daemon.
  # services.openssh.enable = true;

  # Open ports in the firewall.
  # networking.firewall.allowedTCPPorts = [ ... ];
  # networking.firewall.allowedUDPPorts = [ ... ];
  # Or disable the firewall altogether.
  # networking.firewall.enable = false;

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "25.11"; # Did you read the comment?

}
