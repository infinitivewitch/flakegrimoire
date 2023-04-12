{
  description = "The Forbidden Nix Flakes Doctrine";

  nixConfig = {
    extra-substituters = [
      "https://cache.nixos.org"
      "https://colmena.cachix.org"
      "https://numtide.cachix.org"
      "https://nix-community.cachix.org"
      "https://infinitivewitch.cachix.org"
    ];
    extra-trusted-public-keys = [
      "cache.nixos.org-1:6NCHdD59X431o0gWypbMrAURkbJ16ZPMQFGspcDShjY="
      "colmena.cachix.org-1:7BzpDnjjH8ki2CT3f6GdOk7QAzPOl+1t3LvTLXqYcSg="
      "numtide.cachix.org-1:2ps1kLBUWjxIneOy1Ik6cQjb41X0iXVXeHigGmycPPE="
      "nix-community.cachix.org-1:mB9FSh9qf2dCimDSUo8Zy7bkq5CX+/rkCWyvRCYg3Fs="
      "infinitivewitch.cachix.org-1:D0IprjPtIbtSlZc8vdsU12e1QgT68Goi4eDF+/olNVU="
    ];
  };

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs";
    std = {
      url = "github:divnix/std";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    std-data-collection = {
      url = "github:divnix/std-data-collection";
      inputs = {
        std.follows = "std";
        nixpkgs.follows = "nixpkgs";
      };
    };
    disko = {
      url = "github:nix-community/disko";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    colmena = {
      url = "github:zhaofengli/colmena";
      inputs.nixpkgs.follows = "nixpkgs";
      inputs.stable.follows = "nixpkgs-stable";
      inputs.flake-utils.follows = "std/flake-utils";
    };
    nixos-generators = {
      url = "github:nix-community/nixos-generators";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    nixpkgs-stable.url = "github:NixOS/nixpkgs/release-22.11";
    home-stable = {
      url = "github:nix-community/home-manager/release-22.11";
      inputs.nixpkgs.follows = "nixpkgs-stable";
    };
    nixos.follows = "nixpkgs-stable";
    home.follows = "home-stable";
  };

  outputs = inputs @ {
    self,
    std,
    ...
  }: let
    systems = [
      "x86_64-linux"
    ];
  in
    std.growOn {
      inherit inputs systems;
      cellsFrom = ./scrolls;
      cellBlocks = with std.blockTypes; [
        (functions "lib")

        (devshells "devshells")
        (functions "devshellModules")
        (functions "devshellProfiles")
      ];
    }
    {
      devShells = std.harvest self [["_spells" "devshells"]];
    };
}
