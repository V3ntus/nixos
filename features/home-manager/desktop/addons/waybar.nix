{pkgs, ...}: {
  programs.waybar = {
    enable = true;

    style = ''
      ${builtins.readFile "${pkgs.waybar}/etc/xdg/waybar/style.css"}

      * {
        font-size: 12px;
        font-family: "MesloLGS NF", monospace;
      }

      window#waybar {
        background: #292b2e;
        color: #fdf6e3;
      }

      #custom-right-arrow-light,
      #custom-left-arrow-light {
      	color: #292b2e;
      	background: #1a1a1a;
      }

      #workspaces,
      #clock.1,
      #clock.2,
      #clock.3,
      #pulseaudio,
      #memory,
      #cpu,
      #battery,
      #disk,
      #tray {
      	background: #1a1a1a;
      }

      #workspaces button {
      	padding: 0 2px;
      	color: #fdf6e3;
      }
      #workspaces button.focused {
      	color: #268bd2;
      }
      #workspaces button:hover {
      	box-shadow: inherit;
      	text-shadow: inherit;
      }
      #workspaces button:hover {
      	background: #1a1a1a;
      	border: #1a1a1a;
      	padding: 0 3px;
      }

      #pulseaudio {
      	color: #268bd2;
      }
      #memory {
      	color: #2aa198;
      }
      #cpu {
      	color: #6c71c4;
      }
      #battery {
      	color: #859900;
      }
      #disk {
      	color: #b58900;
      }

      #clock,
      #pulseaudio,
      #memory,
      #cpu,
      #battery,
      #disk {
      	padding: 0 10px;
      }
    '';

    settings = [
      {
        layer = "top";
        position = "top";
        height = 30;
        tray = {
          spacing = 10;
        };

        modules-left = [
          "hyprland/workspaces"
          "hyprland/window"
          "custom/right-arrow-dark"
        ];
        modules-center = [
          "custom/left-arrow-dark"
          "clock#1"
          "custom/left-arrow-light"
          "custom/left-arrow-dark"
          "clock#2"
          "custom/right-arrow-dark"
          "custom/right-arrow-light"
          "clock#3"
          "custom/right-arrow-dark"
        ];
        modules-right = [
          "custom/left-arrow-dark"
          "cava"
          "pulseaudio"
          "custom/left-arrow-light"
          "custom/left-arrow-dark"
          "memory"
          "custom/left-arrow-light"
          "custom/left-arrow-dark"
          "cpu"
          "custom/left-arrow-light"
          "custom/left-arrow-dark"
          "network"
          "custom/left-arrow-light"
          "custom/left-arrow-dark"
          "disk"
          "custom/left-arrow-light"
          "custom/left-arrow-dark"
          "tray"
        ];

        "custom/left-arrow-dark" = {
          format = "";
          tooltip = false;
        };
        "custom/left-arrow-light" = {
          format = "";
          tooltip = false;
        };
        "custom/right-arrow-dark" = {
          format = "";
          tooltip = false;
        };
        "custom/right-arrow-light" = {
          format = "";
          tooltip = false;
        };
        "clock#1" = {
          format = "{:%a}";
          tooltip = false;
        };
        "clock#2" = {
          format = "{:%H:%M}";
          tooltip = false;
        };
        "clock#3" = {
          format = "{:%m-%d}";
          tooltip = false;
        };

        "hyprland/workspaces" = {
          active-only = false;
          disable-scroll = true;
          format = "{icon}";
          on-click = "activate";
        };

        cava = {
          format-icons = ["▁" "▂" "▃" "▄" "▅" "▆" "▇" "█"];
          bar_delimiter = 0;
          method = "pipewire";
          noise_reduction = 0.4;
          input_delay = 5;
          bars = 12;
        };
        network = {
          interval = 3;
          format = "{ifname} -> {ipaddr}/{cidr} | {bandwidthUpBytes} / {bandwidthDownBytes}";
        };
        memory = {
          interval = 5;
          format = "RAM {}%";
        };
        cpu = {
          interval = 3;
          format = "CPU {usage:2}%";
        };
        disk = {
          interval = 30;
          format = "Disk {percentage_used:2}%";
          path = "/";
        };
        tray = {
          icon-size = 20;
        };
      }
    ];
  };
}
