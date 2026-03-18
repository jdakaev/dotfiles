{ pkgs ? import <nixpkgs> {} }:

pkgs.mkShell {
  # Packages available in the shell
  buildInputs = with pkgs; [
    lua-language-server
  ];
}
