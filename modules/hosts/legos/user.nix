# Lenovo Legion Go S - User Configuration
{ config, pkgs, lib, ... }:

{
  users.users.legos = {
    isNormalUser = true;
    home = "/home/legos";
    extraGroups = [ "wheel" "networkmanager" "audio" "video" "input" "uucp" ];
    shell = pkgs.zsh;
  };

  users.defaultUserShell = pkgs.zsh;

  # Zsh configuration
  programs.zsh = {
    enable = true;
    ohMyZsh = {
      enable = true;
      theme = "agnoster";
      plugins = [ "git" "docker" "docker-compose" "kubectl" "kubectx" "z" "zoxide" ];
    };
    shellAliases = {
      futaba = "sudo nixos-rebuild switch --flake /home/legos/flakes/#legos --max-jobs 2";
      hms = "home-manager switch --flake /home/legos/flakes/modules/hosts/legos/home-manager#legos";
      ncg = "sudo nix-collect-garbage -d";
      upd = "cd /home/legos/flakes && nix flake update && futaba";
    };
   shellInit = ''
      if [[ $- == *i* ]]; then
        fastfetch
      fi
    '';
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
