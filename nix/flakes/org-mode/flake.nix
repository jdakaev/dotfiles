{
  description = "Custom org-mode build from tec's repository";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-25.11";
    org-mode-src = {
      url = "git+https://code.tecosaur.net/tec/org-mode.git?ref=dev";
      flake = false;
    };
  };

  outputs =
    {
      self,
      nixpkgs,
      org-mode-src,
    }:
    let
      systems = [
        "x86_64-linux"
        "aarch64-linux"
      ];
      forAllSystems = f: nixpkgs.lib.genAttrs systems (system: f system);
    in
    {
      packages = forAllSystems (
        system:
        let
          pkgs = import nixpkgs { inherit system; };
        in
        {
          org-mode = pkgs.stdenv.mkDerivation {
            pname = "org-mode";
            version = org-mode-src.shortRev or "dev";

            src = org-mode-src;

            nativeBuildInputs = with pkgs; [
              gnumake
            ];

            buildInputs = with pkgs; [
              emacs
            ];

            buildPhase = ''
              cd lisp
              make
              cd ..
            '';

            installPhase = ''
              mkdir -p $out/share/emacs/site-lisp
              cp -r lisp/*.el $out/share/emacs/site-lisp/
              cp -r lisp/*.elc $out/share/emacs/site-lisp/ 2>/dev/null
            '';

            meta = with pkgs.lib; {
              description = "org-mode with latex previews from tecosaur";
              homepage = "https://code.tecosaur.net/tec/org-mode";
              license = licenses.gpl3Plus;
              platforms = platforms.unix;
            };
          };

          default = self.packages.${system}.org-mode;
        }
      );

      homeManagerModules.default =
        {
          config,
          pkgs,
          self,
          ...
        }:
        {
          home.packages = [
            self.packages.${pkgs.system}.org-mode
          ];

          home.file.".emacs.d/site-lisp-org" = {
            source = "${self.packages.${pkgs.system}.org-mode}/share/emacs/site-lisp";
            recursive = true;
          };
        };
    };
}
