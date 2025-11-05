# Reproducible install

1. Clone the repository anywhere on the NixOS machine.

2. Run the commands below to copy over the necessary files to the NixOS configuration directory.

```
chmod +x secrets/copy.sh
sudo ./secrets/copy.sh
```

3. Configure the hotspot password in the following file:

```
/etc/nixos/secrets/hotspot-psk
```

4. Specify authorized SSH keys in the following file:

```
/etc/nixos/ssh/authorized_keys
```

5. Rebuild.

```
sudo nixos-rebuild switch
```

6. Enable tailscale using the following command and a generated auth key.

```
sudo tailscale up --auth-key=<AUTH_KEY>
```

7. Copy over configs and start services such as `traefik`.

8. Enjoy.
