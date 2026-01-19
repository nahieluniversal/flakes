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

  services.displayManager.sddm.enable = true;
  services.displayManager.sddm.wayland.enable = true;
  services.displayManager.sddm.settings = {
    General = {
      Session = "Hyprland.desktop";
    };
  };

  services.udisks2.enable = true;
}
