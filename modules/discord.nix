{
  config,
  lib,
  ...
}: let
  inherit (lib) mkIf mkEnableOption;
in {
  options.my.discord = mkEnableOption "faye's discord configuration";

  config = mkIf config.my.discord {
    hm = {
      programs.vesktop = {
        enable = true;
        settings = {
          arRPC = true;
          checkUpdates = false;
          discordBranch = "canary";
          hardwareAcceleration = true;
        };
      };

      services.arrpc.enable = true;
    };
  };
}
