{
  description = "NixOS configuration";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    home-manager.url = "github:nix-community/home-manager";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";
    stylix.url = "github:danth/stylix";

  };

  outputs = inputs@{ nixpkgs, home-manager, stylix, ... }: {
    nixosConfigurations = {
      caladan = nixpkgs.lib.nixosSystem {
        system = "x86_64-linux";
        modules = [
          stylix.nixosModules.stylix
          ./configuration.nix
          home-manager.nixosModules.home-manager
          {
            home-manager.useGlobalPkgs = true;
            home-manager.useUserPackages = true;
            home-manager.users.sergio = import ./home.nix;

            # Optionally, use home-manager.extraSpecialArgs to pass
            # arguments to home.nix
          }
        ];
      };
    };
  };
}

# {
#   description = "Nixos config flake";

#   inputs = {
#     nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
#     stylix.url = "github:danth/stylix";


#     home-manager = {
#       url = "github:nix-community/home-manager";
#       inputs.nixpkgs.follows = "nixpkgs";
#      };

#   };

#   outputs = { self, nixpkgs, stylix, ... }@inputs: {
#     nixosConfigurations.default = nixpkgs.lib.nixosSystem {
#       specialArgs = {inherit inputs;};
#       modules = [
#         stylix.nixosModules.stylix
#         ./configuration.nix
#         inputs.home-manager.nixosModules.default
#       ];
#     };
#   };
# }
