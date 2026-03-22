{ config, pkgs, lib, ... }:

{
  programs.steam = {
    enable = true;
    remotePlay.openFirewall = true;
    dedicatedServer.openFirewall = true;
    localNetworkGameTransfers.openFirewall = true;
    extraCompatPackages = with pkgs; [
      proton-ge-bin
    ];
    package = pkgs.steam.override {
      extraEnv = {
        LD_AUDIT = "/home/legos/.local/share/SLSsteam/library-inject.so:/home/legos/.local/share/SLSsteam/SLSsteam.so";
      };
    };
  };

  environment.systemPackages = with pkgs; [
    gamescope
    heroic
    lutris
    mangohud
    ppsspp
    prismlauncher
    protontricks
    winetricks
    wineWow64Packages.staging
  ];
  hardware.xpad-noone.enable = true;
}
