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
        hide_cursor = true;
      };

      background = [
        {
          blur_passes = 2;
          blur_size = 6;
        }
      ];

      input-field = [
        {
          size = "250, 60";
          placeholder_text = "";
        }
      ];

      label = [
        {
          text = "Hello";
          font_size = 64;
          text_align = "center";
          halign = "center";
          valign = "center";
          position = "0, 160";
        }
        {
          text = "$TIME";
          font_size = 32;
          text_align = "center";
          halign = "center";
          valign = "center";
          position = "0, 75";
        }
      ];
    };
  };

  services.hypridle = {
    enable = true;
    settings = {
      general = {
        lock_cmd = "${lib.getExe pkgs.hyprlock}";
        before_sleep_cmd = "${lib.getExe pkgs.hyprlock}";
      };

      listener = [
        {
          timeout = 300;
          on-timeout = "${lib.getExe pkgs.hyprlock}";
        }
        {
          timeout = 305;
          on-timeout = "${pkgs.hyprland}/bin/hyprctl dispatch dpms off";
          on-resume = "${pkgs.hyprland}/bin/hyprctl dispatch dpms on";
        }
      ];
    };
  };
}
