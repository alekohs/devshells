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
                        name = "Pnpm dev shell";
                        buildInputs = [
                            nodejs_22
                            nodePackages.prettier
                            nodePackages.tailwindcss
                            nodePackages.pnpm
                        ];
                    };

                    yarn = with pkgs; mkShell {
                        name = "Yarn dev shell";
                        buildInputs = [
                            nodejs_22
                            yarn
                        ];
                    };


                    default = with pkgs; mkShell {
                        name = "Node dev shell";
                        buildInputs = [
                            nodejs_22
                            nodePackages.prettier
                            nodePackages.tailwindcss
                        ];
                    };
                };
            }
        );
}
