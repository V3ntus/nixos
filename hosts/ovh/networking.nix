{config, ...}: let
  consts = import ./consts.nix;
in {
  sops.secrets = {
    "wireguard/privkey" = {
      sopsFile = ../../users/secrets.yaml;
      mode = "440";
      owner = "systemd-network";
      group = "systemd-network";
    };
  };

  boot.kernel.sysctl = {
    "net.ipv4.conf.all.forwarding" = 1;
    "net.ipv4.ip_forward" = 1;
  };

  systemd.network = {
    enable = true;

    networks = {
      "10-wan" = {
        matchConfig.Name = "ens3";
        address = [
          "${consts.ipv4}/24"
          "${consts.ipv6}/64"
        ];
        routes = [
          { Gateway = "2604:2dc0:222::1"; }
          { Gateway = "15.204.94.1"; GatewayOnLink = true; }
        ];
        dns = [
          "1.1.1.1"
          "9.9.9.9"
        ];
        linkConfig.RequiredForOnline = "routable";
      };

      "50-wg1" = {
        matchConfig.Name = "wg1";
        address = [
          "10.143.245.1/24"
          "fd11:5ee:bad:c0de::1/64"
        ];
        networkConfig = {
          IPv4Forwarding = true;
          IPv6Forwarding = true;
        };
      };
    };

    netdevs = {
      "50-wg1" = {
        netdevConfig = {
          Kind = "wireguard";
          Name = "wg1";
        };

        wireguardConfig = {
          ListenPort = 51820;
          PrivateKeyFile = config.sops.secrets."wireguard/privkey".path;
          RouteTable = "main";
          FirewallMark = 69;
        };

        wireguardPeers = [
          {
            # phone
            PublicKey = "IDTGMcFAOVt1FpOB0NLxLKrw2daqlAEN0Fn6rU76OSQ=";
            AllowedIPs = [ "10.143.245.2/32" "fd11:5ee:bad:c0de::2/128" ];
            PresharedKeyFile = "/etc/wireguard/configs/phone.psk";
          }
          {
            # router
            PublicKey = "16W+vD2mNGcdmQlAN/b/uPOuwk1IVN+oLfUflC7YkG0=";
            AllowedIPs = [ "10.143.245.3/32" "fd11:5ee:bad:c0de::3/128" "192.168.2.0/24" ];
            PresharedKeyFile = "/etc/wireguard/configs/router.psk";
          }
          {
            # macbook
            PublicKey = "yjrwH9aqXBU4gd/V8ObWEfzO9PKt4b2VriIk/yCs8VA=";
            AllowedIPs = [ "10.143.245.5/32" "fd11:5ee:bad:c0de::5/128" ];
            PresharedKeyFile = "/etc/wireguard/configs/macbook.psk";
          }
          {
            # danielle's phone
            PublicKey = "c7CRT+4L+Uk7xEZ4yGoC7w+UHv0UVKTYoMBkrSJJWRU=";
            AllowedIPs = [ "10.143.245.6/32" "fd11:5ee:bad:c0de::6/128" ];
            PresharedKeyFile = "/etc/wireguard/configs/danielles_phone.psk";
          } 
          {
            # danielle's laptop
            PublicKey = "1iiNSCG+4Zbz/B+5wCBITw5b19TalvMbUVwJ1v11rys=";
            AllowedIPs = [ "10.143.245.9/32" "fd11:5ee:bad:c0de::9/128" ];
            PresharedKeyFile = "/etc/wireguard/configs/danielles_laptop.psk";
          }
        ];
      };
    };
  };

  networking = {
    useNetworkd = true;

    nat = {
      enable = true;
      enableIPv6 = true;
      externalInterface = "ens3";
      internalInterfaces = [ "wg0" "wg1" ];
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

        # Matrix
        {
          sourcePort = "49000:50000";
          proto = "udp";
          destination = "192.168.2.20:49000-51000";
        }
        {
          sourcePort = 3478;
          proto = "udp";
          destination = "192.168.2.20:3478";
        }
        {
          sourcePort = 3478;
          proto = "tcp";
          destination = "192.168.2.20:3478";
        }
      ];
    };

    firewall = {
      enable = true;
      allowedTCPPorts = [ 80 443 22 ];
      allowedUDPPorts = [ 51820 ];
      extraCommands = ''
        iptables -A FORWARD -i wg0 -j ACCEPT
        iptables -A FORWARD -o wg0 -j ACCEPT

        iptables -t nat -A PREROUTING -p tcp --dport 25565 -j DNAT --to-destination 192.168.2.11:25565
        iptables -t nat -A PREROUTING -p tcp --dport 25566 -j DNAT --to-destination 192.168.2.11:25566

        iptables -t nat -A PREROUTING -p udp --dport 24454 -j DNAT --to-destination 192.168.2.11:24454
        iptables -t nat -A PREROUTING -p udp --dport 24455 -j DNAT --to-destination 192.168.2.11:24455

        iptables -t nat -A PREROUTING -p tcp --dport 3478 -j DNAT --to-destination 192.168.2.20:3478
        iptables -t nat -A PREROUTING -p udp --dport 3478 -j DNAT --to-destination 192.168.2.20:3478
        iptables -t nat -A PREROUTING -p udp --dport 49000:50000 -j DNAT --to-destination 192.168.2.20:49000-51000

        iptables -t nat -A POSTROUTING -o wg0 -j MASQUERADE
      '';
    };
    hostName = "vps-ovh-or";
    domain = "gladiusso.com";
  };
}
