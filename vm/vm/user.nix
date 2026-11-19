{ config, pkgs, lib, ... }:

{
  # Zsh configuration
  programs.zsh = {
    enable = true;
    ohMyZsh = {
      enable = true;
      theme = "agnoster";
      plugins = [ "git" "docker" "docker-compose" "kubectl" "kubectx" ];
    };
    shellAliases = {
      futaba = "sudo nixos-rebuild switch --flake /home/olivernix/flakes/vm/#vm --max-jobs 2";
      hms = "home-manager switch --flake /home/olivernix/flakes/vm/home-manager#olivernix";
      ncg = "sudo nix-collect-garbage -d";
      upd = "cd /home/olivernix/flakes/vm && nix flake update && sudo nixos-rebuild switch --flake /home/olivernix/flakes/vm/#vm --max-jobs 2";
    };
   shellInit = ''
      if [[ $- == *i* ]]; then
        fastfetch
      fi
    '';
  };

  # Define a user account
  users.users.olivernix = {
    isNormalUser = true;
    description = "olivernix";
    extraGroups = [ "networkmanager" "wheel" "video" "docker" "plugdev" "audio" "ydotool" "input" "dialout" "tty" "render"];
    packages = with pkgs; [ ];
    shell = pkgs.zsh;
  };
  #hardware.openrazer.users = ["olivernix" ];
}
