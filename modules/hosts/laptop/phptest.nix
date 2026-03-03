{ config, pkgs, lib, ... }:

{
  services.httpd = {
    enable = true;
    enablePHP = true;
    
    adminAddr = "admin@localhost";
    
    virtualHosts.localhost = {
      documentRoot = "/var/www/html";
      
      extraConfig = ''
        <Directory "/var/www/html">
          Options Indexes FollowSymLinks
          AllowOverride All
          Require all granted
        </Directory>
      '';
    };
  };

  services.phpfpm.phpPackage = pkgs.php;

  services.mysql = {
    enable = true;
    package = pkgs.mariadb;
    
    settings = {
      mysqld = {
        bind-address = "127.0.0.1";
        port = 3306;
      };
    };
  };

  services.phpMyAdmin = {
    enable = true;
    hostName = "localhost";
    settings = {
      blowfish_secret = "CHANGE_ME_TO_A_32_CHAR_SECRET!!!";
    };
  };

  systemd.tmpfiles.rules = [
    "d /var/www/html 0755 wwwrun wwwrun -"
  ];

  networking.firewall.allowedTCPPorts = [ 80 443 3306 ];
}
