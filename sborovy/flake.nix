{
  description = "Nix konfigurace sborového notebooku";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-25.05";
  };

  outputs = {self, nixpkgs, ...}@inputs : {
    nixosConfigurations.sborovy = nixpkgs.lib.nixosSystem {
      system = "x86_64-linux";
      specialArgs = {inherit inputs; };
      modules = [
        ./configuration.nix
      ];
    };
  };
}
