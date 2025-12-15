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
    extraConfig.secretFile = mkOption {
      type = types.path;
      description = "Path to marco secret file";
      default = null;
    };
  };

  config = mkIf cfg.enable {
    services.marco = {
      enable = true;
      environmentFile = cfg.secretFile;
    };
  };
}
