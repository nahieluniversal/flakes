{ pkgs, system, twintaillauncher, ... }:
{
  environment.systemPackages = [
    (twintaillauncher.packages.${system}.default)
  ];
}
