{ pkgs, lib, config, ... }:

{
  services.jackett = {
    enable = true;
    openFirewall = true;
  };
  services.flaresolverr.enable = true;
  # To prevent shoko and jellyfin from starting  automatically
  systemd.services.shoko.wantedBy = lib.mkForce [ ];
  systemd.services.jellyfin.wantedBy = lib.mkForce [ ];
  
}
