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
        LD_AUDIT = "/home/olivernix/.local/share/SLSsteam/library-inject.so:/home/olivernix/.local/share/SLSsteam/SLSsteam.so";
      };
    };
  };

  # Gaming-related packages
  environment.systemPackages = with pkgs; [
    gamescope
    heroic
    lutris
    mangohud
    ppsspp
    prismlauncher
    protontricks
    winetricks
    wineWowPackages.staging
  ];
  hardware.xpad-noone.enable = true;
}
