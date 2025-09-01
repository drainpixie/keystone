{
  config,
  lib,
  ...
}: {
  config = lib.mkIf (config.my.neovim.enable && !config.my.neovim.minimal) {
    programs.nixvim.plugins.wakatime.enable = true;

    # note: we use a selfhosted wakaapi instance because the official one is sucky
    # and very paywalled :(
    services.wakapi = {
      passwordSalt = "wait-for-sops";

      enable = true;
      database.createLocally = true;

      settings = {
        server.port = 6969;
        security.allow_signup = false;

        db = {
          port = 5432;
          host = "127.0.0.1";
          user = "wakapi";
          name = "wakapi";
          dialect = "postgres";
        };
      };
    };
  };
}
