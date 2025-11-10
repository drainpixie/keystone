{
  config,
  lib,
  ...
}: let
  inherit (lib) mkIf getName mkEnableOption;
in {
  options.my.steam = mkEnableOption "faye's steam configuration";

  config = mkIf config.my.steam {
    nixpkgs.config.allowUnfreePredicate = pkg:
      builtins.elem (getName pkg) [
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
