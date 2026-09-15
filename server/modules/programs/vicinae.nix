{ system, vicinae, ... }:

{
  environment.systemPackages = [
    vicinae.packages.${system}.default
  ];
}
