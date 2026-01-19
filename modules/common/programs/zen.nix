{ pkgs, system, zen-browser, ... }:

{
  environment.systemPackages = [
    (zen-browser.packages.${system}.default)
  ];
}
