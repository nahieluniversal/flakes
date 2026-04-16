{ config, pkgs, lib, ... }:

{
  programs.hyprland.enable = true;

  services.displayManager.sddm = {
    enable = true;
    package = pkgs.kdePackages.sddm;  # Usa la versión Qt6 de SDDM
    theme = "where_is_my_sddm_theme";
    extraPackages = [
      pkgs.qt6.qt5compat
    ];
    wayland.enable = false;
  };

  environment.systemPackages = [
    (pkgs.where-is-my-sddm-theme.override { variants = [ "qt6" ]; })
  ];

  services.udisks2.enable = true;
}
