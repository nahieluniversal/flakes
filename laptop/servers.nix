{ pkgs, lib, config, ... }:

{
  services.jackett = {
    enable = true;
    openFirewall = true;
  };
  services.flaresolverr.enable = true;
  programs.openvpn3.enable = true;
  networking.networkmanager.plugins = [pkgs.networkmanager-openvpn];
  # To prevent shoko and jellyfin from starting  automatically
  #systemd.services.shoko.wantedBy = lib.mkForce [ ];
  #systemd.services.jellyfin.wantedBy = lib.mkForce [ ];
  
}
