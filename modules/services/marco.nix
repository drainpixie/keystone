{
  config,
  tools,
  lib,
  ...
}: let
  cfg = config.rin.services.marco;
  inherit (lib) types mkIf mkOption;
in {
  options.rin.services.marco = tools.mkServiceOption "marco" {
    port = 3004;

    extraConfig.secretFile = mkOption {
      type = types.path;
      description = "Path to marco secret file";
      default = null;
    };
  };

  config = mkIf cfg.enable {
    services.marco = {
      inherit (cfg) port;

      enable = true;
      environmentFile = cfg.secretFile;
    };
  };
}
