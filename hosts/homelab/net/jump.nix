{lib, ...}: let
  jumpPort = 8182;
  inventory = import ../inventory.nix;
in {
  networking.firewall.allowedTCPPorts = [
    jumpPort
  ];

  services.sshwifty = {
    enable = true;
    settings = {
      SharedKey = "";
      Servers = [
        {
          ListenInterface = "0.0.0.0";
          ListenPort = jumpPort;
          ReadTimeout = 300;
          ServerMessage = "CS30 Jump Server";
        }
      ];
      Presets = builtins.map (h: {
        Title = h.name;
        Type = "SSH";
        Host = h.value.ip;
      }) (lib.attrsToList inventory.hosts);
      OnlyAllowPresetRemotes = false;
    };
  };
}
