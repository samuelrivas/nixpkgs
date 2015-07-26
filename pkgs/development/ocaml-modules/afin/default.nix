{stdenv, buildOcaml, fetchFromGitHub, core, core_extended, async, vrt}:

buildOcaml rec {
  name = "afin";
  version = "0.0.0";

  minimumSupportedOcamlVersion = "4.02";

  src = fetchFromGitHub {
    owner = "samuelrivas";
    repo = "afin";
    rev = "c88b83c900db6de66a856047e50aa8f7eb7a43bd";
    sha256 = "1qskdv8ammsnv4x5782c077gg1zkard9xphjci3bkkg66mnnd4dh";
  };

  buildInputs = [ core core_extended async vrt ];
  propagatedBuildInputs = [ core core_extended async ];

  installPhase = "make SEMVER=${version} install";

  meta = {
    homepage = https://github.com/afiniate/afin;
    description = "Library of base types and Core used by Afiniate";
    license = stdenv.lib.licenses.asl20;
    maintainers = [ stdenv.lib.maintainers.ericbmerritt ];
  };
}
