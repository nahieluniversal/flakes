{ config, pkgs, lib, ... }:

{
  services.httpd = {
    enable = true;
    enablePHP = true;
    phpPackage = pkgs.php83.withExtensions ({ all }: with all; [
      mysqli
      pdo
      pdo_mysql
      curl
      mbstring
    ]);  # PHP 8.3 con extensiones para MySQL
    
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

  services.phpfpm.phpPackage = pkgs.php83.withExtensions ({ all }: with all; [
    mysqli
    pdo
    pdo_mysql
    curl
    mbstring
  ]);

  services.mysql = {
    enable = true;
    package = pkgs.mariadb;
    
    settings = {
      mysqld = {
        skip-networking = true;
      };
    };

    ensureUsers = [
      {
        name = "root";
        ensurePermissions = {
          "*.*" = "ALL PRIVILEGES";
        };
      }
    ];
  };

  services.phpMyAdmin = {
    enable = true;
    hostName = "localhost";
    user = "root";
    password = "";
    settings = {
      blowfish_secret = "CHANGE_ME_TO_A_32_CHAR_SECRET!!!";
    };
  };

  systemd.tmpfiles.rules = [
    "d /var/www/html 0755 wwwrun wwwrun -"
  ];

  networking.firewall.allowedTCPPorts = [ 80 443 3306 ];
}
