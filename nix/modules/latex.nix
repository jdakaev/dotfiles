{
  config,
  lib,
  pkgs,
  ...
}:
{
  environment.systemPackages = [
    (pkgs.texlive.combine {
      inherit (pkgs.texlive)
        scheme-small

        dvisvgm
        preview
        standalone
        lh
        cm-super
        capt-of
        paracol
        xcolor

        pgf
        tikz-3dplot

        cyrillic
        babel-russian
        hyphen-russian
        ;
    })
  ];
}
