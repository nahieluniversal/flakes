{ config, pkgs, lib, ... }:

let
  phpPackage = pkgs.php83.withExtensions ({ all }: with all; [
    mysqli
    pdo
    pdo_mysql
    curl
    mbstring
  ]);
in
{
  services.httpd = {
    enable = true;
    adminAddr = "admin@localhost";
    extraModules = [ "proxy_fcgi" ];
    
    virtualHosts.localhost = {
      documentRoot = "/var/www/html";
      
      extraConfig = ''
        <Directory "/var/www/html">
          Options Indexes FollowSymLinks
          AllowOverride All
          Require all granted
        </Directory>
        
        <FilesMatch "\.php$">
          <If "-f %{REQUEST_FILENAME}">
            SetHandler "proxy:unix:${config.services.phpfpm.pools.www.socket}|fcgi://localhost/"
          </If>
        </FilesMatch>
        
        # phpMyAdmin en /phpmyadmin
        Alias /phpmyadmin "/var/www/phpmyadmin"
        <Directory "/var/www/phpmyadmin">
          Options Indexes FollowSymLinks
          AllowOverride All
          Require all granted
          
          <FilesMatch "\.php$">
            <If "-f %{REQUEST_FILENAME}">
              SetHandler "proxy:unix:${config.services.phpfpm.pools.www.socket}|fcgi://localhost/"
            </If>
          </FilesMatch>
        </Directory>
      '';
    };
  };

  services.phpfpm.pools.www = {
    user = "wwwrun";
    group = "wwwrun";
    phpPackage = phpPackage;
    settings = {
      "pm" = "dynamic";
      "pm.max_children" = 32;
      "pm.start_servers" = 2;
      "pm.min_spare_servers" = 2;
      "pm.max_spare_servers" = 4;
      "pm.max_requests" = 500;
      "listen.owner" = "wwwrun";
      "listen.group" = "wwwrun";
      "listen.mode" = "0660";
    };
  };
  
  systemd.services.phpfpm.after = [ "network.target" ];
  systemd.services.phpfpm.wantedBy = [ "multi-user.target" ];

  services.mysql = {
    enable = true;
    package = pkgs.mariadb;
    
    settings = {
      mysqld = {
        skip-networking = true;
        bind-address = "127.0.0.1";
        skip-name-resolve = true;
        max_connections = 50;
        max_allowed_packet = "16M";
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

  systemd.tmpfiles.rules = [
    "d /var/www/html 0755 wwwrun wwwrun -"
    "d /var/www/phpmyadmin 0755 wwwrun wwwrun -"
  ];

  # Para instalar phpMyAdmin, ejecuta:
  # cd /var/www && wget https://files.phpmyadmin.net/phpMyAdmin/5.2.1/phpMyAdmin-5.2.1-all-languages.tar.gz
  # tar -xzf phpMyAdmin-5.2.1-all-languages.tar.gz && mv phpMyAdmin-* phpmyadmin
  # chown -R wwwrun:wwwrun phpmyadmin

  networking.firewall.allowedTCPPorts = [ 80 443 3306 ];
}
