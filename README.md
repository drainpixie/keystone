# 🪨 keystone
nixos configuration for my systems

## hosts

- [timeline](./systems/timeline) dell latitude 5490
- [incubator](./systems/incubator) netcup 500 g11s 

## install 

```sh
# sudo nix run github:nix-community/disko -- --mode disko ./systems/hostname/disko.nix
# sudo nixos-rebuild switch --flake .#hostname
```

## layout 

- `lib/` -> custom functions
- `pkgs/` -> custom derivations
- `overlays/` -> custom overlays
- `secrets/` -> secrets managed via `agenix`
- `systems/<hostname>` -> system-specific configuration
- `modules/` -> mixed `NixOS` and `home-manager` modules 


