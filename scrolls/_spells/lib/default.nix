# SPDX-FileCopyrightText: 2022 The Standard Authors
# SPDX-FileCopyrightText: 2023 GuangTao Zhang <gtrunsec@hardenedlinux.org>
#
# SPDX-License-Identifier: Unlicense
let
  l = inputs.nixpkgs.lib // builtins;
  rakeLeaves = dirPath: let
    seive = file: type:
      (type == "regular" && l.hasSuffix ".nix" file) || (type == "directory");

    collect = file: type: {
      name = l.removeSuffix ".nix" file;
      value = let
        path = dirPath + "/${file}";
      in
        if
          (type == "regular")
          || (type == "directory" && builtins.pathExists (path + "/default.nix"))
        then path
        else rakeLeaves path;
    };

    files = l.filterAttrs seive (builtins.readDir dirPath);
  in
    l.filterAttrs (n: v: v != {}) (l.mapAttrs' collect files);
in {
  importRakeLeaves = path: args:
    l.mapAttrs (_: v:
      if (l.isFunction (import v))
      then import v args
      else import v)
    (rakeLeaves path);
}
