{
  inputs,
  cell,
}: let
  inherit (inputs) nixpkgs nixos;

  withCategory = category: attrset: attrset // {inherit category;};
in {
  default = {
    imports = [
      cell.devshellModules.nixago
    ];

    commands = [
      (withCategory "minor conjuring" {package = inputs.home.packages.home-manager;})
      (withCategory "minor conjuring" {package = nixos.legacyPackages.${nixpkgs.system}.reuse;})
      (withCategory "minor conjuring" {package = nixos.legacyPackages.${nixpkgs.system}.cachix;})
      (withCategory "minor conjuring" {package = nixos.legacyPackages.${nixpkgs.system}.writedisk;})

      (withCategory "major spellcasting" {package = inputs.colmena.packages.colmena;})
      (withCategory "major spellcasting" {package = inputs.disko.packages.${nixpkgs.system}.disko;})
      (withCategory "major spellcasting" {package = inputs.nixos-generators.packages.nixos-generate;})
      (withCategory "major spellcasting" {package = nixos.legacyPackages.${nixpkgs.system}.nix-build-uncached;})
    ];
  };
}
