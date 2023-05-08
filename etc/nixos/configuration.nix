{ config, pkgs, ... }:

{
  imports =
    [ # Include the results of the hardware scan.
      ./hardware-configuration.nix
    ];

  # Kernel.
  boot.kernelPackages = pkgs.linuxPackages_xanmod_latest;

  # Bootloader.
  boot.loader = {
    efi = {
      canTouchEfiVariables = true;
      efiSysMountPoint = "/boot/efi";
    };
    grub = {
      efiSupport = true;
      # efiInstallAsRemovable = true;
      device = "nodev";
    };
  };

  networking.hostName = "nixos"; # Define your hostname.
  # networking.wireless.enable = true;  # Enables wireless support via wpa_supplicant.

  # Enable networking
  networking.networkmanager.enable = true;

  # Set your time zone.
  time.timeZone = "America/New_York";

  # Select internationalisation properties.
  i18n.defaultLocale = "en_US.UTF-8";

  i18n.extraLocaleSettings = {
    LC_ADDRESS = "en_US.UTF-8";
    LC_IDENTIFICATION = "en_US.UTF-8";
    LC_MEASUREMENT = "en_US.UTF-8";
    LC_MONETARY = "en_US.UTF-8";
    LC_NAME = "en_US.UTF-8";
    LC_NUMERIC = "en_US.UTF-8";
    LC_PAPER = "en_US.UTF-8";
    LC_TELEPHONE = "en_US.UTF-8";
    LC_TIME = "en_US.UTF-8";
  };

  # Enable the X11 windowing system.
  services.xserver.enable = true;

  # Enable the KDE Plasma Desktop Environment.
  services.xserver.displayManager.sddm.enable = true;
  services.xserver.desktopManager.plasma5.enable = true;

  # Configure keymap in X11
  services.xserver = {
    layout = "us";
    xkbVariant = "";
  };

  # Enable sound with pipewire.
  sound.enable = true;
  hardware.pulseaudio.enable = false;
  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
    # If you want to use JACK applications, uncomment this
    #jack.enable = true;

    # use the example session manager (no others are packaged yet so this is enabled by default,
    # no need to redefine it in your config for now)
    #media-session.enable = true;
  };

  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.zach = {
    isNormalUser = true;
    description = "Zachary Varney";
    initialPassword = "1234";
    extraGroups = [ "networkmanager" "wheel" ];
  };

  # Allow unfree packages
  nixpkgs.config.allowUnfree = true;

  # List packages installed in system profile. To search, run:
  # $ nix search wget
  environment.systemPackages = with pkgs; [
    # Apps
    firefox
    kate
    goverlay
    protonup-qt
    teamspeak_client
    discord
    pavucontrol
    prismlauncher-qt5
    easyeffects
    signal-desktop
    xemu
    dolphin-emu
    pcsx2
    duckstation
    yuzu-mainline
    citra-canary
    ppsspp
    heroic
    obs-studio
    obs-studio-plugins.obs-vkcapture
    obs-studio-plugins.obs-gstreamer
    
    # Utilities
    micro
    fish
    starship
    cmatrix
    asciiquarium
    flatpak
    gamemode
    gamescope
    plymouth
    nixos-bgrt-plymouth
    neofetch
    xdg-user-dirs
    mangohud
    git
    speedtest-cli
    libsForQt5.sddm-kcm
    gvfs
    zerotierone
  ];


  # Programs that need special configuration


  # Enable dconf which is needed for some apps
  programs.dconf.enable = true;

  # Steam
  programs.steam = {
    enable = true;
    remotePlay.openFirewall = true;
    dedicatedServer.openFirewall = true;
  };
  
  # Enable services.
  services.openssh.enable = true;
  services.flatpak.enable = true;
  services.gvfs.enable = true;
  services.zerotierone.enable = true;

  # Open ports in the firewall.
  networking.firewall.allowedTCPPorts = [ 9993 2243 ];
  networking.firewall.allowedUDPPorts = [ 9993 2243 ];
  
  # Or disable the firewall altogether.
  networking.firewall.enable = true;

  # This value determines the NixOS release from which you first installed the system
  system.stateVersion = "22.11";
}
