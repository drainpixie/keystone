{
  config,
  pkgs,
  lib,
  ...
}: {
  config = lib.mkIf config.my.neovim.enable {
    programs.nixvim = {
      plugins.oil = {
        enable = true;
        settings = {
          columns = [
            "permissions"
            "size"
            "mtime"
          ];

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
