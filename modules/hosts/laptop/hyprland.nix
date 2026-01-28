{ config, pkgs, lib, ... }:

{
  programs.hyprland.enable = true;

  environment.etc."wayland-sessions/Hyprland.desktop".text = ''
    [Desktop Entry]
    Name=Hyprland
    Comment=Hyprland Wayland compositor
    Exec=dbus-run-session Hyprland
    Type=Application
  '';

  services.displayManager.sddm = {
    enable = true;
    package = pkgs.kdePackages.sddm;  # Usa la versión Qt6 de SDDM
    theme = "where_is_my_sddm_theme_qt6";
    wayland.enable = true;
    settings = {
      General = {
        Session = "Hyprland.desktop";
      };
    };
  };

  environment.systemPackages = with pkgs; [
    (where-is-my-sddm-theme.override { variants = [ "qt6" ]; })
  ];

  services.udisks2.enable = true;
}
