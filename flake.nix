{
  description = "TODO";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    flake-utils.url = "github:numtide/flake-utils";
    flake-compat = {
      url = "github:edolstra/flake-compat";
      flake = false;
    };
  };

  outputs = { self, nixpkgs, flake-utils, ... }:

    flake-utils.lib.eachDefaultSystem (system:
      let pkgs = nixpkgs.legacyPackages.${system};
      in rec {
        packages = with pkgs;
          flake-utils.lib.flattenTree rec {

            openvas-smb = pkgs.stdenv.mkDerivation rec {
              pname = "openvas-smb";
              version = "21.4.0";

              src = fetchFromGitHub {
                owner = "greenbone";
                repo = pname;
                rev = "v${version}";
                sha256 = "sha256-iCJcRRT06bRL3ypoxebpDE19xXILemvid8XMMjr3BI8=";
              };

              nativeBuildInputs = [ cmake pkg-config perl ];

              buildInputs = [
                glib
                glib-networking
                hiredis
                freeradius
                libnet
                libuuid
                libxml2
                zlib

                pcre-cpp
                p11-kit
                libselinux
                libsepol
                doxygen

                glib
                gnutls
                libtasn1
                gvm-libs
                libssh
                libpcap
                libksba
                gpgme
                libgcrypt
                bison
                json-glib
                heimdal
                popt
                xmltoman

              ];

              # meta = with lib; { };

            };

            gvm-libs = stdenv.mkDerivation rec {
              pname = "gvm-libs";
              version = "21.4.3";

              src = fetchFromGitHub {
                owner = "greenbone";
                repo = pname;
                rev = "v${version}";
                sha256 = "sha256-1NVLGyUDUnOy3GYDtVyhGTvWOYoWp95EbkgTlFWuxE8=";
              };

              nativeBuildInputs = [ cmake pkg-config ];

              buildInputs = [
                glib
                glib-networking
                gnutls
                gpgme
                hiredis
                libgcrypt
                freeradius
                libnet
                libpcap
                libssh
                libuuid
                libxml2
                zlib
              ];

              meta = with lib; {
                description =
                  "Libraries module for the Greenbone Vulnerability Management Solution";
                homepage = "https://github.com/greenbone/gvm-libs";
                license = with licenses; [ gpl2Plus ];
                maintainers = with maintainers; [ fab ];
                platforms = platforms.linux;
              };
            };

            openvas-scanner = pkgs.stdenv.mkDerivation rec {
              pname = "openvas-scanner";
              version = "21.4.3";

              src = fetchFromGitHub {
                owner = "greenbone";
                repo = pname;
                rev = "v${version}";
                sha256 = "sha256-uKkGwwG2Hw9rt74ew6u3VnYQpVNSe+Wu12tZHbhEcdQ=";
              };

              nativeBuildInputs = [ cmake pkg-config ];

              buildInputs = [
                glib
                glib-networking
                hiredis
                freeradius
                libnet
                libuuid
                libxml2
                zlib

                pcre-cpp
                p11-kit
                libselinux
                libsepol
                doxygen

                glib
                gnutls
                libtasn1
self.packages.${system}.gvm-libs
                libssh
                libpcap
                libksba
                gpgme
                libgcrypt
                bison
                json-glib

              ];

              meta = with lib; {
                description = "TODO";
                homepage = "TODO";

                # license = with licenses; [ gpl2Plus ];
                # maintainers = with maintainers; [ fab ];
                # platforms = platforms.linux;

              };
            };
          };

        defaultPackage = packages.openvas-scanner;
      });
}
