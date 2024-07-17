{
  services.homepage-dashboard = {
    enable = true;

    settings = {
      title = "Joe's Homepage";
      startUrl = "https://home.gladiusso.com";

      background = {
        image = "https://github.com/V3ntus/nixos/blob/main/wallpapers/forest.jpg?raw=true";
        blur = "sm";
        brightness = 80;
      };
      theme = "dark";
      color = "amber";
      headerStyle = "boxedWidgets";
    };

    widgets = [
      { logo = {}; }
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

    services = [
      {
        "Network" = [
          {
            "Mikrotik" = {
              icon = "mikrotik.png";
              description = "Mikrotik Network Router";
              href = "http://192.168.2.1";
              widget = {
                type = "mikrotik";
                url = "http://192.168.2.1";
                username = "api";
                password = "coolpassword";
              };
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
        ];
      }
      {
        "Media" = [
          {
            "TrueNAS" = {
              icon = "truenas.png";
              description = "Network attached storage";
              href = "http://files.gladiusso.com/";
              widget = {
                type = "truenas";
                url = "http://files.gladiusso.com";
                key = "2-zxkm2qUW2QEYpI5ir7uH4FbWCCcRACMQWpUQcc7p1IVFiguAw2mupH5uy1NJb8s5";
                enablePools = true;
                nasType = "scale";
              };
            };
          }
        ];
      }
    ];
  };
}

