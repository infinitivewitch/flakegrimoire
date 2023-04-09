let
  inherit (inputs) nixpkgs std;
  l = nixpkgs.lib // builtins;
in
  l.mapAttrs (_: std.lib.dev.mkShell) {
    default = {...}: {
      name = "incantationless-shell";

      imports = [
        cell.devshellProfiles.default
        std.std.devshellProfiles.default
      ];
    };
  }
