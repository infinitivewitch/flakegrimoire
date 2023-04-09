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
    githubsettings
    (conform {data = {inherit (inputs) cells;};})
  ];
}
