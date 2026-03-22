{ config, pkgs, lib, nix-cachyos-kernel, ... }:

{
  nixpkgs.overlays = [
              # Use nixpkgs from your environment, nixpkgs.config will apply.
              # Has small chance of kernel modules not being compatible with kernel version.
              nix-cachyos-kernel.overlays.default

              # Alternatively, use the exact nixpkgs revison as defined in this repo.
              # Guarantees you have binary cache, but initializes another nixpkgs instance.
              # nix-cachyos-kernel.overlays.pinned

              # Only use one of the two overlays!
            ];
  # Bootloader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  # Use latest kernel.
  boot.kernelPackages = pkgs.cachyosKernels.linuxPackages-cachyos-latest-lto-x86_64-v3;
  boot.kernelParams = [ "sched=bore" ];

  # Networking
  networking.hostName = "laptop";
  networking.networkmanager.enable = true;
  networking.firewall.allowedTCPPorts = [ 22 80 443 1401 2200 8111 47984 47989 47990 48010 53317 53318 ];
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

  console.keyMap = "es";

  # Nix settings
  nixpkgs.config.allowUnfree = true;
  nix.settings = {
    experimental-features = [ "nix-command" "flakes" ];
    auto-optimise-store = true;
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
  services.jellyfin = {
     enable = true;
     openFirewall = true;
   };
  # State version
  system.stateVersion = "25.11";
}
