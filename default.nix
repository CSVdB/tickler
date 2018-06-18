let
  pkgsv = import (import ./nixpkgs.nix);
  pkgs = pkgsv {};
  intray-overlay =
            import (pkgs.fetchFromGitHub {
              owner = "NorfairKing";
              repo = "intray";
              rev = "c2e9cfa69553249f165b264dbb288e399d46509c";
              sha256 = "18zb1w09l6sy35lsknkx45zdlq397qyaqv56y6mww9l9dlspa4w4";
              fetchSubmodules = true;
            } + "/overlay.nix");
in pkgsv {
  overlays = [ intray-overlay (import ./overlay.nix) ];
  config.allowUnfree = true;
}