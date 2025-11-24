{
  description = "NixOS system for nyx";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-25.05";
    agenix.url = "github:ryantm/agenix";
  };

  outputs = { self, nixpkgs, agenix }:
  let
    system = "x86_64-linux";
  in {
    nixosConfigurations.nyx = nixpkgs.lib.nixosSystem {
      inherit system;

      modules = [
        ./hosts/nyx/configuration.nix
        agenix.nixosModules.default
      ];
    };
  };
}
