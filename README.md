# To run the development shell on demand
nix develop ~/develop-shells/dotnet --command dotnet --version
nix develop ~/develop-shells/golang -c zsh

Setup alias and use
<br />
``alias nd="nix develop ~/develop-shells/dotnet -c zsh"``
<br />

Use it with
<br />
``nd dotnet``

To use with specific version
<br />
``nd dotnet#dotnet7``


## Update all flaake
for dir in */; test -d $dir; and echo $dir; and nix flake update --flake $dir; end
