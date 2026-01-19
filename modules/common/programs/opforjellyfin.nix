{ pkgs, ... }:

let
  opforjellyfin = pkgs.callPackage (pkgs.fetchFromGitHub {
    owner = "nahieluniversal";
    repo = "opforjellyfin_nix";
    rev = "28e2a785b0088d27769c186879c8643615708201";
    sha256 = "sha256-1uODr4nVHj+nrnQx7GT3gJ6eY0GHJX0EuajdrM+1k6Q=";
  }) { };
in

{
  environment.systemPackages = [
    opforjellyfin
  ];
}
