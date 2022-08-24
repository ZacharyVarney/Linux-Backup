{ config, pkgs, ... }:

{
  imports =
    [ # Include the results of the hardware scan.
      ./hardware-configuration.nix
    ];


  # Use this to define bootloader.
  boot.loader.grub.forceInstall = false; # RISKY!
  boot.loader.grub.enable                = true;
  boot.loader.grub.copyKernels           = true;
  boot.loader.grub.efiInstallAsRemovable = true;
  boot.loader.grub.efiSupport            = true;
  boot.loader.grub.fsIdentifier          = "label";
  boot.loader.grub.splashMode            = "stretch";
  boot.loader.grub.devices               = [ "nodev" ];
  boot.loader.grub.extraEntries = ''
    menuentry "Reboot" {
      reboot
    }
    menuentry "Poweroff" {
      halt
    }
  '';


  # Use this to define network configuration.
  networking.hostName = "zachs-pc"; # Define your hostname.
 
  # Pick only one of the below networking options.
  # networking.wireless.enable = true;  # Enables wireless support via wpa_supplicant.
  networking.networkmanager.enable = true;  # Easiest to use and most distros use this by default.


  # Set your time zone.
  time.timeZone = "America/Kentucky/Louisville";


  # Select internationalisation properties.
  i18n.defaultLocale = "en_US.UTF-8";
  console = {
    font = "Lat2-Terminus16";
    keyMap = "us";
  };


  # Enable window manager/desktop & display manager/server here.
  services.xserver.enable = true;
  services.xserver.displayManager.sddm.enable = true;
  services.xserver.windowManager.awesome.enable = true;
  

  # Configure keymap in X11
  services.xserver.layout = "us";


  # Enable sound.
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
    # If you want to use JACK applications, uncomment this
    #jack.enable = true;
  };


  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.zach = {
    isNormalUser = true;
    initialPassword = "123"; # Remember to change this after install.
    extraGroups = [ "wheel" "networkmanager" ]; # Enable ‘sudo’ for the user with group "wheel".
  };

  
  # Allow unfree/unstable packages.
  nixpkgs.config.allowUnfree = true;

  # List packages installed in system profile.
  environment.systemPackages = with pkgs; [
    # Core utils
	git
	neofetch
	wget
	curl
	cmake
	neovim
	asciiquarium
	cmatrix
	termdown
	fish
	micro
	starship
	bpytop
	flatpak
	gamemode
	xdg-user-dirs
	dunst
	
    # System apps
    brave
    alacritty
    librewolf
    pcmanfm
    rofi
    nitrogen
    picom
    vscodium
    geany
    obs-studio
    xarchiver
    mpv
    vlc
    teamspeak_client
    discord
    signal-desktop
    gparted
    lxappearance
    pavucontrol
    easyeffects
    etcher
    flameshot
    xfce.tumbler
    xfce.ristretto
    xfce.xfce4-power-manager
    libreoffice-fresh
    lxde.lxsession

    # Fonts
    noto-fonts-emoji
    hack-font
    fira-code
    fira
    font-awesome
    jetbrains-mono
    roboto
    fantasque-sans-mono
  ];

  # Enable steam.
  programs.steam = {
  	enable = true;
  };


  # Some programs need SUID wrappers, can be configured further or are
  # started in user sessions.
  # programs.mtr.enable = true;
  # programs.gnupg.agent = {
  #   enable = true;
  #   enableSSHSupport = true;
  # };


  # List services that you want to enable:
  # Enable the OpenSSH daemon.
  services.openssh.enable = true;


  # Open ports in the firewall.
  # networking.firewall.allowedTCPPorts = [ ... ];
  # networking.firewall.allowedUDPPorts = [ ... ];
  # Or disable the firewall altogether.
  # networking.firewall.enable = false;


  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "22.05"; # Did you read the comment?

}
