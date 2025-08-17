{
  opts,
  pkgs,
  ...
}: {
  # home = {
  #   username = opts.user;
  #   homeDirectory = lib.mkForce "/home/${opts.user}";
  # };

  programs.git = {
    enable = true;

    delta.enable = true;

    userName = opts.user;
    userEmail = "121581793+drainpixie@users.noreply.github.com";
  };
}
