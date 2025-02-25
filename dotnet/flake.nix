{
    inputs = {
        nixpkgs.url = "github:NixOS/nixpkgs";
        utils.url = "github:numtide/flake-utils";
    };

    outputs = { self, nixpkgs, utils }:
        utils.lib.eachDefaultSystem (system:
            let
                pkgs = import nixpkgs { inherit system; };
                hook = ''
                    if command -v dotnet ef > /dev/null; then
                        dm=true
                    else
                        echo 'Installing EF core tools'
                        dotnet tool install --global dotnet-ef
                    fi

                '';
            in
                {
                devShells = {
                    dotnet8 = with pkgs; mkShell {
                        name = "Dotnet 8 SDK";
                        packages = [];

                        buildInputs = [
                            dotnetCorePackages.sdk_8_0
                        ];
                        shellHook = hook;
                    };

                    default = with pkgs; mkShell {
                        name = "Dotnet 9 SDK";
                        packages = [];
                        buildInputs = [
                            dotnetCorePackages.sdk_9_0
                        ];
                        shellHook = hook;
                    };

                };
            });
}
