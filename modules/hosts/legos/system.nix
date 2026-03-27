{ config, pkgs, lib, nix-cachyos-kernel, ... }:

{
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;
  boot.loader.timeout = 3;
  boot.kernelPackages = pkgs.cachyosKernels.linuxPackages-cachyos-deckify-lts-lto;
  boot.kernelParams = [ 
    "sched=bore"
    "amd_pmc.enable_restore=0" 
    "pcie_aspm=off"
    "quiet"
    "splash"
    "console=/dev/null"              
  ];

  boot.extraModprobeConfig = ''
    options kvm_intel nested=1
    options snd slots=snd_hda_intel
    options snd_hda_intel enable_msi=1
  '';

  networking.hostName = "legos";
  networking.networkmanager.enable = true;
  networking.firewall.enable = true;
  services.openssh.enable = true;
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
  nixpkgs.config.allowUnfree = true;
  nix.settings = {
    experimental-features = [ "nix-command" "flakes" ];
    auto-optimise-store = true;
  };

  nix.gc = {
    automatic = true;
    dates = "weekly";
    options = "--delete-older-than 7d";
  };

  security.polkit.enable = true;
  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    pulse.enable = true;
  };
  # Clean Quiet Boot
  boot = {
    plymouth.enable = true;
  };

  programs = {
    gamescope = {
      enable = true;
      capSysNice = true;
    };
    steam.gamescopeSession.enable = true;
  };

  # Gamescope Auto Boot from TTY (nix docs test)
  services = {
    xserver.enable = true;
    getty.autologinUser = <"legos">;
    greetd = {
      enable = true;
      settings = {
        default_session = {
          command = "${lib.getExe pkgs.gamescope} -W 1920 -H 1200 -f -e --xwayland-count 2 --hdr-enabled --hdr-itm-enabled -- steam -pipewire-dmabuf -gamepadui -steamdeck -steamos3 > /dev/null 2>&1";
          user = <"legos">;
        };
      };
    };
  };
  programs.dconf.enable = true;
  system.stateVersion = "26.05";
}
