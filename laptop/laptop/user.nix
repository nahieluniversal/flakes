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
      futaba = "git add /home/olivernix/flakes/laptop/modules/hv/* --force && sudo nixos-rebuild switch --flake /home/olivernix/flakes/laptop/#laptop --max-jobs 2 && git restore --staged /home/olivernix/flakes/laptop/modules/hv/*";
      hms = "home-manager switch --flake /home/olivernix/flakes/laptop/home-manager#olivernix";
      ncg = "sudo nix-collect-garbage -d";
      upd = "git add /home/olivernix/flakes/laptop/modules/hv/* --force && cd /home/olivernix/flakes/laptop && nix flake update && sudo nixos-rebuild switch --flake /home/olivernix/flakes/laptop/#laptop --max-jobs 2 && git restore --staged /home/olivernix/flakes/laptop/modules/hv/*";
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
