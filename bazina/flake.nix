{
  description = "Nix konfigurace serveru Bažina";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-25.05";
    helix.url = "github:helix-editor/helix/master";
  };

  outputs = {self, nixpkgs, ...}@inputs : {
    nixosConfigurations.bazina = nixpkgs.lib.nixosSystem {
      system = "x86_64-linux";
      specialArgs = {inherit inputs; };
      modules = [
        ./hosts/bazina.nix
      ];
    };
  };

}
