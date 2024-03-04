{ config, pkgs, ... }:

{
  imports = [ ./hardware-configuration.nix ];

  # Enable experimental features
  nix.settings = {
    experimental-features = [ "nix-command" "flakes" ];
    auto-optimise-store = true;
  };

  # Bootloader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  networking.hostName = "nixos"; # Define your hostname.
  networking.wireless.enable =
    false; # Enables wireless support via wpa_supplicant.

  # Configure network proxy if necessary
  # networking.proxy.default = "http://user:password@proxy:port/";
  # networking.proxy.noProxy = "127.0.0.1,localhost,internal.domain";

  # Enable networking
  networking.networkmanager.enable = true;

  # Set your time zone.
  time.timeZone = "Africa/Tunis";

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

  programs.zsh = {
    enable = true;
    autosuggestions.enable = true;
    enableCompletion = true;
    histFile = "$HOME/.cache/.zsh_history";
    histSize = 100000;
    syntaxHighlighting.enable = true;
    ohMyZsh.enable = true;
    ohMyZsh.plugins = [ "golang" "vi-mode" "docker" "colored-man-pages" ];
  };

  users.defaultUserShell = pkgs.zsh;

  # Enable the GNOME Desktop Environment.
  services.xserver.displayManager.gdm.enable = true;
  services.xserver.desktopManager.gnome.enable = true;

  programs.sway = {
    enable = true;
    wrapperFeatures.gtk = true;
    extraSessionCommands = ''
      export SDL_VIDEODRIVER=wayland
      export QT_QPA_PLATFORM=wayland
      export QT_WAYLAND_DISABLE_WINDOWDECORATION="1"
      export _JAVA_AWT_WM_NONREPARENTING=1
      export MOZ_ENABLE_WAYLAND=1
    '';
  };

  programs.waybar.enable = true;

  # Sway
  services.dbus.enable = true;
  xdg.portal = {
    enable = true;
    wlr.enable = true;
  };

  # Configure keymap in X11
  services.xserver.xkb = {
    layout = "us";
    variant = "";
  };

  # Enable CUPS to print documents.
  services.printing.enable = true;

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

  # Enable touchpad support (enabled default in most desktopManager).
  # services.xserver.libinput.enable = true;

  virtualisation.docker = {
    enable = true;
    enableOnBoot = true;
  };

  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.zizou = {
    isNormalUser = true;
    description = "zizou";
    extraGroups = [ "networkmanager" "wheel" "docker" "libvirtd" ];
  };

  nixpkgs.config.allowUnfree = true;
  nixpkgs.config.permittedInsecurePackages = [ "electron-25.9.0" ];
  #nixpkgs.config.allowInsecure = true;

  # List packages installed in system profile. To search, run:
  # $ nix search wget
  environment.systemPackages = with pkgs; [
    kitty
    python311Packages.pillow
    obsidian
    discord
    vscode
    postman
    vivaldi
    syncthing
    git
    go_1_22
    hugo
    protobuf
    ollama
    gdu
    python3
    python311Packages.pip
    pipx
    nodejs
    yarn
    nodePackages.typescript-language-server
    bun
    rustup
    gcc
    ripgrep
    tldr
    zoxide
    starship
    fzf
    zathura
    gradience
    lf
    zip
    unzip
    which
    wget
    man
    jq
    htop
    fd
    gnumake
    eza
    bat
    curl
    file
    entr
    inetutils
    iotop
    wob
    wl-clipboard
    wf-recorder
    wdisplays
    wofi
    waybar
    dbus
    wayland
    xdg-utils
    glib
    swaylock
    swayidle
    grim
    slurp
    swaybg
    light
    swappy
    xwayland
    tesseract
    wl-mirror
    xwaylandvideobridge
    swaynotificationcenter
    cliphist
    nwg-look
    emote
    gnome-extension-manager
    brightnessctl
    pamixer
    wlogout
    gparted
    gammastep
    upower
    tlp
    nixpkgs-lint
    nixpkgs-fmt
    nixfmt
    gruvbox-gtk-theme
    cmus
    playerctl
    mpv
    alsa-utils
    pavucontrol
    imv
    feh
    networkmanagerapplet
    blueman
    ntfs3g
    nettools
    transmission-gtk

    adw-gtk3
    bibata-cursors
    papirus-icon-theme
  ];

  #environment.sessionVariables.NIXOS_OZONE_WL = "1";

  security.polkit.enable = true;

  programs.git = { enable = true; };

  services.blueman.enable = true;

  programs.neovim = {
    enable = true;
    defaultEditor = true;
  };

  environment.variables.EDITOR = "nvim";

  fonts.packages = with pkgs; [
    noto-fonts
    noto-fonts-cjk
    noto-fonts-emoji
    noto-fonts-color-emoji
    source-sans
    source-serif
    source-code-pro
    font-awesome
    ibm-plex
    liberation_ttf
    fira-code
    fira-code-symbols
    iosevka
    mplus-outline-fonts.githubRelease
    dina-font
    proggyfonts
    powerline-fonts
    meslo-lg
    meslo-lgs-nf
    jetbrains-mono
    ubuntu_font_family
    (nerdfonts.override {
      fonts = [ "FiraCode" "JetBrainsMono" "Meslo" "Iosevka" "Noto" ];
    })

  ];

  # Some programs need SUID wrappers, can be configured further or are
  # started in user sessions.
  # programs.mtr.enable = true;
  # programs.gnupg.agent = {
  #   enable = true;
  #   enableSSHSupport = true;
  # };

  # List services that you want to enable:
  services = {
    syncthing = {
      enable = true;
      user = "zizou";
      systemService = true;
      dataDir = "/home/zizou";
    };
  };

  services.gnome.gnome-keyring.enable = true;
  virtualisation.libvirtd.enable = true;
  programs.virt-manager.enable = true;

  hardware.bluetooth.settings = { General = { Experimental = true; }; };

  hardware.bluetooth.enable = true;
  hardware.bluetooth.powerOnBoot = true;

  systemd.user.services.mpris-proxy = {
    description = "Mpris proxy";
    after = [ "network.target" "sound.target" ];
    wantedBy = [ "default.target" ];
    serviceConfig.ExecStart = "${pkgs.bluez}/bin/mpris-proxy";
  };

  # Enable the OpenSSH daemon.
  services.openssh.enable = true;

  # Open ports in the firewall.
  # networking.firewall.allowedTCPPorts = [ ... ];
  # networking.firewall.allowedUDPPorts = [ ... ];
  # Or disable the firewall altogether.
  networking.firewall.enable = false;

  nix.gc = {
    automatic = true;
    dates = "weekly";
    options = "--delete-older-than 7d";
  };

  # programs.nix-ld.enable = true;
  # programs.nix-ld.libraries = with pkgs;
  #   [
  #     # Add any missing dynamic libraries for unpackaged 
  #     # programs here, NOT in environment.systemPackages
  #   ];

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "23.11"; # Did you read the comment?

}
