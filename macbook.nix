{ config, lib, pkgs, ... }:

{
  imports = [
    ./macbook-hardware.nix
  ];

  # Asahi
  hardware.asahi.peripheralFirmwareDirectory = ./firmware;
  hardware.asahi.useExperimentalGPUDriver = true;
  hardware.asahi.addEdgeKernelConfig = true;
  hardware.asahi.withRust = true;

  # Boot
  boot = {
    loader.efi.canTouchEfiVariables = true;
    loader.systemd-boot.enable = true;
    initrd.systemd.enable = true;
  }

  # Networking
  networking.hostName = "macbook";
  networking.networkmanager = {
    enable = true;
    wifi.backend = "iwd";
  };
  hardware.bluetooth.enable = true;
  hardware.bluetooth.powerOnBoot = true;

  # Localization
  time.timeZone = "America/Phoenix";
  i18n.defaultLocale = "en_US.UTF-8";
  console = {
    keyMap = "dvorak";
  };

  # Services
  services = {
    # Pipewire Audio
    pipewire = {
      enable = true;
      alsa.enable = true;
      alsa.support32Bit = true;
      pulse.enable = true;
    };

    # Graphical Settings
    xserver = {
      enable = true;
      displayManager.sddm.enable = true;
      displayManager.defaultSession = "plasmawayland";
      desktopManager.plasma5.enable = true;

      libinput.enable = true;
      xkb.layout = "us";
      xkb.variant = "dvorak";
    }
  };
  # System Packages and fonts
  environment.systemPackages = with pkgs; [
    neovim
    sddm-kcm
    gptfdisk
    exfatprogs
  ];

  fonts.packages = with pkgs; [
    (nerdfonts.override { fonts = [ "FiraCode" "IBMPlexMono" ]; })
    noto-fonts-cjk
    noto-fonts-emoji
    ibm-plex
  ];

  # User Account Setup
  users.users.sreehari = {
    isNormalUser = true;
    extraGroups = [ "wheel" ];
    shell = pkgs.zsh;
    description = "Sreehari Sreedev";
  };

  # Program Settings
  programs = {
    zsh.enable = true;
    dconf.enable = true;
  }

  # Misc
  security.sudo.wheelNeedsPassword = false;
  security.rtkit.enable = true;
  nix.settings.experimental-features = [ "nix-command" "flakes" ];

  # DO NOT CHANGE THIS
  system.stateVersion = "23.11";
}
