{stdenvNoCC}:
stdenvNoCC.mkDerivation {
  name = "azuki";

  src = builtins.fetchurl {
    url = "https://github.com/mushchlo/azukipatch/releases/download/v1.0/patched.ttf";
    sha256 = "15zyqzhcajzabpsa2mgf7qya31q8afpjjsipf4ymnqm2mb2cgvyb";
  };

  installPhase = ''
    mkdir -p $out/share/fonts/truetype
    cp $src $out/share/fonts/truetype/azuki.ttf
  '';

  phases = ["installPhase" "patchPhase"];
}
