{
  description = "Nix konfigurace všech systému, které spravuji";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-25.11";
    ekkles.url = "github:robinvolf/ekkles/v26.02";
    prismlauncher.url = "github:Diegiwg/PrismLauncher-Cracked/10.0.2";
  };

  outputs = {self, nixpkgs, ...}@inputs : {
    nixosConfigurations.sborovy = nixpkgs.lib.nixosSystem {
      system = "x86_64-linux";
      specialArgs = {inherit inputs; };
      modules = [
        ./sborovy.nix
      ];
    };
    nixosConfigurations.esta-laptop = nixpkgs.lib.nixosSystem {
      system = "x86_64-linux";
      specialArgs = {inherit inputs; };
      modules = [
        ./esta-laptop.nix
      ];
    };
    nixosConfigurations.bazina = nixpkgs.lib.nixosSystem {
      system = "x86_64-linux";
      specialArgs = {inherit inputs; };
      modules = [
        ./bazina.nix
      ];
    };
    nixosConfigurations.x1-laptop = nixpkgs.lib.nixosSystem {
      system = "x86_64-linux";
      specialArgs = {inherit inputs; };
      modules = [
        ./x1-laptop.nix
      ];
    };
  };
}
