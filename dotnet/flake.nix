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
                    dotnet8 = with pkgs; mkShell {
                        packages = [
                        ];

                        buildInputs = [
                            dotnetCorePackages.sdk_8_0
                        ];
                    };

                    default = with pkgs; mkShell {
                        packages = [
                        ];

                        buildInputs = [
                            dotnetCorePackages.sdk_9_0
                        ];
                    };

                };
            });
}
