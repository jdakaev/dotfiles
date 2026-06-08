{
  description = "nixos flake to setup my hardware";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-26.05";
    nixpkgs-unstable.url = "github:NixOS/nixpkgs/nixos-unstable";
    home-manager.url = "github:nix-community/home-manager/release-26.05";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";
    nixos-hardware.url = "github:NixOS/nixos-hardware/master";
    lanzaboote.url = "github:nix-community/lanzaboote?tag=v1.0.0";
    minimal-emacs = {
      url = "github:jamescherti/minimal-emacs.d";
      flake = false;
    };
    org-mode-flake = {
      url = "path:/home/mking/dotfiles/nix/flakes/org-mode";
      inputs.nixpkgs.follows = "nixpkgs";
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
      org-mode-flake,
      ...
    }@inputs:
    let
      username = "mking";

      # common nixpkgs config options for stable/unstable
      nixpkgsConfig = {
        allowUnfree = true;
      };
      #system = "x86_64-linux";

      unstable = import nixpkgs-unstable {
        system = "x86_64-linux";
        config = nixpkgsConfig;
      };

      mkHost =
        host: extraModules: extraArgs:
        let
          specialArgs = extraArgs // {
            inherit username;
            inherit host;
            inherit unstable;
          };
        in
        nixpkgs.lib.nixosSystem {
          inherit specialArgs;
          modules = [
            {
              nixpkgs = {
                system = "x86_64-linux";
                config = nixpkgsConfig;
              };
            }
            lanzaboote.nixosModules.lanzaboote
            ./hosts/${host}
            ./users/${username}/nixos.nix
            home-manager.nixosModules.home-manager
            {
              home-manager.useGlobalPkgs = true;
              home-manager.useUserPackages = true;
              home-manager.extraSpecialArgs = specialArgs // {
                inherit org-mode-flake;
                inherit minimal-emacs;
              };
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
