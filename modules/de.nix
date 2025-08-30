{
  config,
  pkgs,
  lib,
  ...
}: let
  gnome = import ./gnome.nix {inherit config pkgs lib;};
  # berry = import ./berry.nix {inherit config pkgs lib;};
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
          "st.font" = "Hasklug Nerd Font:size=10:antialias=true:autohint=true";
          "st.boldfont" = "Hasklug Nerd Font:bold:size=10";
          "st.termName" = "st-256color";
          "st.borderpx" = 16;
          "st.highlightfg" = 0;
          "st.highlightbg" = 11;

          "*.foreground" = "#383a42";
          "*.background" = "#ffffff";
          "*.cursorColor" = "#cccccc";
          "*.pointerColor" = "#555555";

          "*.color0" = "#ffffff";
          "*.color1" = "#e45649";
          "*.color2" = "#50a14f";
          "*.color3" = "#c18401";
          "*.color4" = "#0184bc";
          "*.color5" = "#a626a4";
          "*.color6" = "#0997b3";
          "*.color7" = "#383a42";
          "*.color8" = "#ffffff";
          "*.color9" = "#e45649";
          "*.color10" = "#50a14f";
          "*.color11" = "#c18401";
          "*.color12" = "#0184bc";
          "*.color13" = "#a626a4";
          "*.color14" = "#0997b3";
          "*.color15" = "#383a42";
        };
      };
    }

    (lib.mkIf (config.my.de == "gnome") gnome)
  ];
}
