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
                    python2 = with pkgs; mkShell {
                        name = "Python2 shell";
                        buildInputs = [
                            python2
                        ];
                    };

                    default = with pkgs; mkShell {
                        name = "Pyhthon shell";
                        buildInputs = [
                            python3
                            zlib
                            libGL
                            libGLU
                        ];
                    };
                };
            }
        );
}
