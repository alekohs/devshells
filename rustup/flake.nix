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
                devShell = with pkgs; mkShell {
                    buildInputs = [
                        darwin.apple_sdk.frameworks.Security
                        libiconv
                        gcc
                        rustup
                    ];
                };
            }
        );
}
