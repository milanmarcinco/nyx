#! /bin/sh

nix-env --profile /nix/var/nix/profiles/system --delete-generations old
nix-collect-garbage -d
