{pkgs, ...}: {
  imports = [
    ./common.nix
    ./addons/hyprlock.nix
    ./addons/waybar.nix
  ];

  home.packages = with pkgs; [
    playerctl
  ];

  services.gnome-keyring = {
    enable = true;
    components = [
      "ssh"
      "secrets"
      "pkcs11"
    ];
  };

  wayland.windowManager.hyprland = {
    enable = true;
    systemd.enable = true;
    settings = {
      # Monitors
      monitor = [
        ",preferred,auto,auto"
      ];

      # Variables - Programs
      "$terminal" = "kitty";
      "$menu" = "wofi --show drun";
      "$lock" = "hyprlock";

      # Autostart
      exec-once = [
        "$terminal"
        "waybar &"
        "wl-paste -t text -w xclip -selection clipboard"
      ];

      # General
      general = {
        gaps_in = 5;
        gaps_out = 20;

        border_size = 2;

        "col.active_border" = "rgba(33ccffee) rgba(00ff99ee) 45deg";
        "col.inactive_border" = "rgba(595959aa)";

        resize_on_border = false;

        allow_tearing = false;

        layout = "dwindle";
      };

      # Environment Variables
      env = [
        "XCURSOR_SIZE,24"
        "XDG_SESSION_TYPE,wayland"
        "XDG_CURRENT_DESKTOP,Hyprland"
        "XDG_SESSION_DESKTOP,Hyprland"
        "NIXOS_OZONE_WL,\"1\""
        "MOZ_ENABLE_WAYLAND,1"
        "WLR_NO_HARDWARE_CURSORS,1"
        "HYPRCURSOR_SIZE,24"
      ];

      # Decoration
      decoration = {
        rounding = 10;

        active_opacity = 1.0;
        inactive_opacity = 0.66;

        drop_shadow = true;
        shadow_range = 4;
        shadow_render_power = 3;
        "col.shadow" = "rgba(1a1a1aee)";

        blur = {
          enabled = true;
          new_optimizations = "on";
          size = 1;
          passes = 2;
          vibrancy = 0.1696;
        };
      };

      # Animations
      animations = {
        enabled = true;

        bezier = "myBezier, 0.3, 0, 0, 1";
        animation = [
          "windows, 1, 5, myBezier"
          "windowsOut, 1, 5, default, popin 80%"
          "border, 1, 10, default"
          "borderangle, 1, 8, default"
          "fade, 1, 7, default"
          "workspaces, 1, 6, default"
        ];
      };

      # Dwindle Layout
      dwindle = {
        pseudotile = true;
        preserve_split = true;
      };

      # Master Layout
      master = {
        new_is_master = true;
      };

      # Input
      input = {
        kb_layout = "us";
        follow_mouse = 1;
        sensitivity = 0;
      };

      # Keybinds
      "$mod" = "SUPER";
      bind = [
        "CTRL_ALT,T,exec,$terminal"
        "CTRL,Q,killactive,"

        "$mod, Space, toggleFloating,"
        "$mod, F, fullscreen, 0"
        "$mod SHIFT, F, fullscreen, 1"

        "$mod, left, movefocus, l"
        "$mod, right, movefocus, r"
        "$mod, up, movefocus, u"
        "$mod, down, movefocus, d"

        "$mod, 1, workspace, 1"
        "$mod, 2, workspace, 2"
        "$mod, 3, workspace, 3"

        "$mod SHIFT, 1, movetoworkspacesilent, 1"
        "$mod SHIFT, 2, movetoworkspacesilent, 2"
        "$mod SHIFT, 3, movetoworkspacesilent, 3"

        "$mod SHIFT, left, movewindow, l"
        "$mod SHIFT, right, movewindow, r"
        "$mod SHIFT, up, movewindow, u"
        "$mod SHIFT, down, movewindow, d"
        "$mod CTRL, left, resizeactive, -80 0"
        "$mod CTRL, right, resizeactive, 80 0"
        "$mod CTRL, up, resizeactive, 0 -80"
        "$mod CTRL, down, resizeactive, 0 80"
        "$mod ALT, left, moveactive,  -80 0"
        "$mod ALT, right, moveactive, 80 0"
        "$mod ALT, up, moveactive, 0 -80"
        "$mod ALT, down, moveactive, 0 80"

        ",XF86AudioMute,exec, wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle"
        ",XF86AudioPlay,exec, playerctl play-pause"
        ",XF86AudioNext,exec, playerctl next"
        ",XF86AudioPrev,exec, playerctl previous"
        ",XF86AudioStop, exec, playerctl stop"

        "$mod, R, exec, $menu"
        "$mod, L, exec, $lock"
      ];

      binde = [
        ", XF86AudioRaiseVolume, exec, wpctl set-volume -l 1.5 @DEFAULT_AUDIO_SINK@ 5%+"
        ", XF86AudioLowerVolume, exec, wpctl set-volume -l 1.5 @DEFAULT_AUDIO_SINK@ 5%-"
      ];

      bindm = [
        "$mod, mouse:272, movewindow"
        "$mod, mouse:273, resizewindow"
      ];

      # Misc
      misc = {
        disable_hyprland_logo = true;
        animate_mouse_windowdragging = true;
        animate_manual_resizes = true;
        enable_swallow = true;
        focus_on_activate = true;
      };

      # Window Rules
      windowrulev2 = [
        "float, title:^(Picture-in-Picture)$"
        "opacity 1.0 override 1.0 override, title:^(Picture-in-Picture)$"
        "pin, title:^(Picture-in-Picture)$"
        "idleinhibit fullscreen, class:^(google-chrome)$"
        "suppressevent maximize, class:.*"
        "float,class:^(file_progress)$"
        "float,class:^(confirm)$"
        "float,class:^(dialog)$"
        "float,class:^(download)$"
        "float,class:^(notification)$"
        "float,class:^(error)$"
        "float,class:^(confirmreset)$"
        "float,title:^(Open File)$"
        "float,title:^(branchdialog)$"
        "float,title:^(Confirm to replace files)$"
        "float,title:^(File Operation Progress)$"
      ];
    };
  };
}
