rec {
  inventory = import ../../../../hosts/homelab/inventory.nix;

  base = {
    locations,
    internal ? true,
    needAuth ? false,
    extraConfig ? "",
    otherConfig ? {},
  }:
    {
      inherit locations extraConfig;

      forceSSL = true;
    }
    // (
      if internal
      then {
        useACMEHost = "healthcheckacme.gladiusso.com";
      }
      else {
        enableACME = true;
      }
    )
    // otherConfig;

  proxy = {
    ip,
    port,
    needAuth ? false,
    extraConfig ? "",
    extraLocationConfig ? "",
    locations ? {},
    proto ? "http",
    internal ? true,
  }:
    base {
      locations =
        {
          "/" = {
            proxyPass = "${proto}://${ip}:${toString port}/";
            proxyWebsockets = true;
            extraConfig = ''
              proxy_pass_header Authorization;
              proxy_pass_header Host;

              ${extraLocationConfig}

              ${
                if needAuth
                then "include ${../conf/authelia/location.conf};"
                else ""
              }
            '';
          };
        }
        // locations;
      inherit internal;
      extraConfig =
        extraConfig
        + (
          if needAuth
          then "\ninclude ${../conf/authelia/vhost.conf};"
          else ""
        );
    };
}
