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
        devShells = {
          default =
            with pkgs;
            mkShell {
              name = "Swift usage with xcode";
              buildInputs = [
                ruby
                xcbeautify
                pipx
                ripgrep
                jq
                coreutils
              ];

              shellHook = ''
                gem install xcodeproj
                pipx install pymobiledevice3
                '';
            };
        };
      }
    );
}
