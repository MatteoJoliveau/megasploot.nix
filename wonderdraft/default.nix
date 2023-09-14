{ stdenv
, lib
, alsaLib
, pulseaudio
, xorg
, libGL
, unzip
, autoPatchelfHook
, makeDesktopItem
, requireFile
, mapSystem
}:

stdenv.mkDerivation rec {
  name = "Wonderdraft";

  version = "1.1.7.3";

  src = requireFile {
    name = "${name}-${version}-${mapSystem stdenv.system}.zip";
    sha256 = "0ipxgwqi95nxmvqb1sa7v8mlw8s7qdzx6vhqi688dgsrnh3hrbss";
    url = "https://wonderdraft.net/";
  };

  nativeBuildInputs = [
    autoPatchelfHook
    unzip
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
  ];

  sourceRoot = ".";

  installPhase = ''
    install -m755 -D Wonderdraft.x86_64 $out/bin/${name}
    install -m755 -D Wonderdraft.pck $out/bin/${name}.pck
    install -m755 -D Wonderdraft.png $out/share/icons/${name}.png
    cp -r ${desktopItem}/share/applications $out/share
  '';

  desktopItem = makeDesktopItem {
    name = name;
    exec = name;
    icon = name;
    desktopName = "Wonderdraft";
    genericName = meta.description;
    categories = [ "Graphics" ];
    terminal = false;
  };

  meta = with lib; {
    homepage = "https://www.wonderdraft.net/";
    description = "An intuitive yet powerful fantasy map creation tool for 64-bit Windows 10, Linux, and MacOSX";
    platforms = platforms.linux;
    license = licenses.unfree;
  };
}
