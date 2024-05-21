{pkgs, ...}: let
  pythonEnv = pkgs.python312.withPackages (p:
    with p; [
      pip
      requests
    ]);
in {
  home.packages = [pythonEnv];
}
