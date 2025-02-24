{
    inputs = {
        nixpkgs.url = "github:NixOS/nixpkgs";
        utils.url = "github:numtide/flake-utils";
    };

    outputs = { self, nixpkgs, utils }:
        utils.lib.eachDefaultSystem (system:
            let
                pkgs = import nixpkgs { inherit system; };
            in
                {
                devShells = {
                    rust = with pkgs; mkShell {
                        buildInputs = [
                            libiconv
                            gcc
                            cargo
                            rustc
                            rustfmt
                            rustPackages.clippy
                            rust-analyzer
                        ] ++ (if system == "aarch64-darwin" then [ darwin.apple_sdk.frameworks.Security ] else []);

                        RUST_SRC_PATH = rustPlatform.rustLibSrc;
                    };

                    default = with pkgs; mkShell {
                        buildInputs = [
                            libiconv
                            gcc
                            rustup
                        ] ++ (if system == "aarch64-darwin" then [ darwin.apple_sdk.frameworks.Security ] else []);
                    };
                };
            }
        );
}
