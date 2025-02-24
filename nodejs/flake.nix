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
                    pnpm = with pkgs; mkShell {
                        packages = [
                            nodejs_22
                            nodePackages.prettier
                            nodePackages.pnpm
                        ];
                    };

                    yarn = with pkgs; mkShell {
                        packages = [
                            nodejs_22
                            nodePackages.yarn
                        ];
                    };


                    defaukt = with pkgs; mkShell {
                        packages = [
                            nodejs_22
                            nodePackages.prettier
                        ];
                    };
                };
            }
        );
}
