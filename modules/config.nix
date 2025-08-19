{
  lib,
  opts,
  ...
}: {
  options = {
    user = lib.mkOption {
      type = lib.types.str;
      default = "user";
      description = "The username for the host configuration.";
    };

    email = lib.mkOption {
      type = lib.types.str;
      default = "at@noreply.me"; # tip: use noreply github email
    };

    host = lib.mkOption {
      type = lib.types.str;
      default = "hostname";
      description = "The hostname for the host configuration.";
    };

    editor = lib.mkOption {
      type = lib.types.str;
      default = "nvim";
      description = "The default editor for the host configuration.";
    };

    architecture = lib.mkOption {
      type = lib.types.str;
      default = "x86_64-linux";
      description = "The architecture for the host configuration.";
    };
  };

  config = {
    fonts.fontconfig.enable = true;
    networking.hostName = opts.host;

    i18n.defaultLocale = "en_US.UTF-8";
    time.timeZone = "Europe/Rome";

    hm = {
      home.homeDirectory = "/home/${opts.user}";

      sessionVariables = {
        EDITOR = opts.editor;
        MANPAGER = lib.mkIf (opts.editor == "nvim") "nvim +Man!";
      };

      programs = {
        home-manager.enable = true;

        git = {
          enable = true;
          delta.enable = true;

          userName = opts.user;
          userEmail = opts.email;
        };
      };
    };
  };
}
