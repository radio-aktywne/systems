{
  inputs = {
    nixpkgs = {
      url = "github:NixOS/nixpkgs/nixos-24.11";
    };

    disko = {
      url = "github:nix-community/disko";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    flake-parts = {
      url = "github:hercules-ci/flake-parts";
    };

    sops-nix = {
      url = "github:Mic92/sops-nix";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    home-manager = {
      url = "github:nix-community/home-manager/release-24.11";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = _inputs: let
    # Add custom local inputs
    inputs =
      _inputs
      // {
        packages = import ./src/packages;
        utils = import ./src/utils;
      };
  in
    inputs.flake-parts.lib.mkFlake {inherit inputs;} {
      # Import local override if it exists
      imports = [
        (
          if builtins.pathExists ./local.nix
          then ./local.nix
          else {}
        )
      ];

      # System-specific configuration
      flake = inputs.utils.mkHosts {
        inherit inputs;
        directory = "hosts";
        hosts = ["dyl"];
      };

      # Sensible defaults
      systems = [
        "x86_64-linux"
        "i686-linux"
        "aarch64-linux"
        "x86_64-darwin"
        "aarch64-darwin"
      ];

      perSystem = {
        config,
        pkgs,
        system,
        ...
      }: let
        node = pkgs.nodejs;
        nil = pkgs.nil;
        task = pkgs.go-task;
        coreutils = pkgs.coreutils;
        trunk = pkgs.trunk-io;
        copier = pkgs.copier;
        sops = pkgs.sops;
      in {
        # Override pkgs argument
        _module.args.pkgs = import inputs.nixpkgs {
          inherit system;
          config = {
            # Allow packages with non-free licenses
            allowUnfree = true;
            # Allow packages with broken dependencies
            allowBroken = true;
            # Allow packages with unsupported system
            allowUnsupportedSystem = true;
          };
        };

        # Set which formatter should be used
        formatter = pkgs.alejandra;

        # Define multiple development shells for different purposes
        devShells = {
          default = pkgs.mkShell {
            name = "dev";

            packages = [
              node
              nil
              task
              coreutils
              trunk
              copier
              sops
            ];

            shellHook = ''
              export TMPDIR=/tmp
            '';
          };

          template = pkgs.mkShell {
            name = "template";

            packages = [
              task
              coreutils
              copier
            ];

            shellHook = ''
              export TMPDIR=/tmp
            '';
          };

          lint = pkgs.mkShell {
            name = "lint";

            packages = [
              node
              task
              coreutils
              trunk
            ];

            shellHook = ''
              export TMPDIR=/tmp
            '';
          };

          docs = pkgs.mkShell {
            name = "docs";

            packages = [
              node
              task
              coreutils
            ];

            shellHook = ''
              export TMPDIR=/tmp
            '';
          };
        };
      };
    };
}
