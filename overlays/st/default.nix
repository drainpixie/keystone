self: super: {
  st = with super;
    st.overrideAttrs (oldAttrs: rec {
      config = super.writeText "config.def.h" (builtins.readFile ./config.h);
      buildInputs = oldAttrs.buildInputs ++ [super.harfbuzz];

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

          substituteInPlace config.mk \
            --replace "#LIGATURES_C = hb.c" "LIGATURES_C = hb.c" \
            --replace "#LIGATURES_H = hb.h" "LIGATURES_H = hb.h" \
            --replace "#LIGATURES_INC = `$(PKG_CONFIG) --cflags harfbuzz`" "LIGATURES_INC = `$(PKG_CONFIG) --cflags harfbuzz`" \
            --replace "#LIGATURES_LIBS = `$(PKG_CONFIG) --libs harfbuzz`" "LIGATURES_LIBS = `$(PKG_CONFIG) --libs harfbuzz`" \

          substituteInPlace patches.def.h \
            --replace-fail "#define REFLOW_PATCH 0" " #define REFLOW_PATCH                                         1" \
            --replace-fail "#define ANYSIZE_PATCH 0" " #define ANYSIZE_PATCH                                       1" \
            --replace-fail "#define CLIPBOARD_PATCH 0" " #define CLIPBOARD_PATCH                                   1" \
            --replace-fail "#define XRESOURCES_PATCH 0" " #define XRESOURCES_PATCH                                 1" \
            --replace-fail "#define XRESOURCES_RELOAD_PATCH 0" " #define XRESOURCES_RELOAD_PATCH                   1" \
            --replace-fail "#define BOLD_IS_NOT_BRIGHT_PATCH 0" " #define BOLD_IS_NOT_BRIGHT_PATCH                 1" \
            --replace-fail "#define BOXDRAW_PATCH 0" " #define BOXDRAW_PATCH                                       1" \
            --replace-fail "#define OPENURLONCLICK_PATCH 0" " #define OPENURLONCLICK_PATCH                         1" \
            --replace-fail "#define DRAG_AND_DROP_PATCH 0" " #define DRAG_AND_DROP_PATCH                           1" \
            --replace-fail "#define RIGHTCLICKTOPLUMB_PATCH 0" " #define RIGHTCLICKTOPLUMB_PATCH                   1" \
            --replace-fail "#define SCROLLBACK_PATCH 0" " #define SCROLLBACK_PATCH                                 1" \
            --replace-fail "#define SCROLLBACK_MOUSE_PATCH 0" " #define SCROLLBACK_MOUSE_PATCH                     1" \
            --replace-fail "#define SCROLLBACK_MOUSE_ALTSCREEN_PATCH 0" " #define SCROLLBACK_MOUSE_ALTSCREEN_PATCH 1" \
            --replace-fail "#define LIGATURES_PATCH 0" " #define LIGATURES_PATCH                                   1"
        '';
    });
}
