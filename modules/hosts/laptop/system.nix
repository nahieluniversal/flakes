{ config, pkgs, lib, nix-cachyos-kernel, ... }:

{
  # Bootloader.
  boot.loader.grub = {
    enable = true;
    device = "nodev";
    efiSupport = true;
    useOSProber = true;
  };
  boot.loader.efi.canTouchEfiVariables = true;

  # Use latest kernel.
  boot.kernelPackages = pkgs.cachyosKernels.linuxPackages-cachyos-latest-lto-x86_64-v3;
  boot.kernelModules = [ "uinput" "usbhid" "joydev" ];
  boot.kernelParams = [ "sched=bore" ];
  services.udev.extraRules = ''
    # Input devices
    KERNEL=="uinput", MODE="0660", GROUP="input"
    
    # USB devices - General access
    SUBSYSTEM=="usb", GROUP="plugdev", MODE="0660"
    SUBSYSTEM=="usb_device", GROUP="plugdev", MODE="0660"
    
    # USB storage
    SUBSYSTEM=="usb_device", ENV{DEVTYPE}=="usb_device", GROUP="plugdev", MODE="0660"
    KERNEL=="sd?", SUBSYSTEM=="block", GROUP="plugdev", MODE="0660"
    
    # USB serial devices
    SUBSYSTEM=="tty", ATTRS{idVendor}=="*", GROUP="plugdev", MODE="0660"
    
    # Generic USB monitoring
    KERNEL=="usbmon*", GROUP="plugdev", MODE="0640"
  '';
  services.udev.packages = [
    pkgs.ydotool
  ];
  # Networking
  networking.hostName = "laptop";
  networking.networkmanager.enable = true;
  networking.firewall.allowedTCPPorts = [ 22 80 443 1401 2200 2234 8111 47984 47989 47990 48010 53317 53318 ];
  networking.firewall.allowedUDPPorts = [ 53 1194 1195 1196 1197 1300 1301 1302 1303 1400 2234 47984 47989 47990 48010 53317 53318 ];
  networking.nameservers = [ "1.1.1.1#one.one.one.one" "1.0.0.1#one.one.one.one" ];

  services.resolved = {
    enable = true;
    settings.Resolve = {
      dnssec = "true";
      domains = [ "~." ];
      fallbackDns = [ "1.1.1.1#one.one.one.one" "1.0.0.1#one.one.one.one" ];
      dnsovertls = "true";
    };
  };
   # Laptop Lid Config (Comment to enable suspend on lid close)
   services.logind.settings.Login = {
    HandleLidSwitch = "ignore";
    HandleLidSwitchDocked = "ignore";
   };
  services.xserver.enable = true;
  #OpenSSH
  services.openssh.enable = true;
  # Timezone and locale
  time.timeZone = "Europe/Madrid";
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
  nix.settings.cores = 4;
  i18n.inputMethod = {  
    enable = true;
    type = "fcitx5";
    fcitx5 = {
      addons = with pkgs; [
        fcitx5-mozc
        fcitx5-gtk
      ];
      waylandFrontend = true;
    };
  };
  console.keyMap = "es";

  # Nix settings
  nixpkgs.config.allowUnfree = true;
  nix.settings = {
    experimental-features = [ "nix-command" "flakes" ];
    auto-optimise-store = true;
    substituters = [ "https://attic.xuyh0120.win/lantian" "https://vicinae.cachix.org" ];
    trusted-public-keys = [ "lantian:EeAUQ+W+6r7EtwnmYjeVwx5kOGEBpjlBfPlzGlTNvHc=" "vicinae.cachix.org-1:1kDrfienkGHPYbkpNj1mWTr7Fm1+zcenzgTizIcI3oc="];
    allowed-users = [ "olivernix" "root" ];
  };

  nix.gc = {
    automatic = true;
    dates = "weekly";
    options = "--delete-older-than 7d";
  };

  # Security
  security.polkit.enable = true;
  security.rtkit.enable = true;

  # Storage
  services.btrfs.autoScrub = {
    enable = true;
    fileSystems = [ "/home" ];
    interval = "weekly";
  };
  programs.nix-ld.enable = true;
  services.tailscale.enable = true;
  virtualisation = {
    podman = {
      enable = true;
    };
    docker = {
      enable = true;
      extraOptions = "--group-add plugdev";
      storageDriver = "btrfs";
    };
  };
#Appimage support
programs.appimage.enable = true;
programs.appimage.binfmt = true;
programs.appimage.package = pkgs.appimage-run.override 
{
  extraPkgs = pkgs: 
  [
    pkgs.icu
  ]; 
};

  # State version
  system.stateVersion = "25.11";
}
