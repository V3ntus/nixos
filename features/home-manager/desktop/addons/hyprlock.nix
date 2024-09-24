{
  lib,
  pkgs,
  ...
}: {
  programs.hyprlock = {
    enable = true;
    settings = {
      general = {
        grace = 5;
        hide_cursor = false;
        immediate_render = true;
        disable_loading_bar = true;
      };

      background = [
        {
          color = "rgb(0, 0, 0)";
          path = "screenshot";
          blur_passes = 2;
          blur_size = 6;
        }
      ];

      input-field = [
        {
          size = "200, 50";
          position = "0, -80";
          dots_center = true;
          fade_on_empty = false;
          placeholder_text = "";
        }
      ];

      label = [
        {
          text = "$TIME";
          font_size = 100;
          text_align = "center";
          halign = "center";
          valign = "center";
          position = "0, 50";
        }
      ];
    };
  };

  services.hypridle = {
    enable = true;
    settings = {
      general = {
        lock_cmd = "pgrep hyprlock || ${lib.getExe pkgs.hyprlock}";
        before_sleep_cmd = "pgrep hyprlock || ${lib.getExe pkgs.hyprlock}";
      };

      listener = [
        {
          timeout = 300;
          on-timeout = "${lib.getExe pkgs.hyprlock}";
        }
        {
          timeout = 315;
          on-timeout = "${pkgs.hyprland}/bin/hyprctl dispatch dpms off";
          on-resume = "${pkgs.hyprland}/bin/hyprctl dispatch dpms on";
        }
      ];
    };
  };
}
