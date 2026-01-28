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
    theme = "where_is_my_sddm_theme_qt5";
    wayland.enable = true;
    settings = {
      General = {
        Session = "Hyprland.desktop";
      };
    };
  };

  services.udisks2.enable = true;
}
