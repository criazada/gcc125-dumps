{
  inputs = {
    flake-utils.url = "github:numtide/flake-utils";
  };

  outputs = { self, nixpkgs, flake-utils, ... }:
    flake-utils.lib.eachDefaultSystem (system:
      let
        pkgs = import nixpkgs {
          inherit system;
        };

        buildInputs = with pkgs; [ ];
        nativeBuildInputs = with pkgs; [ wget python310 httrack ];
      in
      rec {
        devShell = pkgs.mkShell {
          inherit buildInputs nativeBuildInputs;
        };
      });
}
