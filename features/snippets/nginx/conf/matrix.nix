let
  matrixFqdn = "matrix.gladiusso.com";
  baseUrl = "https://${matrixFqdn}";

  clientConfig = {
    "m.homeserver".base_url = baseUrl;
    "org.matrix.msc3575.proxy".url = baseUrl;
    "org.matrix.msc4143.rtc_foci" = [
      {
        type = "livekit";
        livekit_service_url = "${baseUrl}/livekit/jwt";
      }
    ];
  };
  serverConfig = {
    "m.server" = "${matrixFqdn}:443";
  };

  mkWellKnown = data: ''
    default_type application/json;
    add_header Access-Control-Allow-Origin *;
    return 200 '${builtins.toJSON data}';
  '';

  matrixExtraConfig = ''
    proxy_set_header X-Forwarded-For $remote_addr;
    proxy_set_header X-Forwarded-Proto $scheme;
    proxy_set_header Host $host;
    proxy_hide_header Access-Control-Allow-Origin;

    client_max_body_size 50M;

    add_header 'Access-Control-Allow-Origin' '*' always;
    add_header 'Access-Control-Allow-Methods' 'GET, POST, PUT, DELETE, OPTIONS' always;
    add_header 'Access-Control-Allow-Headers' 'Authorization, Content-Type' always;
    if ($request_method = 'OPTIONS') {
      add_header 'Access-Control-Allow-Origin' '*';
      add_header 'Access-Control-Allow-Methods' 'GET, POST, PUT, DELETE, OPTIONS';
      add_header 'Access-Control-Allow-Headers' 'Authorization, Content-Type';
      add_header 'Content-Length' '0';
      return 204;
    }
  '';
in {
  inherit mkWellKnown matrixExtraConfig matrixFqdn clientConfig serverConfig;
}
