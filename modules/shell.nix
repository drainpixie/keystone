{
  config,
  lib,
  ...
}: {
  options.shell.zsh = {
    enable = lib.mkEnableOption "faye's zsh configuration with modern CLI tools";
    minimal = lib.mkEnableOption "minimal zsh configuration with fewer tools"; # server use
  };

  config = lib.mkIf config.shell.zsh.enable {
    programs = {
      direnv = {
        enable = true;
        enableZshIntegration = true;
      };

      zoxide = lib.mkIf (!config.shell.zsh.minimal) {
        enable = true;
        enableZshIntegration = true;
      };

      fzf = {
        enable = true;
        enableZshIntegration = true;
      };

      eza = {
        enable = true;
        enableZshIntegration = true;

        extraOptions = [
          "--group-directories-first"
          "--sort=ext"
        ];
      };

      ripgrep = {
        enable = true;

        arguments = [
          "--hidden"
          "--smart-case"
        ];
      };

      bat = lib.mkIf (!config.shell.zsh.minimal) {
        enable = true;
        config = {
          theme = "ansi";
          style = "plain";
        };
      };

      zsh = {
        enable = true;
        enableCompletion = true;
        autosuggestion.enable = !config.shell.zsh.minimal;
        syntaxHighlighting.enable = !config.shell.zsh.minimal;
        historySubstringSearch.enable = !config.shell.zsh.minimal;

        history = {
          extended = true;
          ignoreDups = true;
          ignoreSpace = true;
        };

        setOptions = [
          "HIST_APPEND"
          "HIST_REDUCE_BLANKS"
          "HIST_SAVE_NO_DUPS"
          "HIST_VERIFY"
          "EXTENDED_GLOB"
          "GLOB_DOTS"
          "AUTO_CD"
          "CORRECT"
          "NO_CASE_GLOB"
        ];

        shellAliases = {
          c = "clear";
          cd = lib.mkIf (!config.shell.zsh.minimal) "z";
          mkdir = "mkdir -pv";

          df = "df -h";
          du = "du -h";
          free = "free -h";
          wget = "wget -c";
          ping = "ping -c 5";

          rm = "rm -i";
          mv = "mv -i";

          cat = lib.mkIf (!config.shell.zsh.minimal) "bat";
          grep = "rg --color=always --hidden --smart-case";
        };
      };
    };
  };
}
