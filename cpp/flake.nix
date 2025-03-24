{
  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs";
    utils.url = "github:numtide/flake-utils";
  };

  outputs =
    {
      nixpkgs,
      utils,
    }:
    utils.lib.eachDefaultSystem (
      system:
      let
        pkgs = import nixpkgs { inherit system; };
      in
      {
        devShell =
          with pkgs;
          mkShell {
            name = "C++ shell";
            buildInputs = [
              clang-tools
              cmake
              cppcheck
              doxygen
              gtest
              lcov
            ];
          };
      }
    );
}
