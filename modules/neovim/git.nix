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
        neogit = {
          enable = mkIf (!cfg.minimal) true;

          settings = {
            signs = {
              section = [
                ""
                ""
              ];

              item = [
                ""
                ""
              ];

              hunk = [
                ""
                ""
              ];
            };

            integrations.telescope = true;

            status = {
              recent = true;
              signs = {
                section = [
                  ""
                  ""
                ];
                item = [
                  ""
                  ""
                ];
                hunk = [
                  ""
                  ""
                ];
              };
            };
          };
        };

        gitsigns = {
          enable = mkIf (!cfg.minimal) true;

          settings = {
            signs = {
              delete.text = "󰍵";
              changedelete.text = "󱕖";
            };
          };
        };
      };

      keymaps = mkIf (!cfg.minimal) [
        {
          action = ":Neogit kind=auto<CR>";
          key = "<leader>g";
          mode = "n";
          options.desc = "Open Neogit";
        }
      ];
    };
  };
}
