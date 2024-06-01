{pkgs, ...}: {
  home.packages = with pkgs; [cliphist];
  programs.waybar = {
    enable = true;

    style = ''
      ${builtins.readFile "${pkgs.waybar}/etc/xdg/waybar/style.css"}
      ${builtins.readFile ./waybar.style.css}
    '';

    settings = [
      {
        layer = "top";
        margin-top = 0;
        margin-bottom = 0;
        margin-left = 0;
        margin-right = 0;
        spacing = 0;

        modules-left = [
          "custom/appmenuicon"
          "hyprland/workspaces"
          "wlr/taskbar"
          "hyprland/window"
          "custom/empty"
        ];

        modules-center = [
          "cava"
        ];

        modules-right = [
          "pulseaudio"
          "bluetooth"
          "battery"
          "network"
          "group/hardware"
          "custom/cliphist"
          "idle_inhibitor"
          "tray"
          "clock"
        ];

        "hyprland/workspaces" = {
          active-only = false;
          disable-scroll = true;
          all-outputs = true;
          format = "{}";
          format-icons = {
            urgent = "";
            active = "";
            default = "";
          };
          on-click = "activate";
          persistent-workspaces = {
            "*" = 5;
          };
        };

        "wlr/taskbar" = {
          format = "{icon}";
          icon-size = 18;
          tooltip-format = "{title}";
          on-click = "activate";
          on-click-middle = "close";
        };

        "hyprland/window" = {
          rewrite = {
            "(.*) - Google Chrome" = "$1";
            "(.*) - Outlook" = "$1";
            "(.*) Microsoft Teams" = "$1";
          };
          separate-outputs = true;
        };

        "custom/empty" = {
          format = "";
        };

        "custom/cliphist" = {
          format = "";
          on-click = "sleep 0.1 && pkill wofi || cliphist list | wofi --dmenu | cliphist decode | wl-copy";
          on-click-right = "sleep 0.1 && pkill wofi || cliphist list | wofi --dmenu | cliphist delete";
        };

        "custom/appmenu" = {
          format = "Apps";
          on-click = "sleep 0.2; pkill wofi || wofi --show drun";
          tooltip = false;
        };

        "custom/appmenuicon" = {
          format = "";
          on-click = "pkill wofi || wofi --show drun";
          tooltip = false;
        };

        keyboard-state = {
          numlock = true;
          capslock = true;
          format = "{name} {icon}";
          format-icons = {
            locked = "";
            unlocked = "";
          };
        };

        tray = {
          icon-size = 21;
          spacing = 10;
        };

        clock = {
          format = "{:%H:%M %a}";
          tooltip-format = "<big>{:%Y %B}</big>\n<tt><small>{calendar}</small></tt>";
          format-alt = "{:%Y-%m-%d}";
        };

        "custom/system" = {
          format = "󰻠";
          tooltip = false;
        };

        cpu = {
          format = "/ C {usage}% ";
          on-click = "kitty btop";
        };

        memory = {
          format = "/ M {}% ";
          on-click = "kitty btop";
        };

        disk = {
          interval = 30;
          format = "D {percentage_used}% ";
          path = "/";
          on-click = "kitty btop";
        };

        "hyprland/language" = {
          format = "/ K {short}";
        };

        "group/hardware" = {
          orientation = "inherit";
          drawer = {
            transition-duration = 300;
            children-class = "not-memory";
            transition-left-to-right = false;
          };
          modules = [
            "custom/system"
            "disk"
            "cpu"
            "memory"
            "hyprland/language"
          ];
        };

        network = {
          format = "{ifname}";
          format-wifi = "   {signalStrength} %";
          format-ethernet = "  {ifname}";
          format-disconnected = "Disconnected";
          tooltip-format-wifi = "  {ifname} @ {essid}\nIP: {ipaddr}\nStrength: {signalStrength}%\nFreq: {frequency}MHz\nUp: {bandwidthUpBits} Down: {bandwidthDownBits}";
          tooltip-format-ethernet = " {ifname}\nIP: {ipaddr}\n up: {bandwidthUpBits} down: {bandwidthDownBits}";
          tooltip-format-disconnected = "Disconnected";
          max-length = 50;
          on-click = "kitty nmtui";
        };

        battery = {
          state = {
            good = 95;
            warning = 30;
            critical = 15;
          };
          format = "{icon}   {capacity}%";
          format-charging = "  {capacity}%";
          format-plugged = "  {capacity}%";
          format-alt = "{icon}  {time}";
          format-icons = [" " " " " " " " " "];
        };

        pulseaudio = {
          format = "{icon}   {volume}%";
          format-bluetooth = "{volume}%  {icon} {format_source}";
          format-bluetooth-muted = " {icon} {format_source}";
          format-muted = " {format_source}";
          format-source = "{volume}% ";
          format-source-muted = "";
          format-icons = {
            headphone = " ";
            hands-free = " ";
            headset = " ";
            phone = " ";
            portable = " ";
            car = " ";
            default = [" " " " " "];
          };
          on-click = "kitty alsamixer";
        };

        bluetooth = {
          format = " {status}";
          format-disabled = "";
          format-off = "";
          interval = 30;
          # on-click = "blueman-manager";
          format-no-control = "";
        };

        user = {
          format = "{user}";
          interval = 60;
          icon = false;
        };

        idle_inhibitor = {
          format = "{icon}";
          tooltip = true;
          format-icons = {
            activated = "✓";
            deactivated = "";
          };
          on-click-right = "hyprlock";
        };

        cava = {
          format-icons = ["▁" "▂" "▃" "▄" "▅" "▆" "▇" "█"];
          bar_delimiter = 0;
          method = "pipewire";
          noise_reduction = 0.77;
          input_delay = 5;
          bars = 24;
        };
      }
    ];
  };
}
