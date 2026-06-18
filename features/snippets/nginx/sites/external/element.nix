{pkgs, ...}: let
  u = import ../_util.nix;
  matrix = import ../../conf/matrix.nix;
in
  u.base {
    locations = {};
    internal = false;
    otherConfig = {
      root = pkgs.element-web.override {
        conf = {
          default_server_config = matrix.clientConfig;
          default_theme = "dark";
          disable_guests = true;
          integrations_ui_url = "https://scalar.vector.im";
          integrations_rest_url = "https://scalar.vector.im/api";
          integrations_widgets_urls = [
            "https://scalar.vector.im/_matrix/integrations/v1"
            "https://scalar.vector.im/api"
            "https://scalar-staging.vector.im/_matrix/integrations/v1"
            "https://scalar-staging.vector.im/api"
          ];
        };
      };
    };
  }
