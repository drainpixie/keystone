{
  opts,
  pkgs,
  ...
}: {
  fonts.fontconfig.enable = true;
  systemd.user.startServices = "sd-switch";

  home = {
    homeDirectory = "/home/${opts.user}";

    sessionVariables = {
      EDITOR = "nvim";
      MANPAGER = "nvim +Man!";
    };

    packages = let
      minecraft = pkgs.prismlauncher.override {
        jdks = builtins.attrValues {
          inherit (pkgs) temurin-bin-21 temurin-bin-17 temurin-bin-8;
        };
      };

      # todo: declarative, we use settingssync right now
      insiders = (pkgs.vscode.override {isInsiders = true;}).overrideAttrs (oldAttrs: {
        src = fetchTarball {
          url = "https://code.visualstudio.com/sha/download?build=insider&os=linux-x64";
          sha256 = "06lvxcd01idv6y6305qwq0n6vn942z9lfs526nd83vp35jasayv4";
        };

        version = "latest";
        buildInputs = oldAttrs.buildInputs ++ [pkgs.krb5];
      });
    in
      builtins.attrValues {
        # cli
        inherit
          (pkgs)
          man-pages
          man-pages-posix
          wl-clipboard
          xclip
          xsel
          du-dust
          strace
          tokei
          wget
          curl
          fd
          jq
          ;

        # apps
        inherit
          (pkgs)
          telegram-desktop
          signal-desktop
          google-chrome
          pavucontrol
          zathura
          vesktop
          gparted
          bruno
          nsxiv
          mpv
          ;

        # fonts
        inherit (pkgs) meslo-lgs-nf;
        inherit (pkgs.faye) drafting-mono beedii azuki;
      }
      ++ [
        minecraft
        insiders.fhs
      ];
  };

  xdg = {
    userDirs = {
      enable = true;

      music = "$HOME/msc";
      videos = "$HOME/vid";
      desktop = "$HOME/dsk";
      download = "$HOME/dwl";
      pictures = "$HOME/img";
      documents = "$HOME/doc";
    };

    mimeApps.defaultApplications = {
      "text/html" = "google-chrome.desktop";
      "text/plain" = "code.desktop";

      "application/pdf" = "zathura.desktop";
      "application/epub+zip" = "zathura.desktop";

      "image/*" = "nsxiv.desktop";
      "video/*" = "mpv.desktop";
    };
  };

  programs = {
    home-manager.enable = true;

    git = {
      enable = true;
      delta.enable = true;

      userName = opts.user;
      userEmail = "121581793+drainpixie@users.noreply.github.com";
    };

    alacritty = {
      enable = true;
      settings = {
        window = {
          padding = {
            x = 16;
            y = 16;
          };
        };

        font = {
          normal.family = "Drafting Mono ExtraLight";
          size = 10;
        };

        keyboard = {
          bindings = [
            {
              key = "C";
              mods = "Control|Shift";
              action = "Copy";
            }
            {
              key = "V";
              mods = "Control|Shift";
              action = "Paste";
            }
          ];
        };

        # todo: split theme in module
        colors = {
          primary = {
            background = "0xf7f7f7";
            foreground = "0x000000";
          };

          normal = {
            black = "0x282a2e";
            red = "0xaa3731";
            green = "0x448c27";
            yellow = "0xcb9000";
            blue = "0x325cc0";
            magenta = "0x7a3e9d";
            cyan = "0x0083b2";
            white = "0x707880";
          };

          bright = {
            black = "0x373b41";
            red = "0xf05050";
            green = "0x60cb00";
            yellow = "0xffbc5d";
            blue = "0x007acc";
            magenta = "0xe64ce6";
            cyan = "0x00aacb";
            white = "0xc5c8c6";
          };
        };
      };
    };
  };
}
