props:
builtins.listToAttrs (
  map (name: {
    inherit name;
    value = {
      enable = true;
    };
  })
  props
)
