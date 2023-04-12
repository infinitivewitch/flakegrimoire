{
  inputs,
  cell,
}: let
  inherit (inputs) std-data-collection;
in {
  nixago = with std-data-collection.data.configs; [
    treefmt
    lefthook
    editorconfig
    (conform {data = {inherit (inputs) cells;};})
    (githubsettings {
      data = {
        repository = {
          description = "The Forbidden Nix Flakes Doctrine";
          topics = "dotfiles, nix, nixos, nixos-configuration, flake, nix-flake, nixos-dotfiles";
        };
      };
    })
  ];
}
