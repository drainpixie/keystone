{
  config,
  lib,
  ...
}: {
  options.my.steam = lib.mkEnableOption "faye's steam configuration";

  config = lib.mkIf config.my.steam {
    nixpkgs.config.allowUnfreePredicate = pkg:
      builtins.elem (lib.getName pkg) [
        "steam"
        "steam-run"
        "steam-original"
      ];

    programs.steam = {
      enable = true;
      remotePlay.openFirewall = true;
      dedicatedServer.openFirewall = true;
      localNetworkGameTransfers.openFirewall = true;
    };
  };
}
