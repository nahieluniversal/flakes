{ stdenv, fetchFromGitHub }:

stdenv.mkDerivation rec {
  pname = "where_is_my_sddm_qt5";
  version = "1.12.0";
  dontBuild = true;
  installPhase = ''
    mkdir -p $out/share/sddm/themes
    cp -aR $src/where_is_my_sddm_theme_qt5 $out/share/sddm/themes/where_is_my_sddm_theme_qt5
  '';
  src = fetchFromGitHub {
    owner = "stepanzubkov";
    repo = "where-is-my-sddm-theme";
    rev = "v${version}";
    sha256 = "4a39507bd91056886e1c7b7f45dbb3deba44c111d207707bdf22e639a7b61506";
  };
}