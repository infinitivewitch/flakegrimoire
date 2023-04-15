{
  inputs,
  cell,
}: let
  inherit (inputs) std std-data-collection;
in {
  nixago = with std-data-collection.data.configs; [
    treefmt
    lefthook
    editorconfig
    (conform {data = {inherit (inputs) cells;};})
    (std.lib.cfg.githubsettings {
      data = {
        _extends = ".github";
        repository = {
          name = "flakegrimoire";
          description = cell.lib.flake.description;
          homepage = "https://github.com/infinitivewitch/flakegrimoire";
          topics = "dotfiles, nix, nixos, nixos-configuration, flake, nix-flake, nixos-dotfiles";
        };
      };
    })
  ];
}
