{
  pkgs,
  inputs,
  ...
}: let
  wallpaper_filenames =
    builtins.map (name: ../../../../wallpapers + "/${name}")
    (builtins.filter (f: builtins.match "^.*\\.(jpg|jpeg|png)$" f != null)
      (builtins.attrNames (builtins.readDir ../../../../wallpapers)));
  awww = "${inputs.awww.packages.x86_64-linux.awww}/bin/awww";
  awww-daemon = "${inputs.awww.packages.x86_64-linux.awww}/bin/awww-daemon";
  change_wallpaper = pkgs.writeShellScriptBin "change_wallpaper" ''
    set -e
    while true; do
      BG=`find ${../../../../wallpapers} -name "*.jpg" -o -name "*.png" | shuf -n1`
      if pgrep -f ${awww-daemon} >/dev/null; then
        ${awww} img  \
          --transition-fps 60 \
          --transition-duration 2 \
          --transition-type random \
          --transition-pos top-right \
          --transition-bezier .3,0,0,.99 \
          --transition-angle 135 \
          "$BG" || true
      else
        (${awww-daemon} 1>/dev/null 2>/dev/null &) || true
      fi
      sleep 1800
    done
  '';
in {
  home.packages = [inputs.awww.packages.${pkgs.stdenv.hostPlatform.system}.awww change_wallpaper];
}
