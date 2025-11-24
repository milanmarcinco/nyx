{ config, pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    nano wget curl tmux
    lm_sensors htop btop fastfetch
    git tailscale k3d
  ];
}
