{
  nixpkgs,
  inputs,
  self,
  ...
}: {
  setMany = import ./setMany.nix {inherit nixpkgs;};
  mkHost = import ./mkHost.nix {inherit nixpkgs inputs;};
  forAllSystems = import ./forAllSystems.nix {inherit nixpkgs self;};
}
