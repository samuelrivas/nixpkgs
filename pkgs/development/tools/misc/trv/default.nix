{stdenv, fetchurl, ocaml, findlib, camlp4, core, async, async_unix, re2,
  async_extra, sexplib, async_shell, core_extended, async_find, cohttp, uri,
  git}:

let
  ocaml_version = (builtins.parseDrvName ocaml.name).version;
  version = "0.1.1";
in

assert stdenv.lib.versionOlder "4.02" ocaml_version;

stdenv.mkDerivation {
  name = "trv-${version}";

  src = fetchurl {
   url = "https://github.com/afiniate/trv/archive/${version}.tar.gz";
   sha256 = "9ed1e3a7fe4c06676e1aa7dc61340c9a044590c9905309492ca22c71948557c0";
  };

  buildInputs = [ ocaml findlib camlp4 ];
  propagatedBuildInputs = [ core async async_unix
                            async_extra sexplib async_shell core_extended
                            async_find cohttp uri re2 git ];

  createFindlibDestdir = true;
  dontStrip = true;

  installPhase = "make SEMVER=${version} PREFIX=$out install";

  meta = with stdenv.lib; {
    homepage = https://github.com/afiniate/trv;
    description = "Shim for vrt to enable bootstrapping";
    license = licenses.asl20;
    maintainers = [ maintainers.ericbmerritt ];
    platforms = ocaml.meta.platforms;
  };
}
