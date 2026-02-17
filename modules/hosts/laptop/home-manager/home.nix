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
    </Menu>
  '';

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

        "audio/mpeg" = [ "vlc.desktop" ];
        "audio/flac" = [ "vlc.desktop" ];
        "audio/ogg" = [ "vlc.desktop" ];
        "video/mp4" = [ "vlc.desktop" ];
        "video/x-matroska" = [ "vlc.desktop" ];
        "video/x-msvideo" = [ "vlc.desktop" ];

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

          "audio/mpeg" = [ "vlc.desktop" ];
          "audio/flac" = [ "vlc.desktop" ];
          "audio/ogg" = [ "vlc.desktop" ];
          "video/mp4" = [ "vlc.desktop" ];
          "video/x-matroska" = [ "vlc.desktop" ];
          "video/x-msvideo" = [ "vlc.desktop" ];

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

  wayland.windowManager.hyprland = {
    enable = true;
    settings = {
      autogenerated = 0;

      monitor = [
        "eDP-1, 1920x1080@60.16Hz, 0x0, 1"
        ", preferred, auto, 1"
      ];

      "$terminal" = "alacritty";
      "$fileManager" = "dolphin";
      "$menu" = "wofi --show drun";

      exec-once = [
        "swaync"
        "/home/oliverlin/.config/hypr/xdph.sh"
        "systemctl --user start hyprpolkitagent"
        "hyprnotify"
        "hyprpaper"
        "waybar"
        "swww-daemon"
        "swww img \"/home/olivernix/.steam/steam/steamapps/common/Paper Lily - Chapter 1/EXTRA/Wallpapers/wp_poll_2024.png\""
        "qbittorrent"
        "kdeconnectd"
        "fcitx5"
        "polychromatic-tray-apple"
#        "docker compose -f /home/oliverlin/shoko_server/compose.yaml up -d"
#        "docker compose -f /home/oliverlin/containers/fmhy_mirror/edit/docker-compose.yaml up -d"
        "iwctl station wlan0 connect MiFibra-3020-5G"
        "wl-clip-persist --clipboard regular"
        "wl-paste --type text --watch cliphist store"
        "wl-paste --type image --watch cliphist store"
      ];

      exec = [
        "gsettings set org.gnome.desktop.interface gtk-theme \"arc-gtk-theme\""
        "gsettings set org.gnome.desktop.interface color-scheme \"prefer-dark\""
        "gsettings set org.gnome.desktop.interface color-scheme \"prefer-dark\""
        "gsettings set org.gnome.desktop.interface gtk-theme \"adw-gtk3\""
      ];

      env = [
        "QT_QPA_PLATFORMTHEME,qt6ct"
        "XCURSOR_THEME,miku-cursor-linux"
        "XCURSOR_SIZE,24"
        "HYPRCURSOR_SIZE,24"
        "LIBVA_DRIVER_NAME,nvidia"
        "__GLX_VENDOR_LIBRARY_NAME,nvidia"
        "QT_QPA_PLATFORMTHEME,qt6ct"
      ];

      general = {
        gaps_in = 5;
        gaps_out = 20;
        border_size = 2;
        "col.active_border" = "rgba(33ccffee) rgba(00ff99ee) 45deg";
        "col.inactive_border" = "rgba(595959aa)";
        resize_on_border = true;
        allow_tearing = false;
        layout = "dwindle";
      };

      decoration = {
        rounding = 10;
        rounding_power = 2;
        active_opacity = 1.0;
        inactive_opacity = 1.0;
        shadow = {
          enabled = true;
          range = 4;
          render_power = 3;
          color = "rgba(1a1a1aee)";
        };
        blur = {
          enabled = true;
          size = 3;
          passes = 1;
          vibrancy = 0.1696;
        };
      };

      animations = {
        enabled = "yes, please :)";
        bezier = [
          "easeOutQuint,0.23,1,0.32,1"
          "easeInOutCubic,0.65,0.05,0.36,1"
          "linear,0,0,1,1"
          "almostLinear,0.5,0.5,0.75,1.0"
          "quick,0.15,0,0.1,1"
        ];
        animation = [
          "global, 1, 10, default"
          "border, 1, 5.39, easeOutQuint"
          "windows, 1, 4.79, easeOutQuint"
          "windowsIn, 1, 4.1, easeOutQuint, popin 87%"
          "windowsOut, 1, 1.49, linear, popin 87%"
          "fadeIn, 1, 1.73, almostLinear"
          "fadeOut, 1, 1.46, almostLinear"
          "fade, 1, 3.03, quick"
          "layers, 1, 3.81, easeOutQuint"
          "layersIn, 1, 4, easeOutQuint, fade"
          "layersOut, 1, 1.5, linear, fade"
          "fadeLayersIn, 1, 1.79, almostLinear"
          "fadeLayersOut, 1, 1.39, almostLinear"
          "workspaces, 1, 1.94, almostLinear, fade"
          "workspacesIn, 1, 1.21, almostLinear, fade"
          "workspacesOut, 1, 1.94, almostLinear, fade"
        ];
      };

      dwindle = {
        pseudotile = true;
        preserve_split = true;
      };

      master = {
        new_status = "master";
      };

      misc = {
        force_default_wallpaper = -1;
        disable_hyprland_logo = false;
      };

      input = {
        kb_layout = "es";
        kb_variant = "";
        kb_model = "";
        kb_options = "";
        kb_rules = "";
        follow_mouse = 1;
        sensitivity = 0;
        touchpad = {
          natural_scroll = true;
        };
      };

      device = [
        {
          name = "epic-mouse-v1";
          sensitivity = -0.5;
        }
      ];

      "$mainMod" = "SUPER";

      bind = [
        "$mainMod, Q, exec, $terminal"
        "$mainMod, C, killactive,"
        "$mainMod, M, exit,"
        "$mainMod, E, exec, $fileManager"
        "$mainMod, F, togglefloating,"
        "$mainMod, R, exec, $menu"
        "$mainMod, P, pseudo,"
        "$mainMod, J, togglesplit,"
        "$mainMod, space , exec, rofi -show run"
        "$mainMod, W, exec, zen"
        ", PRINT,exec, hyprshot -m region -o /home/olivernix/Pictures/Screenshots"
        "shift, PRINT, exec, hyprshot -m window -o /home/olivernix/Pictures/Screenshots"
        "shift_control, PRINT, exec, hyprshot -m output -o /home/olivernix/Pictures/Screenshots"
        "$mainMod_SHIFT, C, forcekillactive"
        "$mainMod_SHIFT, M, exec, shutdown -h now"
        "$mainMod_SHIFT_CONTROL, M, exec, shutdown --reboot now"
        "$mainMod, V, exec, cliphist list | rofi -dmenu | cliphist decode | wl-copy"
        "$mainMod, L, exec, lutris"
        "$mainMod, P, exec, cliphist wipe"
        "$mainMod, left, movefocus, l"
        "$mainMod, right, movefocus, r"
        "$mainMod, up, movefocus, u"
        "$mainMod, down, movefocus, d"
        "$mainMod, 1, workspace, 1"
        "$mainMod, 2, workspace, 2"
        "$mainMod, 3, workspace, 3"
        "$mainMod, 4, workspace, 4"
        "$mainMod, 5, workspace, 5"
        "$mainMod, 6, workspace, 6"
        "$mainMod, 7, workspace, 7"
        "$mainMod, 8, workspace, 8"
        "$mainMod, 9, workspace, 9"
        "$mainMod, 0, workspace, 10"
        "$mainMod SHIFT, 1, movetoworkspace, 1"
        "$mainMod SHIFT, 2, movetoworkspace, 2"
        "$mainMod SHIFT, 3, movetoworkspace, 3"
        "$mainMod SHIFT, 4, movetoworkspace, 4"
        "$mainMod SHIFT, 5, movetoworkspace, 5"
        "$mainMod SHIFT, 6, movetoworkspace, 6"
        "$mainMod SHIFT, 7, movetoworkspace, 7"
        "$mainMod SHIFT, 8, movetoworkspace, 8"
        "$mainMod SHIFT, 9, movetoworkspace, 9"
        "$mainMod SHIFT, 0, movetoworkspace, 10"
        "$mainMod, S, togglespecialworkspace, magic"
        "$mainMod SHIFT, S, movetoworkspace, special:magic"
        "$mainMod, mouse_down, workspace, e+1"
        "$mainMod, mouse_up, workspace, e-1"
      ];

      bindm = [
        "$mainMod, mouse:272, movewindow"
        "$mainMod, mouse:273, resizewindow"
      ];

      bindel = [
        ",XF86AudioRaiseVolume, exec, wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%+"
        ",XF86AudioLowerVolume, exec, wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%-"
        ",XF86AudioMute, exec, wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle"
        ",XF86AudioMicMute, exec, wpctl set-mute @DEFAULT_AUDIO_SOURCE@ toggle"
        ",XF86MonBrightnessUp, exec, brightnessctl s 10%+"
        ",XF86MonBrightnessDown, exec, brightnessctl s 10%-"
      ];

      bindl = [
        ", XF86AudioNext, exec, playerctl next"
        ", XF86AudioPause, exec, playerctl play-pause"
        ", XF86AudioPlay, exec, playerctl play-pause"
        ", XF86AudioPrev, exec, playerctl previous"
      ];

      windowrule = [
        "match:class .*, suppress_event maximize"
        "match:title ^(Gamescope)$, maximize on"
        "match:class ^$, match:title ^$, match:xwayland 1, match:float 1, match:fullscreen 0, match:pin 0, no_focus on"
      ];
    };
  };

  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;
}
