{
  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs";
    utils.url = "github:numtide/flake-utils";
    kokovim.url = "github:alekohs/kokovim/dotnet8";
  };

  outputs =
    {
      self,
      kokovim,
      nixpkgs,
      utils,
    }:
    utils.lib.eachDefaultSystem (
      system:
      let
        pkgs = import nixpkgs {
          inherit system;
          config = {
            config = {
              allowUnfree = true; # For unfree packages like Google Chrome
              allowInsecurePredicate =
                pkg:
                builtins.elem (pkgs.lib.getName pkg) [
                  "dotnetCorePackages.sdk_5_0"
                  "dotnetCorePackages.sdk_6_0"
                  "dotnetCorePackages.sdk_7_0"
                ];
            };
          };
        };

        legacyPkgs = import nixpkgs {
          inherit system;
          overlays = [
            (final: prev: {
              neovim = kokovim.packages.${prev.system}.default;
            })
          ];
          config = {
            config = {
              allowUnfree = true; # For unfree packages like Google Chrome
              allowInsecurePredicate =
                pkg:
                builtins.elem (pkgs.lib.getName pkg) [
                  "dotnetCorePackages.sdk_5_0"
                  "dotnetCorePackages.sdk_6_0"
                  "dotnetCorePackages.sdk_7_0"
                ];
            };
          };
        };

        versions = [
          "5"
          "6"
          "7"
          "8"
          "9"
        ];
        defaultVersion = "9";

        hook = ''
          export NIXPKGS_ALLOW_INSECURE=1
          if command -v dotnet ef > /dev/null; then
              dm=true
          else
              echo 'Installing EF core tools'
              dotnet tool install --global dotnet-ef
          fi

        '';
      in
      {
        devShells = builtins.listToAttrs (
          map (version: {
            name = "dotnet${version}";
            value =
              with legacyPkgs;
              mkShell {
                buildInputs = [
                  dotnetCorePackages."sdk_${version}_0"
                  csharpier
                  neovim
                ];
              };
          }) versions
        );

        defaultPackage =
          with pkgs;
          mkShell {
            name = "Dotnet${defaultVersion}";
            packages = [ ];
            buildInputs = [
              dotnetCorePackages."sdk_${defaultVersion}_0"
              csharpier
            ];
            shellHook = hook;
          };
      }
    );
}
