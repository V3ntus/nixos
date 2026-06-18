{config, ...}: {
  acceptTerms = true;
  defaults.email = "joe@gladiusso.com";
  certs."gladiusso.com" = {
    webroot = "/var/lib/acme/acme-challenge";
    extraDomainNames = builtins.attrNames config.services.nginx.virtualHosts;
    postRun = ''
      cat /var/lib/acme/gladiusso.com/key.pem | ssh -i ${config.sops.secrets."matrix/cert_sync_key".path} certsync@192.168.2.20 "deploy_cert -pkey"
      cat /var/lib/acme/gladiusso.com/key.pem | ssh -i ${config.sops.secrets."matrix/cert_sync_key".path} certsync@192.168.2.20 "deploy_cert -cert"
    '';
  };
}
