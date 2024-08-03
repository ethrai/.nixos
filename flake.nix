{
  description = "NixOS configuration";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs?ref=nixos-unstable";
    home-manager.url = "github:nix-community/home-manager";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";
    stylix.url = "github:danth/stylix";
    hyprland.url = "github:hyprwm/Hyprland";
    hyprland-plugins = {
      url = "github:hyprwm/hyprland-plugins";
      inputs.hyprland.follows = "hyprland";
    };

    hy3 = {
      url = "github:outfoxxed/hy3"; # where {version} is the hyprland release version
      # or "github:outfoxxed/hy3" to follow the development branch.
      # (you may encounter issues if you dont do the same for hyprland)
      inputs.hyprland.follows = "hyprland";
    };

  };

  outputs =
    inputs@{
      self,
      nixpkgs,
      home-manager,
      stylix,
      hyprland,
      hy3,
      ...
    }:
    let
    in
    {
      packages.x86-64-linux.hello = nixpkgs.legacyPackages.x86-64-linux.hello;

      packages.x86-64-linux.default = self.packages.x86-64-linux.hello;

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

            }

          ];
        };

      };
    };
}
