{pkgs, config, ...}: {
  boot.kernel.sysctl = {
    "net.ipv4.conf.all.forwarding" = 1;
    "net.ipv4.ip_forward" = 1;
  };

  sops.secrets = {
    "misc/cloudflared" = {
      sopsFile = ../../users/secrets.yaml;
      owner = config.services.cloudflared.user;
      group = config.services.cloudflared.group;
    };
  };

  services.cloudflared = {
    enable = false;
    tunnels = {
      "e6f35697-85ed-4dea-836e-f5c8918f2369" = {
        credentialsFile = "${config.sops.secrets."misc/cloudflared".path}";
        default = "http_status:404";
      };
    };
  };

  networking = {
    hostName = "vps";
    domain = "gladiusso.com";

    usePredictableInterfaceNames = false;
    useDHCP = false;

    defaultGateway = {
      address = "172.232.31.1";
      interface = "eth0";
    };

    interfaces = {
      eth0 = {
        useDHCP = false;
        ipv4 = {
          addresses = [
            {
              address = "172.232.31.102";
              prefixLength = 24;
            }
          ];
        };
      };
    };

    nat = {
      enable = true;
      externalInterface = "eth0";
      internalInterfaces = ["wg0"];
      forwardPorts = [
        # Minecraft servers
        {
          sourcePort = 25565;
          proto = "tcp";
          destination = "192.168.2.11:25565";
        }
        {
          sourcePort = 25566;
          proto = "tcp";
          destination = "192.168.2.11:25566";
        }

        # Voice chat
        {
          sourcePort = 24454;
          proto = "udp";
          destination = "192.168.2.11:24454";
        }
        {
          sourcePort = 24455;
          proto = "udp";
          destination = "192.168.2.11:24455";
        }
      ];
    };

    firewall = {
      enable = true;
      allowedTCPPorts = [80 443 22 2112 25565 25566];
      allowedUDPPorts = [24454 24455 51820];
      extraCommands = ''
               iptables -A FORWARD -i wg0 -j ACCEPT
               iptables -A FORWARD -o wg0 -j ACCEPT

               iptables -t nat -A PREROUTING -p tcp --dport 25565 -j DNAT --to-destination 192.168.2.11:25565
        iptables -t nat -A PREROUTING -p tcp --dport 25566 -j DNAT --to-destination 192.168.2.11:25566

               iptables -t nat -A PREROUTING -p udp --dport 24454 -j DNAT --to-destination 192.168.2.11:24454
        iptables -t nat -A PREROUTING -p udp --dport 24455 -j DNAT --to-destination 192.168.2.11:24455

               iptables -t nat -A POSTROUTING -o wg0 -j MASQUERADE
      '';
    };

    nameservers = [
      "9.9.9.9"
      "1.1.1.1"
    ];

    wireguard.interfaces = {
      wg0 = {
        ips = ["10.143.245.1/24"];
        listenPort = 51820;
        postSetup = ''
          ${pkgs.iptables}/bin/iptables -t nat -A POSTROUTING -s 10.143.245.0/24 -o eth0 -j MASQUERADE
        '';
        postShutdown = ''
          ${pkgs.iptables}/bin/iptables -t nat -D POSTROUTING -s 10.143.245.0/24 -o eth0 -j MASQUERADE
        '';
        privateKeyFile = "/etc/wireguard/privatekey";
        peers = [
          {
            # pixel8
            publicKey = "O9CfCNnSuvNh/Ei/p28BtwqPFE2MSVKGq5J82dy2vlE=";
            presharedKeyFile = "/etc/wireguard/configs/pixel8.psk";
            allowedIPs = ["10.143.245.2/32" "fd11:5ee:bad:c0de::2/128"];
          }
          {
            # router
            publicKey = "16W+vD2mNGcdmQlAN/b/uPOuwk1IVN+oLfUflC7YkG0=";
            presharedKeyFile = "/etc/wireguard/configs/router.psk";
            allowedIPs = ["192.168.2.0/24" "10.143.245.3/32" "fd11:5ee:bad:c0de::3/128"];
          }
          {
            # macbook
            publicKey = "yjrwH9aqXBU4gd/V8ObWEfzO9PKt4b2VriIk/yCs8VA=";
            presharedKeyFile = "/etc/wireguard/configs/macbook.psk";
            allowedIPs = ["10.143.245.5/32" "fd11:5ee:bad:c0de::5/128"];
          }
          {
            # Danielle's Phone
            publicKey = "c7CRT+4L+Uk7xEZ4yGoC7w+UHv0UVKTYoMBkrSJJWRU=";
            presharedKeyFile = "/etc/wireguard/configs/danielles_phone.psk";
            allowedIPs = ["10.143.245.6/32" "fd11:5ee:bad:c0de::6/128"];
          }
          {
            # tablet
            publicKey = "JO5UmYioA48q8xbwZW8mlSuOPI8eUN5c166hsONlphc=";
            allowedIPs = ["10.143.245.7/32" "fd11:5ee:bad:c0de::7/128"];
          }
          {
            # Danielle's PC
            publicKey = "pgCJP7X/oN717jia5axFIpsOSblZ1+yH1NuEa8Z6vAY=";
            presharedKeyFile = "/etc/wireguard/configs/danielles_pc.psk";
            allowedIPs = ["10.143.245.8/32" "fd11:5ee:bad:c0de::8/128"];
          }
          {
            # Danielle's laptop
            publicKey = "1iiNSCG+4Zbz/B+5wCBITw5b19TalvMbUVwJ1v11rys=";
            presharedKeyFile = "/etc/wireguard/configs/danielles_laptop.psk";
            allowedIPs = ["10.143.245.9/32" "fd11:5ee:bad:c0de::9/128"];
          }
        ];
      };
    };
  };
}
