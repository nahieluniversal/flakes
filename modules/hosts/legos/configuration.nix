{ config, pkgs, lib, ... }:

{
  imports = [
    # Hardware
    ./hardware-configuration.nix
    ./hardware-extra.nix
    
    # User & Shell
    ./user.nix
    
    # System configuration
    ./system.nix
    
    # Packages & Services
    ./packages.nix
    ./../../programs/zen.nix
    # Gaming
    ./gaming.nix
  ];
}
