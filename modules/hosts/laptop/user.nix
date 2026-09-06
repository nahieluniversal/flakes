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
      futaba = "git add /home/olivernix/flakes/modules/hv/* --force && sudo nixos-rebuild switch --flake /home/olivernix/flakes/#laptop --max-jobs 2 && git restore --staged /home/olivernix/flakes/modules/hv/*";
      hms = "home-manager switch --flake /home/olivernix/flakes/modules/hosts/laptop/home-manager#olivernix";
      ncg = "sudo nix-collect-garbage -d";
      upd = "git add /home/olivernix/flakes/modules/hv/* --force && cd /home/olivernix/flakes && nix flake update && sudo nixos-rebuild switch --flake /home/olivernix/flakes/#laptop --max-jobs 2 && git restore --staged /home/olivernix/flakes/modules/hv/*";
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
