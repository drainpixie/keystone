{pkgs, ...}:
with pkgs; {
  # Fonts
  drafting-mono = callPackage ./drafting-mono.nix {};
  azuki = callPackage ./azuki.nix {};

  # Tools
  kc = callPackage ./kc.nix {};
  gign = callPackage ./gign {};

  # {,Neo}Vim
  ori = callPackage ./ori {};
  alabaster = callPackage ./alabaster {};

  # Apps
  helium = callPackage ./helium.nix {};
}
