# Create configurations for all given hosts
{
  directory,
  hosts,
  inputs,
  ...
}: let
  _mkHost = host:
    inputs.utils.mkHost {
      inherit directory host inputs;
    };
  hostConfigs = map _mkHost hosts;
in
  inputs.utils.mergeAll {
    inherit inputs;
    attrsets = hostConfigs;
  }
