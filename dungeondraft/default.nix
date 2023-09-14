{ stdenv
, lib
, alsaLib
, pulseaudio
, gnome
, xorg
, libGL
, krb5
, zlib
, autoPatchelfHook
, makeDesktopItem
, requireFile
, mapSystem
, unzip
}:

stdenv.mkDerivation rec {
  name = "Dungeondraft";

  version = "1.1.0.3";

  src = requireFile {
    name = "${name}-${version}-${mapSystem stdenv.system}.zip";
    sha256 = "054ik7y5pjlklw9g4nk03j3ab0i6j0yijrg3lcm1s18d0rhaw20b";
    url = "https://dungeondraft.net/";
  };

  nativeBuildInputs = [
    unzip
    autoPatchelfHook
  ];

  buildInputs = [
    pulseaudio
    alsaLib
    xorg.libX11
    xorg.libXrandr
    xorg.libXinerama
    xorg.libXcursor
    xorg.libXi
    libGL
    gnome.zenity
    stdenv.cc.cc.lib
    zlib
    krb5.dev
  ];

  sourceRoot = ".";

  installPhase = ''
    install -m755 -D Dungeondraft.x86_64 $out/bin/${name}
    install -m755 -D Dungeondraft.pck $out/bin/${name}.pck
    install -m755 -D example_template.zip $out/bin/example_template.zip
    install -m755 -D EULA.txt $out/bin/EULA.txt
    cp -r data_Dungeondraft $out/bin
    install -m755 -D Dungeondraft.png $out/share/icons/${name}.png
    cp -r ${desktopItem}/share/applications $out/share
  '';

  desktopItem = makeDesktopItem {
    name = name;
    exec = name;
    icon = name;
    desktopName = "Dungeondraft";
    genericName = meta.description;
    categories = [ "Graphics" ];
    terminal = false;
  };

  meta = with lib; {
    homepage = "https://www.Dungeondraft.net/";
    description = "An intuitive yet powerful fantasy map creation tool for 64-bit Windows 10, Linux, and MacOSX";
    platforms = platforms.linux;
    license = licenses.unfree;
  };
}
