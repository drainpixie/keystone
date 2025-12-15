{
  config,
  lib,
  ...
}: let
  cfg = config.my.neovim;
  inherit (lib) mkIf;
in {
  config = mkIf cfg.enable {
    programs.nixvim = {
      plugins = {
        telescope.enable = mkIf (!cfg.minimal) true;
        web-devicons.enable = mkIf (!cfg.minimal) true;
      };

      keymaps = [
        {
          action = ":Telescope find_files<CR>";
          key = "<leader>ff";
          mode = "n";
          options.desc = "Find file in project.";
        }
        {
          action = ":Telescope live_grep<CR>";
          key = "<leader>fs";
          mode = "n";
          options.desc = "Find text in project.";
        }
        {
          action = ":Telescope git_files<CR>";
          key = "<leader>fg";
          mode = "n";
          options.desc = "Find file in git.";
        }
      ];
    };
  };
}
