{ stdenv, fetchFromGitHub, bashInteractive }:

stdenv.mkDerivation rec {
  name = "adr-tools-${version}";
  version = "3.0.0-f36daae";

  src = fetchFromGitHub {
    owner = "NoRedInk";
    repo = "adr-tools";
    rev = "f36daae4d65cf55ca8fdba6f23bba779896fa847";
    sha256 = "0g2hc8sf61cfn43c32yx2rivmjhiyy6jxaprq69vrr28a6z1gdz0";
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
