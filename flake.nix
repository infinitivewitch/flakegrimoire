{
  nixConfig = {
    extra-substituters = [
      "https://cache.nixos.org"
      "https://infinitivewitch.cachix.org"
    ];
    extra-trusted-public-keys = [
      "cache.nixos.org-1:6NCHdD59X431o0gWypbMrAURkbJ16ZPMQFGspcDShjY="
      "infinitivewitch.cachix.org-1:D0IprjPtIbtSlZc8vdsU12e1QgT68Goi4eDF+/olNVU="
    ];
  };

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs";
    std = {
      url = "github:divnix/std";
      inputs.nixpkgs.follows = "nixpkgs";
    };
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
      ];
    }
    {
      devShells = std.harvest self [["_spells" "devshells"]];
    };
}
