{ config, pkgs, lib, ... }:

{
  # Home Manager needs a bit of information about you and the paths it should
  # manage.
  home.username = "olivernix";
  home.homeDirectory = "/home/olivernix";

  # This value determines the Home Manager release that your configuration is
  # compatible with. This helps avoid breakage when a new Home Manager release
  # introduces backwards incompatible changes.
  #
  # You should not change this value, even if you update Home Manager. If you do
  # want to update the value, then make sure to first check the Home Manager
  # release notes.
  home.stateVersion = "25.11"; # Please read the comment before changing.

  # The home.packages option allows you to install Nix packages into your
  # environment.
  home.packages = [
    # # Adds the 'hello' command to your environment. It prints a friendly
    # # "Hello, world!" when run.
    # pkgs.hello

    # # It is sometimes useful to fine-tune packages, for example, by applying
    # # overrides. You can do that directly here, just don't forget the
    # # parentheses. Maybe you want to install Nerd Fonts with a limited number of
    # # fonts?
    # (pkgs.nerdfonts.override { fonts = [ "FantasqueSansMono" ]; })

    # # You can also create simple shell scripts directly inside your
    # # configuration. For example, this adds a command 'my-hello' to your
    # # environment:
    # (pkgs.writeShellScriptBin "my-hello" ''
    #   echo "Hello, ${config.home.username}!"
    # '')
  ];

  # Home Manager is pretty good at managing dotfiles. The primary way to manage
  # plain files is through 'home.file'.
  home.file = {
    # # Building this configuration will create a copy of 'dotfiles/screenrc' in
    # # the Nix store. Activating the configuration will then make '~/.screenrc' a
    # # symlink to the Nix store copy.
    # ".screenrc".source = dotfiles/screenrc;

    # # You can also set the file content immediately.
    # ".gradle/gradle.properties".text = ''
    #   org.gradle.console=verbose
    #   org.gradle.daemon.idletimeout=3600000
    # '';
  };

  # Home Manager can also manage your environment variables through
  # 'home.sessionVariables'. These will be explicitly sourced when using a
  # shell provided by Home Manager. If you don't want to manage your shell
  # through Home Manager then you have to manually source 'hm-session-vars.sh'
  # located at either
  #
  #  ~/.nix-profile/etc/profile.d/hm-session-vars.sh
  #
  # or
  #
  #  ~/.local/state/nix/profiles/profile/etc/profile.d/hm-session-vars.sh
  #
  # or
  #
  #  /etc/profiles/per-user/olivernix/etc/profile.d/hm-session-vars.sh
  #
  home.sessionVariables = {
    # EDITOR = "emacs";
    TERM = "alacritty";
    XDG_CURRENT_DESKTOP = "Hyprland:KDE";
    XDG_SESSION_DESKTOP = "Hyprland";
    XDG_MENU_PREFIX = "";
    XDG_DATA_DIRS = lib.mkDefault (
      "${config.home.homeDirectory}/.local/share/flatpak/exports/share"
      + ":/var/lib/flatpak/exports/share"
      + ":${config.home.homeDirectory}/.nix-profile/share"
      + ":/etc/profiles/per-user/${config.home.username}/share"
      + ":/nix/var/nix/profiles/default/share"
      + ":/run/current-system/sw/share"
    );
  };

  home.activation.kbuildsycoca = lib.hm.dag.entryAfter [ "writeBoundary" ] ''
    /run/current-system/sw/bin/kbuildsycoca6 || true
  '';

  xdg.configFile."mimeapps.list".force = true;
  xdg.configFile."menus/applications.menu".text = ''
    <!DOCTYPE Menu PUBLIC "-//freedesktop//DTD Menu 1.0//EN"
      "http://www.freedesktop.org/standards/menu-spec/menu-1.0.dtd">
    <Menu>
      <Name>Applications</Name>
      <DefaultAppDirs/>
      <DefaultDirectoryDirs/>
      <DefaultMergeDirs/>
    </Menu>!
  '';
  xdg.configFile."hypr/hyprland.lua".source = ./.config/hypr/hyprland.lua;
  xdg.configFile."mpv/mpv.conf".source = ./.config/mpv/mpv.conf;
  xdg.configFile."dolphinrc".source = ./.config/dolphinrc;
  xdg = {
    enable = true;
    mimeApps = {
      enable = true;
      defaultApplications = {
        "inode/directory" = [ "org.kde.dolphin.desktop" ];

        "text/plain" = [ "org.kde.kate.desktop" ];

        "application/pdf" = [ "org.kde.okular.desktop" ];

        "image/png" = [ "feh.desktop" ];
        "image/jpeg" = [ "feh.desktop" ];
        "image/webp" = [ "feh.desktop" ];

        "audio/mpeg" = [ "mpv.desktop" ];
        "audio/flac" = [ "mpv.desktop" ];
        "audio/ogg" = [ "mpv.desktop" ];
        "video/mp4" = [ "mpv.desktop" ];
        "video/x-matroska" = [ "mpv.desktop" ];
        "video/x-msvideo" = [ "mpv.desktop" ];

        "application/zip" = [ "org.kde.ark.desktop" ];
        "application/x-7z-compressed" = [ "org.kde.ark.desktop" ];
        "application/x-rar" = [ "org.kde.ark.desktop" ];
        "application/x-tar" = [ "org.kde.ark.desktop" ];

        "application/vnd.openxmlformats-officedocument.wordprocessingml.document" = [ "libreoffice-writer.desktop" ];
        "application/vnd.openxmlformats-officedocument.spreadsheetml.sheet" = [ "libreoffice-calc.desktop" ];
        "application/vnd.openxmlformats-officedocument.presentationml.presentation" = [ "libreoffice-impress.desktop" ];
      };

      associations = {
        added = {
          "text/plain" = [ "org.kde.kate.desktop" "code.desktop" ];

          "application/pdf" = [ "org.kde.okular.desktop" ];

          "image/png" = [ "feh.desktop" "gimp.desktop" ];
          "image/jpeg" = [ "feh.desktop" "gimp.desktop" ];
          "image/webp" = [ "feh.desktop" "gimp.desktop" ];

          "audio/mpeg" = [ "mpv.desktop" ];
          "audio/flac" = [ "mpv.desktop" ];
          "audio/ogg" = [ "mpv.desktop" ];
          "video/mp4" = [ "mpv.desktop" ];
          "video/x-matroska" = [ "mpv.desktop" ];
          "video/x-msvideo" = [ "mpv.desktop" ];

          "application/zip" = [ "org.kde.ark.desktop" ];
          "application/x-7z-compressed" = [ "org.kde.ark.desktop" ];
          "application/x-rar" = [ "org.kde.ark.desktop" ];
          "application/x-tar" = [ "org.kde.ark.desktop" ];

          "application/vnd.openxmlformats-officedocument.wordprocessingml.document" = [ "libreoffice-writer.desktop" ];
          "application/vnd.openxmlformats-officedocument.spreadsheetml.sheet" = [ "libreoffice-calc.desktop" ];
          "application/vnd.openxmlformats-officedocument.presentationml.presentation" = [ "libreoffice-impress.desktop" ];
        };
      };
    };
  };

  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;
}
