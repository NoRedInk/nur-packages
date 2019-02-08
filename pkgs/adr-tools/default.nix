{ stdenv, fetchFromGitHub, bashInteractive }:

stdenv.mkDerivation rec {
  name = "adr-tools-${version}";
  version = "3.0.0";

  src = fetchFromGitHub {
    owner = "npryce";
    repo = "adr-tools";
    rev = version;
    sha256 = "1igssl6853wagi5050157bbmr9j12703fqfm8cd7gscqwjghnk14";
  };

  buildInputs = [ bashInteractive ];

  phases = [ "unpackPhase" "installPhase" "fixupPhase" ];

  installPhase = ''
    mkdir -p $out/bin $out/etc/bash_completion.d
    cp *.md $out
    cp src/* $out/bin
    cp autocomplete/* $out/etc/bash_completion.d
  '';

  meta = {
    homepage = https://github.com/npryce/adr-tools;
    license = stdenv.lib.licenses.gpl3Plus;
    description = "Command-line tools for working with Architecture Decision Records";
    platforms = stdenv.lib.platforms.unix;
  };
}
