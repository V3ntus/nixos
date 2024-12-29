{
  services.homepage-dashboard = {
    enable = true;

    settings = {
      title = "Joe and Danielle's Homepage";
      startUrl = "https://home.gladiusso.com";

      background = {
        image = "https://upload.wikimedia.org/wikipedia/commons/thumb/c/c5/Moraine_Lake_17092005.jpg/640px-Moraine_Lake_17092005.jpg";
        blur = "sm";
        brightness = 50;
        opacity = 50;
      };
      theme = "dark";
      color = "slate";
      headerStyle = "clean";
      hideVersion = true;
      useEqualHeights = true;

      layout = {
        Apps = {
          tab = "Apps";
          style = "row";
          columns = 3;
          header = false;
        };
        Media = {
          tab = "Apps";
          style = "row";
          columns = 3;
        };
        Network = {
          tab = "System";
          style = "row";
          columns = 3;
        };
      };
    };

    widgets = [
      {logo = {};}
      {
        search = {
          provider = "google";
          target = "_self";
        };
      }
      {
        datetime = {
          text_size = "xl";
          format = {
            timeStyle = "short";
            dateStyle = "short";
            hourCycle = "h23";
          };
        };
      }
    ];

    bookmarks = [
      {
        "Bookmarks" = [
          {
            "YouTube" = [
              {
                icon = "youtube.svg";
                href = "https://youtube.com";
              }
            ];
          }
          {
            "Reddit" = [
              {
                icon = "reddit.svg";
                href = "https://reddit.com";
              }
            ];
          }
          {
            "Instagram" = [
              {
                icon = "instagram.svg";
                href = "https://instagram.com";
              }
            ];
          }
          {
            "Facebook" = [
              {
                icon = "facebook.svg";
                href = "https://facebook.com";
              }
            ];
          }
        ];
      }
      {
        "Misc" = [
          {
            "NixOS Configs" = [
              {
                icon = "github.svg";
                href = "https://github.com/V3ntus/nixos";
                description = "NixOS homelab/host configuration repo";
              }
            ];
          }
        ];
      }
    ];

    services = [
      {
        "Network" = [
          {
            "Unifi" = {
              icon = "unifi.png";
              description = "Unifi Site Manager";
              href = "https://unifi.ui.com";
            };
          }
          {
            "Proxmox" = {
              icon = "proxmox.png";
              description = "Proxmox Virtual Environment hypervisor";
              href = "https://192.168.2.3:8006/";
              widget = {
                type = "proxmox";
                url = "https://192.168.2.3:8006";
                username = "api@pam!homepage";
                password = "5f0e78cb-2d3a-4dc7-8c5c-120da887c5d3";
              };
            };
          }
          {
            "Technitium" = {
              icon = "azure-dns.png";
              description = "Technitium DNS server and network adblocker";
              href = "http://dns.gladiusso.com";
            };
          }
          {
            "Portainer" = {
              # docker-container
              icon = "portainer.png";
              description = "Docker management web UI";
              href = "https://192.168.2.7:9443";
              widget = {
                type = "portainer";
                url = "https://192.168.2.7:9443";
                "env" = 2;
                key = "ptr_akuEyo34aXsXPCXR54/0ER8g+9o3Np0kR335AoItQg8=";
              };
            };
          }
          {
            "TrueNAS" = {
              icon = "truenas.png";
              description = "Network attached storage";
              href = "http://files.gladiusso.com/";
              widget = {
                type = "truenas";
                url = "http://192.168.2.5";
                key = "2-zxkm2qUW2QEYpI5ir7uH4FbWCCcRACMQWpUQcc7p1IVFiguAw2mupH5uy1NJb8s5";
                enablePools = true;
                nasType = "scale";
              };
            };
          }
          {
            "Transmission" = {
              icon = "flood.png";
              description = "Transmission Torrent client daemon";
              href = "http://transmission.gladiusso.com/";
              widget = {
                type = "transmission";
                url = "http://192.168.2.4:9091";
                username = "transmission";
                password = "transmission";
              };
            };
          }
          {
            "Prowlarr" = {
              icon = "prowlarr.png";
              description = "Indexer manager/proxy";
              href = "http://prowlarr.gladiusso.com/";
              widget = {
                type = "prowlarr";
                url = "http://192.168.2.4:9696";
                key = "81a1edaecee6409982dad1ca3679702b";
              };
            };
          }
        ];
      }
      {
        "Apps" = [
          {
            "Open WebUI" = {
              icon = "ollama.png";
              description = "ChatGPT-like LLM interface for Ollama";
              href = "http://chatgpt.gladiusso.com";
            };
          }
          {
            "Immich" = {
              icon = "immich.png";
              description = "Photos and videos library";
              href = "http://photos.gladiusso.com";
              widget = {
                type = "immich";
                url = "http://192.168.2.8:3001";
                key = "Abfr3ZpazaDQyQVR1fnXi37bc5mjCnWOtzei8EsM";
              };
            };
          }
          {
            "Tandoor" = {
              icon = "tandoor.svg";
              description = "Tandoor recipe management";
              href = "http://recipes.gladiusso.com";
              widget = {
                type = "tandoor";
                url = "http://192.168.2.8:8001";
                key = "tda_da032849_5bb5_41c2_a896_705fa678af18";
              };
            };
          }
          {
            "Actual Budget" = {
              # docker-container
              icon = "si-6B46C1";
              description = "Budgeting tracker";
              href = "http://budget.gladiusso.com";
            };
          }
        ];
      }
      {
        "Media" = [
          {
            "Jellyfin" = {
              icon = "jellyfin.png";
              description = "Media library management";
              href = "http://jellyfin.gladiusso.com";
              widget = {
                type = "jellyfin";
                url = "http://192.168.2.4:8096";
                key = "a3355f333d504432b10ed80828bac800";
                enableBlocks = true;
                enableUser = true;
                showEpisodeNumber = true;
              };
            };
          }
          {
            "Radarr" = {
              icon = "radarr.png";
              description = "Movie tracker";
              href = "http://radarr.gladiusso.com/";
              widget = {
                type = "radarr";
                url = "http://192.168.2.4:7878";
                key = "0b48ea3ce99b41b3b6c9fd188ee57ecf";
              };
            };
          }
          {
            "Sonarr" = {
              icon = "sonarr.png";
              description = "TV show tracker";
              href = "http://sonarr.gladiusso.com";
              widget = {
                type = "sonarr";
                url = "http://192.168.2.4:8989";
                key = "8bff919c991d4a6a8337bbfa60145ace";
              };
            };
          }
          {
            "Lidarr" = {
              icon = "lidarr.png";
              description = "Music tracker";
              href = "http://lidarr.gladiusso.com";
              widget = {
                type = "lidarr";
                url = "http://192.168.2.4:8686";
                key = "722f86739c174f3487c520c29c34a09a";
              };
            };
          }
          {
            "slskd" = {
              icon = "soulseek.png";
              description = "Soulseek P2P music sharing";
              href = "http://slskd.gladiusso.com";
            };
          }
        ];
      }
    ];
  };
}
