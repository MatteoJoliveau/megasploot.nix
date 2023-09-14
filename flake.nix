{
  description = "Megasploot software packaged for Nix";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs";
    utils.url = "github:numtide/flake-utils";
  };

  outputs = { self, nixpkgs, utils }:
    let
      systems = utils.lib.system;
      systemsMap = {
        x86_64-linux = "Linux64";
      };
      mapSystem = (system: nixpkgs.lib.getAttrFromPath [ system ] systemsMap);

    in
    utils.lib.eachSystem [ systems.x86_64-linux ] (system:
      let
        pkgs = import nixpkgs { inherit system; };
      in
      {
        formatter = pkgs.nixpkgs-fmt;

        packages = {
          dungeondraft = pkgs.callPackage ./dungeondraft { inherit mapSystem; };
          wonderdraft = pkgs.callPackage ./wonderdraft { inherit mapSystem; };
        };

        apps = {
          dungeondraft = utils.lib.mkApp { drv = self.packages.${system}.dungeondraft; };
          wonderdraft = utils.lib.mkApp { drv = self.packages.${system}.wonderdraft; };
        };

        devShells.default = pkgs.mkShell
          {
            NIXPKGS_ALLOW_UNFREE = "1"; # Hey, none of these software is FOSS, so...

            buildInputs = with pkgs; [

            ];
          };
      });
}
