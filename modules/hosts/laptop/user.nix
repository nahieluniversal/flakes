{ config, pkgs, lib, ... }:

{
  # Zsh configuration
  programs.zsh = {
    enable = true;
    ohMyZsh = {
      enable = true;
      theme = "agnoster";
      plugins = [ "git" "docker" "docker-compose" "kubectl" "kubectx" "z" "zoxide" ];
    };
    shellAliases = {
      futaba = "sudo nixos-rebuild switch --flake /home/olivernix/flakes/#laptop";
      cd = "z";
      ncg = "sudo nix-collect-garbage -d";
      jds = "docker start jdownloader-2";
      upd = "cd /home/olivernix/flakes && nix flake update && futaba";
    };
    shellInit = ''
      fastfetch
    '';
  };

  # Define a user account
  users.users.olivernix = {
    isNormalUser = true;
    description = "olivernix";
    extraGroups = [ "networkmanager" "wheel" "video" "docker" "plugdev" "audio" "openrazer" ];
    packages = with pkgs; [ ];
    shell = pkgs.zsh;
  };
}
