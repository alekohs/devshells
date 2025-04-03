{
  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs";
    utils.url = "github:numtide/flake-utils";
  };

  outputs =
    {
      self,
      nixpkgs,
      utils,
    }:
    utils.lib.eachDefaultSystem (
      system:
      let
        pkgs = import nixpkgs { inherit system; };
        sharedPackages = [
          pkgs.nodejs_22
          pkgs.nodePackages.prettier
        ];
        hook = ''
          echo "Node $(node -v)"
        '';
      in
      {
        devShells = {
          pnpm =
            with pkgs;
            mkShell {
              name = "Pnpm dev shell";
              packages = [
                nodePackages.tailwindcss
                nodePackages.pnpm
              ] ++ sharedPackages;
              shellHook = ''
                  echo "Welcome to the dev shell for NodeJS and PNPM"
                '' + hook;
            };

          yarn =
            with pkgs;
            mkShell {
              name = "Yarn dev shell";
              packages = [ yarn ] ++ sharedPackages;
              shellHook = ''
                  echo "Welcome to the dev shell for NodeJS and Yarn"
                '' + hook;

            };

          default =
            with pkgs;
            mkShell {
              name = "Node dev shell";
              packages = sharedPackages;
              shellHook = ''
                  echo "Welcome to the dev shell for NodeJS"
                '' + hook;

            };
        };
      }
    );
}
