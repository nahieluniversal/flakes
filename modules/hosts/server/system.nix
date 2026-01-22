{ config, pkgs, lib, ... }:

{
  # Bootloader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  # Use latest kernel.
  boot.kernelPackages = pkgs.linuxPackages;

  # Networking
  networking.hostName = "server";
  networking.networkmanager.enable = true;
  networking.firewall.allowedTCPPorts = [ 22 80 443 1401 2200 47984 47989 47990 48010 53317 53318 ];
  networking.firewall.allowedUDPPorts = [ 53 1194 1195 1196 1197 1300 1301 1302 1303 1400 47984 47989 47990 48010 53317 53318 ];
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
  fileSystems."/media" = {
    device = "/dev/disk/by-uuid/16e95dc7-12da-47bc-90dd-4ec419d895e4";
    fsType = "ext4";
    options = [ "noauto" "x-systemd.automount" "x-systemd.idle-timeout=60" ];
    neededForBoot = false;
  };
  systemd.tmpfiles.rules = [
    "d /media 0755 root root -"
  ];
  # Logind configuration
  services.logind.lidSwitch = "ignore";
  services.logind.lidSwitchDocked = "ignore";

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

  console.keyMap = "es";

  # Nix settings
  nixpkgs.config.allowUnfree = true;
  nix.settings = {
    experimental-features = [ "nix-command" "flakes" ];
    auto-optimise-store = true;
    allowed-users = [ "olivernix" "root" ];
  };
  services.openssh = {
	enable = true;
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
  #Tailscale
  services.tailscale.enable = true;
  services.jellyfin = {
    enable = true;
    openFirewall = true;
  };
  virtualisation.docker = {
  enable = true;
  };
  # State version
  system.stateVersion = "26.05";
}
