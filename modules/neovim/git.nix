{
  config,
  lib,
  ...
}: {
  config = lib.mkIf config.my.neovim.enable {
    programs.nixvim = {
      plugins = {
        neogit = {
          enable = lib.mkIf (!config.my.neovim.minimal) true;

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
          enable = true;

          settings = {
            signs = {
              delete.text = "󰍵";
              changedelete.text = "󱕖";
            };
          };
        };
      };

      keymaps = lib.mkIf (!config.my.neovim.minimal) [
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
