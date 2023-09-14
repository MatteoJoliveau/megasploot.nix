# Megasploot.nix

[Megasploot] software packaged for [Nix and NixOS].

## Available software

- [Dungeondraft](https://dungeondraft.net). Systems: Linux AMD64
- [Wonderdraft](https://wonderdraft.net). Systems: Linux AMD64

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

[Megasploot]: https://www.megasploot.com/
[Nix and NixOS]: https://nixos.org
