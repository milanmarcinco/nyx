{ config, pkgs, ... }:

{
  users.users.milan = {
    isNormalUser = true;
    description = "Milan Marcinco";
    extraGroups = [ "networkmanager" "wheel" "docker" "podman" ];

    packages = with pkgs; [ ];

    openssh.authorizedKeys.keys = [
      "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAICsbMheMWAjk4KZGNpeEyfaJR7e1D9MV773HpHFYm/0P marcinco;personal;nyx"
    ];
  };
}
