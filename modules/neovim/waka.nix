{
  config,
  lib,
  ...
}: let
  inherit (lib) mkIf;
  cfg = config.my.neovim;
in {
  config = mkIf (cfg.enable && !cfg.minimal) {
    programs.nixvim.plugins.wakatime.enable = true;
  };
}
