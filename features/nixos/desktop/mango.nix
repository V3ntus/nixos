{
  inputs,
  pkgs,
  config,
  ...
}: {
  imports = [
    inputs.mangowm.nixosModules.mango
  ];

  programs.mango.enable = true;

  home-manager.users."joe".imports = [
    ../../home-manager/desktop/addons/wofi.nix
    ../../home-manager/desktop/addons/wallpapers.nix

    ({...}: {
      wayland.windowManager.mango = {
        enable = true;
        settings = {
          monitorrule = "name:*,width:1920,height:1080,refresh:60,x:0,y:0";

          animations = 1;
          layer_animations = 1;
          animation_type_open = "zoom";
          animation_type_close = "slide";
          layer_animation_type_open = "slide";
          layer_animation_type_close = "slide";
          animation_fade_in = 1;
          animation_fade_out = 1;
          fadein_begin_opacity = 0.5;
          fadeout_begin_opacity = 0.5;
          zoom_initial_ratio = 0.4;
          zoom_end_ratio = 0.8;

          blur = 1;
          blur_layer = 1;

          shadows = 1;
          layer_shadows = 1;

          border_radius = 6;
          unfocused_opacity = 0.7;

          borderpx = 2;

          bind = [
            "SUPER,t,spawn,kitty"
            "SUPER,r,spawn,wofi -show drun"
            "SUPER+SHIFT,r,reload_config"

            "SUPER,q,killclient"
            "SUPER,Return,togglefullscreen"
            "SUPER,Space,centerwin"

            "SUPER,Left,focusdir,left"
            "SUPER,Right,focusdir,right"
            "SUPER,Up,focusdir,up"
            "SUPER,Down,focusdir,down"

            "SUPER+SHIFT,Left,exchange_client,left"
            "SUPER+SHIFT,Right,exchange_client,right"
            "SUPER+SHIFT,Up,exchange_client,up"
            "SUPER+SHIFT,Down,exchange_client,down"
          ];
        };
        autostart_sh = ''
          kitty &
          ${inputs.noctalia.packages.${pkgs.stdenv.hostPlatform.system}.default}/bin/noctalia-shell &
          change_wallpaper &
        '';
      };
    })
    inputs.mangowm.hmModules.mango
  ];
}
