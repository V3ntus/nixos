{
  imports = [
    ./addons/waybar.nix
  ];

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

      # Autostart
      exec-once = [
        "$terminal"
        "waybar &"
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
        "NIXOS_OZONE_WL,\"1\""
        "MOZ_ENABLE_WAYLAND,1"
        "WLR_NO_HARDWARE_CURSORS,1"
        "HYPRCURSOR_SIZE,24"
      ];

      # Decoration
      decoration = {
        rounding = 10;

        active_opacity = 1.0;
        inactive_opacity = 0.9;

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
          "windows, 1, 7, myBezier"
          "windowsOut, 1, 7, default, popin 80%"
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

        "$mod, left, movefocus, l"
        "$mod, right, movefocus, r"
        "$mod, up, movefocus, u"
        "$mod, down, movefocus, d"
      ];
      bindm = [
        "$mod, mouse:272, movewindow"
        "$mod, mouse:273, resizewindow"
      ];

      # Misc
      misc = {
        disable_hyprland_logo = true;
        animate_mouse_windowdragging = false;
        animate_manual_resizes = false;
      };

      # Window Rules
      windowrulev2 = "suppressevent maximize, class:.*";
    };
  };
}
