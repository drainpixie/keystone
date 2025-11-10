{
  config,
  pkgs,
  lib,
  ...
}: let
  inherit (lib) mkIf;
  cfg = config.my.neovim;
in {
  config = mkIf cfg.enable {
    programs.nixvim = {
      extraPlugins = builtins.attrValues {inherit (pkgs.vimPlugins) lualine-nvim;};
      extraConfigLua = builtins.readFile ./line.lua;
    };
  };
}
