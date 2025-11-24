# Reproducible install

1. Clone the repository anywhere on the NixOS machine.

2. Rebuild.

```
sudo nixos-rebuild switch --flake .#nyx
```

3. Enable tailscale using the following command and a generated auth key.

```
sudo tailscale up --auth-key=<AUTH_KEY>
```

4. Enjoy.

---

Command to create encrypted .age file with secrets. Needs to be run inside the `secrets` directory.

```
nix --extra-experimental-features nix-command \
    --extra-experimental-features flakes \
    run github:ryantm/agenix -- -e <secret_name>.age
```
