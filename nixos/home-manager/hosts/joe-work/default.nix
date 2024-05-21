{pkgs, ...}: {
  imports = [
    ../default.nix
  ];

  home.packages = with pkgs; [
    teams-for-linux
  ];

  programs.plasma = {
    enable = true;
    configFile = {
      "kcminputrc"."Libinput/1133/49291/Logitech G502 HERO Gaming Mouse"."PointerAcceleration" = "-0.350";
      "kcminputrc"."Libinput/1133/49291/Logitech G502 HERO Gaming Mouse"."PointerAccelerationProfile" = 1;
      "kcminputrc"."Mouse"."cursorTheme" = "Adwaita";
      "kded5rc"."Module-browserintegrationreminder"."autoload" = false;
      "kded5rc"."Module-device_automounter"."autoload" = false;
      "kded5rc"."PlasmaBrowserIntegration"."shownCount" = 2;
      "kdeglobals"."General"."BrowserApplication" = "google-chrome.desktop";
      "kdeglobals"."General"."XftHintStyle" = "hintnone";
      "kdeglobals"."General"."XftSubPixel" = "none";
      "kdeglobals"."General"."font" = "SF Pro Display,10,-1,5,50,0,0,0,0,0";
      "kdeglobals"."General"."menuFont" = "SF Pro Display,10,-1,5,400,0,0,0,0,0,0,0,0,0,0,1";
      "kdeglobals"."General"."smallestReadableFont" = "SF Pro Display,8,-1,5,400,0,0,0,0,0,0,0,0,0,0,1";
      "kdeglobals"."General"."toolBarFont" = "SF Pro Display,10,-1,5,400,0,0,0,0,0,0,0,0,0,0,1";
      "kdeglobals"."KDE"."AnimationDurationFactor" = 1.414213562373095;
      "kdeglobals"."WM"."activeBackground" = "39,39,39";
      "kdeglobals"."WM"."activeBlend" = "235,219,178";
      "kdeglobals"."WM"."activeFont" = "SF Pro Display,10,-1,5,400,0,0,0,0,0,0,0,0,0,0,1";
      "kdeglobals"."WM"."activeForeground" = "235,219,178";
      "kdeglobals"."WM"."inactiveBackground" = "40,40,40";
      "kdeglobals"."WM"."inactiveBlend" = "60,56,54";
      "kdeglobals"."WM"."inactiveForeground" = "204,190,155";
      "kiorc"."Confirmations"."ConfirmDelete" = true;
      "kscreenlockerrc"."Daemon"."Autolock" = false;
      "kwinrc"."Effect-blur"."BlurStrength" = 11;
      "kwinrc"."Effect-blur"."NoiseStrength" = 10;
      "kwinrc"."Effect-overview"."BorderActivate" = "0,1";
      "kwinrc"."Effect-windowview"."BorderActivateAll" = 7;
      "kwinrc"."NightColor"."Active" = true;
      "kwinrc"."NightColor"."Mode" = "Constant";
      "kwinrc"."NightColor"."NightTemperature" = 3700;
      "kwinrc"."Plugins"."blurEnabled" = true;
      "kwinrc"."Plugins"."contrastEnabled" = true;
      "kwinrc"."Plugins"."diminactiveEnabled" = true;
      "kwinrc"."Plugins"."dimscreenEnabled" = true;
      "kwinrc"."Plugins"."glideEnabled" = true;
      "kwinrc"."Plugins"."scaleEnabled" = false;
      "kwinrc"."Plugins"."sheetEnabled" = true;
      "kwinrc"."Plugins"."slidebackEnabled" = true;
      "kwinrc"."Plugins"."translucencyEnabled" = true;
      "kwinrc"."Plugins"."wobblywindowsEnabled" = true;
      "kwinrc"."Plugins"."zoomEnabled" = false;
      "kwinrc"."TabBox"."LayoutName" = "thumbnail_grid";
      "kwinrc"."Tiling"."padding" = 4;
      "kwinrc"."Tiling/0f3e92e3-faa3-5dfc-b1d1-ac678b0e825b"."tiles" = "{\"layoutDirection\":\"horizontal\",\"tiles\":[{\"width\":0.5},{\"width\":0.5}]}";
      "kwinrc"."Tiling/166fc7be-de38-5546-b0ac-9a3de280b2a3"."tiles" = "{\"layoutDirection\":\"horizontal\",\"tiles\":[{\"width\":0.15},{\"width\":0.5999999999999972},{\"width\":0.25}]}";
      "kwinrc"."Tiling/2a8ad0c0-6539-5be5-9996-2f375060ce27"."tiles" = "{\"layoutDirection\":\"horizontal\",\"tiles\":[{\"width\":0.25},{\"width\":0.5},{\"width\":0.25}]}";
      "kwinrc"."Tiling/3e04a44c-46aa-52e6-81ed-68511649c75f"."tiles" = "{\"layoutDirection\":\"horizontal\",\"tiles\":[{\"width\":0.25},{\"width\":0.5},{\"width\":0.25}]}";
      "kwinrc"."Tiling/56163380-abdf-5bab-81c9-1cd1b1465987"."tiles" = "{\"layoutDirection\":\"horizontal\",\"tiles\":[{\"width\":0.25},{\"width\":0.5},{\"width\":0.25}]}";
      "kwinrc"."Tiling/5ed5b675-3186-5614-b0c9-483298e6265b"."tiles" = "{\"layoutDirection\":\"horizontal\",\"tiles\":[{\"width\":0.5},{\"width\":0.5}]}";
      "kwinrc"."Tiling/abb448ec-e5a2-5d72-8ca7-28b317fc23d5"."tiles" = "{\"layoutDirection\":\"horizontal\",\"tiles\":[{\"width\":0.48515625},{\"width\":0.51484375}]}";
      "kwinrc"."Tiling/d02c035d-eef0-5c68-aa2f-2e83d0ba08b1"."tiles" = "{\"layoutDirection\":\"horizontal\",\"tiles\":[{\"width\":0.25},{\"width\":0.5},{\"width\":0.25}]}";
      "kwinrc"."Tiling/d7b8289c-bab0-5564-996b-d608cae1f46b"."tiles" = "{\"layoutDirection\":\"horizontal\",\"tiles\":[{\"width\":0.509765625},{\"width\":0.49023437499999867}]}";
      "kwinrc"."Tiling/dbbea391-e957-52bf-86df-4b0797058cb4"."tiles" = "{\"layoutDirection\":\"horizontal\",\"tiles\":[{\"width\":0.25},{\"width\":0.5},{\"width\":0.25}]}";
      "kwinrc"."Tiling/ff5e7034-aca0-5198-bc0f-2bc56ffc1f05"."tiles" = "{\"layoutDirection\":\"horizontal\",\"tiles\":[{\"width\":0.25},{\"width\":0.5},{\"width\":0.25}]}";
      "kwinrc"."Windows"."ElectricBorderCornerRatio" = 0.15;
      "kwinrc"."Xwayland"."Scale" = 1;
      "kwinrc"."org.kde.kdecoration2"."BorderSize" = "Tiny";
      "kwinrc"."org.kde.kdecoration2"."BorderSizeAuto" = false;
      "kwinrc"."org.kde.kdecoration2"."ButtonsOnLeft" = "M";
      "kwinrc"."org.kde.kdecoration2"."ButtonsOnRight" = "IAX";
      "kwinrulesrc"."0ff45cd4-a56a-4eb0-bc79-5b1aef4bfe45"."Description" = "Picture in picture";
      "kwinrulesrc"."0ff45cd4-a56a-4eb0-bc79-5b1aef4bfe45"."above" = true;
      "kwinrulesrc"."0ff45cd4-a56a-4eb0-bc79-5b1aef4bfe45"."aboverule" = 3;
      "kwinrulesrc"."0ff45cd4-a56a-4eb0-bc79-5b1aef4bfe45"."types" = 1;
      "kwinrulesrc"."0ff45cd4-a56a-4eb0-bc79-5b1aef4bfe45"."wmclass" = "chrome chrome";
      "kwinrulesrc"."0ff45cd4-a56a-4eb0-bc79-5b1aef4bfe45"."wmclasscomplete" = true;
      "kwinrulesrc"."0ff45cd4-a56a-4eb0-bc79-5b1aef4bfe45"."wmclassmatch" = 1;
      "kwinrulesrc"."1"."Description" = "Picture in picture";
      "kwinrulesrc"."1"."above" = true;
      "kwinrulesrc"."1"."aboverule" = 3;
      "kwinrulesrc"."1"."types" = 1;
      "kwinrulesrc"."1"."wmclass" = "chrome chrome";
      "kwinrulesrc"."1"."wmclasscomplete" = true;
      "kwinrulesrc"."1"."wmclassmatch" = 1;
      "kwinrulesrc"."General"."count" = 1;
      "kwinrulesrc"."General"."rules" = 1;
      "plasmarc"."Theme"."name" = "ROUNDED-COLOR";
    };
  };
}
