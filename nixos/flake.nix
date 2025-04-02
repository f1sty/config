{
  description = "nixos configuration flake";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs?ref=nixos-unstable";
    nixos-hardware.url = "github:nixos/nixos-hardware?ref=master";
  };

  outputs = { self, nixpkgs, nixos-hardware }: {
    nixosConfigurations.kitty = nixpkgs.lib.nixosSystem {
      system = "x86_64-linux";

      modules = [
        nixos-hardware.nixosModules.dell-xps-15-9530-nvidia
        ./configuration.nix
      ];
    };
  };
}
