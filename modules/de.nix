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
    }

    (lib.mkIf (config.my.de == "gnome") gnome)
  ];
}
