{ pkgs, system, opforjellyfin, ... }:
{
  environment.systemPackages = [
    (opforjellyfin.packages.${system}.default)
  ];
}
