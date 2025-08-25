self: super: {
  st = with super;
    st.overrideAttrs (oldAttrs: rec {
      config = super.writeText "config.def.h" (builtins.readFile ./config.h);

      src = fetchFromGitHub {
        owner = "bakkeby";
        repo = "st-flexipatch";
        rev = "bdb21ddb8bdffa372b2870407a2869d5c5a822f3";
        sha256 = "sha256-U5jE+vQJJODmpUA5eWZ6BNPG/uLSi70WLoFUAWt0kuA==";
      };

      postPatch =
        oldAttrs.postPatch
        + ''
          cp ${config} config.def.h

          substituteInPlace patches.def.h \
            --replace "#define REFLOW_PATCH 0" " #define REFLOW_PATCH                                         1" \
            --replace "#define ANYSIZE_PATCH 0" " #define ANYSIZE_PATCH                                       1" \
            --replace "#define AUTOCOMPLETE_PATCH 0" " #define AUTOCOMPLETE_PATCH                             1" \
            --replace "#define CLIPBOARD_PATCH 0" " #define CLIPBOARD_PATCH                                   1" \
            --replace "#define XRESOURCES_PATCH 0" " #define XRESOURCES_PATCH                                 1" \
            --replace "#define XRESOURCES_RELOAD_PATCH 0" " #define XRESOURCES_RELOAD_PATCH                   1" \
            --replace "#define BOLD_IS_NOT_BRIGHT_PATCH 0" " #define BOLD_IS_NOT_BRIGHT_PATCH                 1" \
            --replace "#define BOXDRAW_PATCH 0" " #define BOXDRAW_PATCH                                       1" \
            --replace "#define CLICKURL_PATCH 0" " #define CLICKURL_PATCH                                     1" \
            --replace "#define COLORSCHEMES_PATCH 0" " #define COLORSCHEMES_PATCH                             1" \
            --replace "#define DRAGANDDROP_PATCH 0" " #define DRAGANDDROP_PATCH                               1" \
            --replace "#define RIGHTCLICKTOPLUMB_PATCH 0" " #define RIGHTCLICKTOPLUMB_PATCH                   1" \
            --replace "#define SCROLLBACK_PATCH 0" " #define SCROLLBACK_PATCH                                 1" \
            --replace "#define SCROLLBACK_MOUSE_PATCH 0" " #define SCROLLBACK_MOUSE_PATCH                     1" \
            --replace "#define SCROLLBACK_MOUSE_ALTSCREEN_PATCH 0" " #define SCROLLBACK_MOUSE_ALTSCREEN_PATCH 1"
        '';
    });
}
