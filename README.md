# To run the development shell on demand
nix develop ~/develop-shells/dotnet --command dotnet --version
nix develop ~/develop-shells/golang -c zsh

### Setup alias and use
alias nd="nix develop ~/develop-shells/dotnet -c zsh"

Use it with
``nd dotnet``

To use with specific version
``nd dotnet#dotnet7``

