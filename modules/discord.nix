{
  config,
  lib,
  ...
}: {
  options.my.discord = lib.mkEnableOption "faye's discord configuration";

  config = lib.mkIf config.my.discord.enable {
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
