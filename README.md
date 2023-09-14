# Megasploot.nix

[Megasploot] software packaged for [Nix and NixOS].

## Available software

- [Dungeondraft](https://dungeondraft.net). Systems: Linux AMD64
- [Wonderdraft](https://wonderdraft.net). Systems: Linux AMD64

## Usage

We use [Flakes] to distribute the packages. If you don't use flakes, you really should, but otherwise the packages themselves are simple calls to `mkDerivation`, so they should be easy to extract and import into your specific setup.

To run the software without adding it to your configuration, you can use `nix run`:

`nix run github:matteojoliveau/megasploot.nix#dungeondraft` 

If you get an error about the unfree license, add `NIXPKGS_ALLOW_UNFREE` and `--impure` to the command:

`NIXPKGS_ALLOW_UNFREE=1 nix run github:matteojoliveau/megasploot.nix#dungeondraft --impure` 

To add them permanently to your setup, import them as a flake and add the overlay to nixpkgs:

```nix
{
  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-23.05";
    megasploot = "github:matteojoliveau/megasploot.nix";
  };

  outputs = { self, nixpkgs, megasploot }:
    let
      system = "x86_64-linux";
      pkgs = import nixpkgs {
        inherit system;

        config.allowUnfree = true;

        overlays = [
          megasploot.overlays.default
        ];
    };
    in
    // rest of your flake config
}
```

Or you can directly inject it into your NixOS config:

```nix
{
  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-23.05";
    megasploot = "github:matteojoliveau/megasploot.nix";
  };

  outputs = { self, nixpkgs, megasploot }: {
    nixosConfigurations.hostname = nixpkgs.lib.nixosSystem {
      system = "x86_64-linux";
      modules = [
        {config, pkgs, ...}: {
          nixpkgs.overlays = [megasploot.overlays.default];
          environment.systemPackages = with pkgs; [
            dungeondraft
            wonderdraft
          ];
        }
      ]
    };
  }
}
```

## Disclaimer

Megasploot sells proprietary software that we are not allowed to redistribute. This repository only contains Nix derivation that package up their software for use in Nix-based systems. You have to provide the software yourself by purchasing it from the respective official site, downloading the zip file and adding it manually to the nix store.

You will also need to [configure Nix to allow unfree software](https://nixos.wiki/wiki/Unfree_Software), otherwise Nix will refuse to install them.

If you try to install these packages without having the software in the store, you'll see a message similar to this:

```
***
Unfortunately, we cannot download file Wonderdraft-1.1.6.1-Linux64.zip automatically.
Please go to https://wonderdraft.net/ to download it yourself, and add it to the Nix store
using either
  nix-store --add-fixed sha256 Wonderdraft-1.1.6.1-Linux64.zip
or
  nix-prefetch-url --type sha256 file:///path/to/Wonderdraft-1.1.6.1-Linux64.zip

***
```

After running one of the proposed commands, you should be able to retry the install via Nix.

Feel free to request newer versions by opening an issue, or better yet submitting a PR yourself that updates the version number and SHA256 hash of the relevant software. This repository is maintained in a best-effort way, so it may lag behind a bit.

## License

The source code provided in this repository is copyright of Matteo Joliveau and freely usable under the terms of the [MIT License](LICENSE).

Megasploot's software is copyright of Tailwind Games LLC and subject to the terms of their End-User License Agreement (provided in each software directory). This repository DOES NOT REDISTRIBUTE any code or software by Tailwind Games LLC directly.

[Megasploot]: https://www.megasploot.com/
[Nix and NixOS]: https://nixos.org
