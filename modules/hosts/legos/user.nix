# Lenovo Legion Go S - User Configuration
{ config, pkgs, lib, ... }:

{
  users.users.olivernix = {
    isNormalUser = true;
    home = "/home/olivernix";
    extraGroups = [ "wheel" "networkmanager" "audio" "video" "input" "uucp" ];
    shell = pkgs.zsh;
  };

  users.defaultUserShell = pkgs.zsh;

  programs.zsh = {
    enable = true;
  };

  system.activationScripts = {
    ensure-user-data = lib.stringAfter [ "users" ] ''
      mkdir -p /home/legos/.cache
      mkdir -p /home/legos/.config
      mkdir -p /home/legos/.local/share
      chown -R legos:users /home/legos
    '';
  };
}
