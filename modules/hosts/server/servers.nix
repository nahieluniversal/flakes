{ pkgs, lib, config, ... }:

{
  services.shoko = {
    enable = true;
    openFirewall = true;
  };
  services.jellyfin = {
    enable = true;
    openFirewall = true;
   };
  # To prevent shoko and jellyfin from starting  automatically
  systemd.services.shoko.wantedBy = lib.mkForce [ ];
  systemd.services.jellyfin.wantedBy = lib.mkForce [ ];
  
}
