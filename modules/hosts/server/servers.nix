{ pkgs, lib, config, ... }:

{
  services.shoko = {
    enable = true;
    openFirewall = true;
  };
  #Tailscale
  services.tailscale = {
    enable = true;
    useRoutingFeatures = "server";
  };
  # To prevent shoko and jellyfin from starting  automatically
  systemd.services.shoko.wantedBy = lib.mkForce [ ];
  systemd.services.jellyfin.wantedBy = lib.mkForce [ ];
  
}
