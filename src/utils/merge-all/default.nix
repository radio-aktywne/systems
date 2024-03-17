# Merge a list of attrsets into a single attrset.
{
  attrsets,
  inputs,
  ...
}: let
  mergeOperator = inputs.nixpkgs.lib.recursiveUpdate;
in
  builtins.foldl' mergeOperator {} attrsets
