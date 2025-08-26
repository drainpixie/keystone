{stdenvNoCC}:
stdenvNoCC.mkDerivation {
  name = "drafting-mono";

  src = builtins.fetchGit {
    url = "https://github.com/indestructible-type/Drafting";
    ref = "main";
    rev = "c387df13576c3b541352725b021f9f99302e52d6";
  };

  installPhase = ''
    mkdir -p $out/share/fonts/opentype
    mkdir -p $out/share/fonts/truetype

    find -name \*.otf -exec mv {} $out/share/fonts/opentype/ \;
    find -name \*.ttf -exec mv {} $out/share/fonts/truetype/ \;
  '';
}
