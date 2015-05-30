{stdenv, fetchurl, which, ocaml, findlib, camlp4, core, async, async_unix, re2,
  async_extra, sexplib, async_shell, core_extended, async_find, cohttp, uri, trv}:

let
  ocaml_version = (builtins.parseDrvName ocaml.name).version;
  version = "0.1.2";
in

assert stdenv.lib.versionOlder "4.02" ocaml_version;

stdenv.mkDerivation {
  name = "vrt-${version}";

  src = fetchurl {
    url = "https://github.com/afiniate/vrt/archive/${version}.tar.gz";
    sha256 = "230e1bfb37628ce4ac1d1d0771b7e80667173be874710292d1db6b7a9c0bf813";
  };

  buildInputs = [ which ocaml findlib camlp4 ];
  propagatedBuildInputs = [ core async async_unix trv
                            async_extra sexplib async_shell core_extended
                            async_find cohttp uri re2 ];

  dontStrip = true;

  installPhase = "make SEMVER=${version} PREFIX=\"$out\" install";

  meta = with stdenv.lib; {
    homepage = https://github.com/afiniate/vrt;
    description = "A set of command line tools to help with ocaml development on remote AWS desktops";
    license = licenses.asl20;
    maintainers = [ maintainers.ericbmerritt ];
    platforms = ocaml.meta.platforms;
  };
}
