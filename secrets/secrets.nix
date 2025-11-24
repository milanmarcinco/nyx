let
  milan = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAICsbMheMWAjk4KZGNpeEyfaJR7e1D9MV773HpHFYm/0P marcinco;personal;nyx";
  system = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIPjK41OsP2f8mwgcSdWJSZdbXhQ/eKwoCaua7MxmckVs root@nixos";
in {
  "hotspot-psk.age".publicKeys = [ system milan ];
}
