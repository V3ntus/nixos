{
  lib,
  config,
  ...
}: {
  sops.secrets = {
    "wireguard/vps/psk" = {sopsFile = ../../../users/secrets.yaml;};
  };

  networking.wg-quick.interfaces.wg0.peers = lib.mkDefault [
    {
      publicKey = "BHQ/UT0IgwdIMKsjJM5EYEKjpJZK+YI76LbCPWDCrSE=";
      presharedKeyFile = config.sops.secrets."wireguard/vps/psk".path;
      allowedIPs = ["0.0.0.0/0" "::/0"];
      endpoint = "172.232.31.102:51820";
      persistentKeepalive = 25;
    }
  ];
}
