{
  description = "Home Manager configuration of Jane Doe";

  inputs = {
    # Specify the source of Home Manager and Nixpkgs.
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    nixgl.url = "github:guibou/nixGL";
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = {
    nixpkgs,
    home-manager,
    nixgl,
    ...
  }: let
    system = "x86_64-linux";
    # pkgs = nixpkgs.legacyPackages.${system};
    pkgs = import nixpkgs {
      inherit system;
      overlays = [nixgl.overlay];
    };
    alpha = {
      home.username = "alpha";
      home.homeDirectory = "/home/alpha";
      home.stateVersion = "22.11";
      programs.home-manager.enable = true;
      imports = [./packages.nix ./programs.nix ./alpha.nix];
    };
    adalessa = {
      home.username = "adalessa";
      home.homeDirectory = "/home/adalessa/";
      home.stateVersion = "22.11";
      programs.home-manager.enable = true;
      imports = [./packages.nix ./programs.nix ./work.nix];
    };
  in {
    homeConfigurations = {
      alpha = home-manager.lib.homeManagerConfiguration {
        inherit pkgs;
        modules = [alpha];
      };
      adalessa = home-manager.lib.homeManagerConfiguration {
        inherit pkgs;
        modules = [adalessa];
      };
    };
  };
}
