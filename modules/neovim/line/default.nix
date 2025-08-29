{
  config,
  pkgs,
  lib,
  ...
}: {
  config = lib.mkIf config.my.neovim.enable {
    programs.nixvim = {
      # One day I'll be courageous enough to write this in pure Nix -- that day, is not today.
      extraPlugins = builtins.attrValues {inherit (pkgs.vimPlugins) lualine-nvim;};
      extraConfigLua = builtins.readFile ./line.lua;
    };
  };
}
