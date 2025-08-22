{
  nixpkgs,
  inputs,
  ...
}: {
  mkHost = import ./mkHost.nix {inherit nixpkgs inputs;};
  forAllSystems = import ./forAllSystems.nix {inherit nixpkgs;};
}
