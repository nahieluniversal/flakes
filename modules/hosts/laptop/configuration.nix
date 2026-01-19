# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ config, pkgs, lib, ... }:

{
  imports = [
    # Hardware
    ./hardware-configuration.nix
    ./hardware.nix
    
    # Display & Environment
    ./hyprland.nix
    
    # User & Shell
    ./user.nix
    
    # System configuration
    ./system.nix
    
    # Packages & Services
    ./packages.nix
    
    # Gaming
    ./gaming.nix
    
    # Common programs from flakes
    ../../programs/zen.nix
    ../../programs/opforjellyfin.nix
  ];
}
