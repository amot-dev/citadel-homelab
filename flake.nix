{
  description = "Minimal NixOS config for the 'citadel' server";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-24.05";
    nixos-anywhere.url = "github:nix-community/nixos-anywhere";
    disko.url = "github:nix-community/disko";
  };

  outputs = { self, nixpkgs, nixos-anywhere, disko, ... }: {
    nixosConfigurations.citadel = nixpkgs.lib.nixosSystem {
      system = "x86_64-linux";
      modules = [
        ./hosts/citadel.nix
        disko.nixosModules.disko
        ./disko-config.nix
      ];
    };
  };
}

