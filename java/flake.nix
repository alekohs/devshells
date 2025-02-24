{
    inputs = {
        nixpkgs.url = "github:NixOS/nixpkgs";
        utils.url = "github:numtide/flake-utils";
    };

    outputs = { self, nixpkgs, utils }:
        utils.lib.eachDefaultSystem (system:
            let
                pkgs = import nixpkgs { inherit system; };
                java = pkgs.jdk21;
                gradle = pkgs.gradle.override { inherit java; };
                kotlin = pkgs.kotlin.override { jre = java; };
                shared = [
                    java
                    gradle
                ];
            in
                {
                devShells = {
                    kotlin = with pkgs; mkShell {
                        packages = [];

                        buildInputs = [
                            kotlin
                        ] ++ shared;
                    };

                    default = with pkgs; mkShell {
                        packages = [ ];
                        buildInputs = [ ] ++ shared;
                    };

                    JAVA_HOME = "${java}/lib/openjdk";
                };
            });
}
