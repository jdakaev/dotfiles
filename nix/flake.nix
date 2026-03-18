{
  description = "nixos flake to setup my hardware";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-25.11";
    nixpkgs-unstable.url = "github:NixOS/nixpkgs/nixos-unstable";
    home-manager.url = "github:nix-community/home-manager/release-25.11";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";
    nixos-hardware.url = "github:NixOS/nixos-hardware/master";
    lanzaboote.url = "github:nix-community/lanzaboote?tag=v1.0.0";
    minimal-emacs = {
      url = "github:jamescherti/minimal-emacs.d";
      flake = false;
    };
  };

  outputs =
    {
      self,
      nixpkgs,
      home-manager,
      nixos-hardware,
      lanzaboote,
      nixpkgs-unstable,
      minimal-emacs,
      ...
    }@inputs:
    let
      username = "mking";
      unstable = import nixpkgs-unstable {
        system = "x86_64-linux";
        config.allowUnfree = true; # if needed
      };

      mkHost =
        host: extraModules: specialArgs:
        nixpkgs.lib.nixosSystem {
          specialArgs = {
            inherit username;
            inherit host;
            inherit unstable;
          }
          // specialArgs;
          system = "x86_64-linux";
          modules = [
            lanzaboote.nixosModules.lanzaboote
            ./hosts/${host}
            ./users/${username}/nixos.nix
            home-manager.nixosModules.home-manager
            {
              home-manager.useGlobalPkgs = true;
              home-manager.useUserPackages = true;
              home-manager.extraSpecialArgs = inputs // specialArgs // { inherit unstable minimal-emacs; };
              home-manager.users.${username} = import ./users/${username}/home.nix;
            }
          ]
          ++ extraModules;
        };
    in
    {
      nixosConfigurations = {
        t480s = mkHost "t480s" [
          nixos-hardware.nixosModules.lenovo-thinkpad-t480s
        ] { };

        minibook = mkHost "minibook" [
          nixos-hardware.nixosModules.chuwi-minibook-x
        ] { };
      };
    };
}
