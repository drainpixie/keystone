{
  config,
  lib,
  ...
}: {
  config = lib.mkIf (config.my.neovim.enable && !config.my.neovim.minimal) {
    programs.nixvim.plugins.wakatime.enable = true;
  };
}
