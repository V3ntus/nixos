{pkgs, ...}: let
  fermiSrc = pkgs.fetchgit {
    url = "https://github.com/V3ntus/Fermi";
    rev = "18d0f786e41c201c519e8940b77a3ea157ccf210";
    outputHash = "sha256-BH3xbERTSl+gN8e8gwtQ4+rNO51ttFEGD87Vy171Wno";
    leaveDotGit = true;
  };
  fermiPkg = pkgs.buildNpmPackage {
    pname = "fermi";
    version = "0.1.0";
    src = fermiSrc;
    npmDepsHash = "sha256-xGSX5BRF9jT83FtTyKs8qU6uwFWr1UTy1luIaFDTm3g";
    nativeBuildInputs = [ pkgs.git ];
    postPatch = ''
      cp -r ${fermiSrc}/.git ./
    '';
  };
in {
  systemd.services.fermi = {
    description = "Fermi client";
    wantedBy = ["multi-user.target"];
    after = ["network.target"];

    environment = {
      NODE_ENV = "production";
      PORT = "3002";
    };

    serviceConfig = {
      ExecStart = "${pkgs.nodejs_24}/bin/npm start --prefix ${fermiPkg}/lib/node_modules/jankclient";
      Restart = "on-failure";
      RestartSec = "5s";

      DynamicUser = true;
      PrivateTmp = true;
      NoNewPrivileges = true;
    };
  };
}
