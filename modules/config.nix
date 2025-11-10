{
  lib,
  pkgs,
  config,
  inputs,
  ...
}: let
  inherit (lib) mkIf mkMerge mkOption types optionals;
  cfg = config.my;
in {
  options.my = {
    git = {
      name = mkOption {
        type = types.nonEmptyStr;
        default = "User Name";
        description = "The name of the `git` user.";
      };

      email = mkOption {
        type = types.nonEmptyStr;
        default = "at@noreply.me";
        description = "The email of the `git` user.";
      };
    };

    age = mkOption {
      type = types.bool;
      default = false;
      description = "Enable `age` support.";
    };

    user = mkOption {
      type = types.nonEmptyStr;
      default = "user";
      description = "The username of the host configuration.";
    };

    docker = mkOption {
      type = types.bool;
      default = false;
      description = "Enable `docker` support.";
    };

    bluetooth = mkOption {
      type = types.bool;
      default = false;
      description = "Enable bluetooth support.";
    };

    vm = mkOption {
      type = types.bool;
      default = false;
      description = "Enable VM support for testing purposes.";
    };

    host = mkOption {
      type = types.nonEmptyStr;
      default = "hostname";
      description = "The hostname of the host configuration.";
    };

    editor = mkOption {
      type = types.str;
      default = "nvim";
      description = "The default editor.";
    };

    architecture = mkOption {
      type = types.nonEmptyStr;
      default = "x86_64-linux";
      description = "The architecture of the host configuration.";
    };
  };

  config = {
    nixpkgs.config.allowUnfreePredicate = _: true;

    fonts.fontconfig.enable = true;
    networking.hostName = cfg.host;

    i18n.defaultLocale = "en_US.UTF-8";
    time.timeZone = "Europe/Rome";

    users.users.${cfg.user} = {
      uid = 1000;
      isNormalUser = true;
      home = "/home/${cfg.user}";
      initialPassword = "changeme";
      extraGroups = ["wheel" "audio" "video"] ++ optionals cfg.docker ["docker"];
    };

    hardware.bluetooth = mkIf cfg.bluetooth {
      enable = true;
      powerOnBoot = true;
    };

    virtualisation = mkMerge [
      (mkIf cfg.vm {
        vmVariant.virtualisation = {
          graphics = true;
          cores = 4;
          memorySize = 4 * 1024;
        };
      })

      (mkIf cfg.docker {
        docker = {
          enable = true;
        };
      })
    ];

    nix = {
      settings = {
        experimental-features = "nix-command flakes";
        auto-optimise-store = true;
        warn-dirty = false;
        trusted-users = [cfg.user];
      };
      gc = {
        automatic = true;
        dates = "monthly";
        options = "--delete-older-than 30d";
      };
    };

    console = {
      font = "Lat2-Terminus16";
      keyMap = "it";
    };

    hm = {
      programs = {
        home-manager.enable = true;
        git = {
          enable = true;

          settings = {
            user = cfg.git;
            core.editor = cfg.editor;

            color.ui = "auto";
            pull.rebase = true;
            delta.enable = true;
            init.defaultBranch = "main";
          };
        };
      };

      home = {
        homeDirectory = "/home/${cfg.user}";

        sessionVariables = {
          EDITOR = cfg.editor;
          MANPAGER = mkIf (cfg.editor == "nvim") "nvim +Man!";
        };

        packages = mkMerge [
          (mkIf cfg.docker [pkgs.docker pkgs.docker-compose])
          (mkIf cfg.age [inputs.age.packages.${cfg.architecture}.default])
        ];
      };
    };
  };
}
