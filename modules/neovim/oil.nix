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
      plugins.oil = {
        enable = true;
        settings = {
          columns = [
            "icon"
          ];

          preview = {
            border = "rounded";

            size = {
              width = 0.5;
              height = 0.5;
            };

            win_options = {
              winhighlight = "Normal:Normal,FloatBorder:Normal";
            };
          };

          view_options.show_hidden = true;
        };
      };

      keymaps = [
        {
          action = ":Oil<CR>";
          key = "-";
          mode = "n";
          options.desc = "Open parent directory";
        }
      ];
    };
  };
}
