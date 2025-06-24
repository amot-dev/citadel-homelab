{ config, pkgs, lib, ... }:

{
  networking.hostName = "citadel";
  time.timeZone = "America/Vancouver";

  users.users.custodian = {
    isNormalUser = true;
    # Give sudo and Docker permissions
    extraGroups = [ "wheel" "docker" ];
    openssh.authorizedKeys.keys = [
      # ⬇️ Replace this with your actual SSH public key
      "ssh-ed25519 <key>... <user>@<machine>"
    ];
    # No password login (SSH keys only)
    hashedPassword = null;
  };

  # Safely remove the nixos user (if it exists in a base image)
  users.users.nixos = lib.mkForce null;

  # Disable password login for root entirely
  users.users.root.hashedPassword = null;

  # Set Zsh system-wide
  programs.zsh.enable = true;
  users.defaultUserShell = pkgs.zsh;

  environment.systemPackages = with pkgs; [
    vim
    docker
    tailscale
    git
    curl
  ];

  # Enable tailscale and docker
  # TODO: configure tailnet?
  services.tailscale.enable = true;
  virtualisation.docker.enable = true;

  # Enable SSH server
  services.openssh.enable = true;
  services.openssh.settings.PasswordAuthentication = false;
  services.openssh.settings.PermitRootLogin = "no";

  # Don’t change this once set — defines system defaults 
  system.stateVersion = "24.05";  
}
