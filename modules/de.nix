{
  config,
  pkgs,
  lib,
  ...
}: let
  gnome = import ./gnome.nix {inherit config pkgs lib;};
  # berry = import ./berry.nix {inherit config pkgs lib;};

  st-config = pkgs.writeText "config.def.h" (builtins.readFile ./config.h);
in {
  options.my.layout = lib.mkOption {
    type = lib.types.str;
    default = "it";
    description = "The keyboard layout to use.";
  };

  options.my.de = lib.mkOption {
    type = lib.types.enum ["gnome" "berry"];
    default = "gnome";
    description = "faye's desktop environments";
  };

  config = lib.mkMerge [
    {
      security.rtkit.enable = true;

      services = {
        xserver = {
          enable = true;
          xkb.layout = config.my.layout;

          excludePackages = builtins.attrValues {
            inherit
              (pkgs)
              xterm
              ;
          };
        };

        pipewire = {
          enable = true;
          alsa.enable = true;
          pulse.enable = true;
          jack.enable = true;
        };

        displayManager.ly.enable = true;
      };

      # todo: theme
      hm = {
        home.packages = builtins.attrValues {
          inherit (pkgs) st;
        };

        xresources.properties = {
          "st.font" = "Drafting Mono:light:size=10:antialias=true:autohint=true";
          "st.boldfont" = "Drafting Mono:bold:size=10";

          "st.background" = "#ffffff";
          "st.foreground" = "#1b1918";
          "st.cursorColor" = "#d65d0e";

          "st.color0" = "#f7f4e8";
          "st.color1" = "#cc231d";
          "st.color2" = "#98971a";
          "st.color3" = "#d79921";
          "st.color4" = "#458588";
          "st.color5" = "#b16286";
          "st.color6" = "#689d6a";
          "st.color7" = "#1b1918";

          "st.color8" = "#eee8d5";
          "st.color9" = "#fb4934";
          "st.color10" = "#b8bb26";
          "st.color11" = "#fabd2f";
          "st.color12" = "#83a598";
          "st.color13" = "#d3869b";
          "st.color14" = "#8ec07c";
          "st.color15" = "#1b1918";

          "st.termName" = "st-256color";

          "st.borderpx" = 16;
          "st.highlightfg" = 0;
          "st.highlightbg" = 11;
        };
      };
    }

    (lib.mkIf (config.my.de == "gnome") gnome)
  ];
}
