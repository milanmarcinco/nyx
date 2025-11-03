#! /bin/sh

ROOT_PATH=/etc/nixos

sudo sh -c "cat configuration.nix > $ROOT_PATH/configuration.nix"

# Initialize secrets directory and files
sudo mkdir -p $ROOT_PATH/secrets
sudo touch $ROOT_PATH/secrets/hotspot-psk

# Initialize ssh directory and authorized keys file
sudo mkdir -p $ROOT_PATH/ssh
sudo touch $ROOT_PATH/ssh/authorized_keys

echo "Enjoy."
