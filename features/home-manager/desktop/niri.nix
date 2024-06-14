{
  config,
  pkgs,
  ...
}: {
  imports = [
    ./common.nix
    ./addons/waybar.nix
  ];

  home.packages = with pkgs; [
    playerctl
    wl-clipboard
    grim
    slurp
    swappy
  ];

  programs.niri = {
    settings = {
      # Input
      input = {
        keyboard = {
          xkb = {
            layout = "us";
          };
        };

        # Input flags
        warp-mouse-to-focus = true;
        focus-follows-mouse = true;
        workspace-auto-back-and-forth = true;
      };

      # Outputs
      outputs = {
        # Define outputs in host configurations
      };

      # Keybinds
      binds = with config.lib.niri.actions; let
        sh = spawn "sh" "-c";
        screenshot = ''grim -g \"$(slurp -d)\" - | tee >(swappy -f - -o - | wl-copy) | wl-copy'';
        terminal = "kitty";
        menu = ["wofi" "--show" "drun"];
        lock = "hyprlock";
      in {
        "Mod+Shift+slash".action = show-hotkey-overlay;
        # Launchers
        "Ctrl+Alt+T".action.spawn = terminal;
        "Mod+T".action.spawn = terminal;
        "Mod+R".action.spawn = menu;
        "Mod+L".action.spawn = lock;
        "Mod+Print".action = sh screenshot;

        # Actions
        "Ctrl+Q".action = quit {
          skip-confirmation = true;
        };

        # Windows/Columns - Window Management
        "Mod+WheelScrollDown" = {
          cooldown-ms = 150;
          action = focus-workspace-down;
        };
        "Mod+WheelScrollUp" = {
          cooldown-ms = 150;
          action = focus-workspace-up;
        };
        "Mod+WheelScrollRight".action = focus-column-right;
        "Mod+WheelScrollLeft".action = focus-column-left;
        "Mod+Left".action = focus-column-left;
        "Mod+Right".action = focus-column-right;
        "Mod+Up".action = focus-window-or-workspace-up;
        "Mod+Down".action = focus-window-or-workspace-down;
        "Mod+Home".action = focus-column-first;
        "Mod+End".action = focus-column-last;
        "Mod+Shift+Left".action = move-column-left;
        "Mod+Shift+Right".action = move-column-right;
        "Mod+Shift+Up".action = move-window-up-or-to-workspace-up;
        "Mod+Shift+Down".action = move-window-down-or-to-workspace-down;
        "Mod+F".action = fullscreen-window;
        "Mod+Return".action = center-column;
        # -- inherits Hyprland-like Mod+RightClick resizing built-in

        # Workspaces
        "Mod+1".action = focus-workspace 1;
        "Mod+2".action = focus-workspace 2;
        "Mod+3".action = focus-workspace 3;
        "Mod+4".action = focus-workspace 4;
        "Mod+5".action = focus-workspace 5;
        "Mod+6".action = focus-workspace 6;
        "Mod+7".action = focus-workspace 7;

        # Media
        "XF86AudioRaiseVolume".action.spawn = ["wpctl" "set-volume" "@DEFAULT_AUDIO_SINK@" "0.1+"];
        "XF86AudioLowerVolume".action.spawn = ["wpctl" "set-volume" "@DEFAULT_AUDIO_SINK@" "0.1-"];
        "XF86AudioMute".action.spawn = ["wpctl" "set-mute" "@DEFAULT_AUDIO_SINK@" "toggle"];
        "XF86AudioPlay".action.spawn = ["playerctl" "play-pause"];
        "XF86AudioNext".action.spawn = ["playerctl" "next"];
        "XF86AudioPrev".action.spawn = ["playerctl" "previous"];
        "XF86AudioStop".action.spawn = ["playerctl" "stop"];
      };
    };
  };
}
