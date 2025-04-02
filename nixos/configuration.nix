# Edit this configuration file to define what should be installed on
# your system. Help is available in the configuration.nix(5) man page, on
# https://search.nixos.org/options and in the NixOS manual (`nixos-help`).

{ config, lib, pkgs, ... }:

{
  imports =
    [ # Include the results of the hardware scan.
      # <nixos-hardware/dell/xps/15-9530/nvidia>
      ./hardware-configuration.nix
    ];

  # Use the systemd-boot EFI boot loader.
  boot.loader.systemd-boot = {
    enable = true;
    configurationLimit = 3;
  };
  boot.loader.efi.canTouchEfiVariables = true;

  nixpkgs.config.allowUnfree = true;
  nix.settings.experimental-features = [ "nix-command" "flakes" ];
  hardware.nvidia.open = true;

  networking.hostName = "kitten"; # Define your hostname.
  # Pick only one of the below networking options.
  # networking.wireless.enable = true;  # Enables wireless support via wpa_supplicant.
  networking.networkmanager.enable = true;  # Easiest to use and most distros use this by default.

  # Set your time zone.
  time.timeZone = "Europe/Kyiv";

  # Configure network proxy if necessary
  # networking.proxy.default = "http://user:password@proxy:port/";
  # networking.proxy.noProxy = "127.0.0.1,localhost,internal.domain";

  # Select internationalisation properties.
  i18n.defaultLocale = "en_US.UTF-8";
  # console = {
  #   font = "Lat2-Terminus16";
  #   keyMap = "us";
  #   useXkbConfig = true; # use xkb.options in tty.
  # };

  # Enable the X11 windowing system.
  # services.xserver.enable = true;


  

  # Configure keymap in X11
  # services.xserver.xkb.layout = "us";
  # services.xserver.xkb.options = "eurosign:e,caps:escape";

  # Enable CUPS to print documents.
  services.printing.enable = true;

  # Enable sound.
  # hardware.pulseaudio.enable = true;
  # OR
  services.pipewire = {
    enable = true;
    # alsa = {
    #   enable = true;
    #   support32Bit = true;
    # };
    pulse.enable = true;
  };

  # Enable touchpad support (enabled default in most desktopManager).
  services.libinput.enable = true;
  # services.xserver.videoDrivers = [ "nvidia" ];
  # hardware.graphics.enable = true;
  # hardware.nvidia = {
  #   modesetting.enable = true;
  #   powerManagement = {
  #     enable = true;
  #     finegrained = true;
  #   };
  #   open = true;
  #   nvidiaSettings = true;
  #   package = config.boot.kernelPackages.nvidiaPackages.stable;
  #   prime = {
  #     offload = {
  #       enable = true;
  #       enableOffloadCmd = true;
  #     };
  #     intelBusId = "PCI:0:2:0";
  #     nvidiaBusId = "PCI:1:0:0";
  #   };
  # };

  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.f1sty = {
    isNormalUser = true;
    extraGroups = [ "wheel" "networkmanager" "docker" "input" ]; # Enable ‘sudo’ for the user.
  #   packages = with pkgs; [
  #     tree
  #   ];
  };

  programs.firefox.enable = true;
  programs.hyprland.enable = true;
  programs.hyprlock.enable = true;
  programs.bash = {
    blesh.enable = true;
    shellAliases = {
      irssi = "irssi --config=~/.config/irssi/config";
      ip = "ip -c";
      nxs = "nix search nixpkgs";
      nxr = "nixos-rebuild switch --use-remote-sudo --upgrade";
    };
  };
  programs.fzf = {
    fuzzyCompletion = true;
    keybindings = true;
  };
  programs.git = {
    prompt.enable = true;
    enable = true;
  };
  programs.neovim = {
    defaultEditor = true;
    viAlias = true;
    vimAlias = true;
    enable = true;
  };
  programs.tmux = {
    aggressiveResize = true;
    baseIndex = 1;
    clock24 = true;
    enable = true;
    escapeTime = 0;
    historyLimit = 100000;
    keyMode = "vi";
    newSession = true;
    terminal = "tmux-256color";
  };

  # List packages installed in system profile. To search, run:
  # $ nix search wget
  environment.systemPackages = with pkgs; [
    aria2
    libreoffice-fresh
    ipcalc
    net-snmp
    delta
    nnn
    brightnessctl
    clang
    curl
    docker
    docker-buildx
    docker-compose
    fd
    foot
    fzf
    gcc
    imv
    irssi
    mako
    gnumake
    mpv
    openconnect
    pass
    pwgen
    ripgrep
    swaybg
    unzip
    waybar
    wget
    wofi
    yt-dlp
    zathura
  ];

  fonts.packages = with pkgs; [
    roboto-mono
    font-awesome
  ];

  virtualisation.docker.enable = true;
  security.rtkit.enable = true;
  security.sudo.wheelNeedsPassword = false;
  # hardware.enableAllFirmware = true;
  hardware.bluetooth.enable = true;

  # Some programs need SUID wrappers, can be configured further or are
  # started in user sessions.
  programs.mtr.enable = true;
  programs.gnupg.agent = {
    enable = true;
    enableSSHSupport = true;
  };

  # List services that you want to enable:

  # Enable the OpenSSH daemon.
  services.openssh.enable = true;

  # Open ports in the firewall.
  networking.firewall.allowedTCPPorts = [ 22 80 ];
  # networking.firewall.allowedUDPPorts = [ ... ];
  # Or disable the firewall altogether.
  # networking.firewall.enable = false;

  # Copy the NixOS configuration file and link it from the resulting system
  # (/run/current-system/configuration.nix). This is useful in case you
  # accidentally delete configuration.nix.
  # system.copySystemConfiguration = true;

  # This option defines the first version of NixOS you have installed on this particular machine,
  # and is used to maintain compatibility with application data (e.g. databases) created on older NixOS versions.
  #
  # Most users should NEVER change this value after the initial install, for any reason,
  # even if you've upgraded your system to a new NixOS release.
  #
  # This value does NOT affect the Nixpkgs version your packages and OS are pulled from,
  # so changing it will NOT upgrade your system - see https://nixos.org/manual/nixos/stable/#sec-upgrading for how
  # to actually do that.
  #
  # This value being lower than the current NixOS release does NOT mean your system is
  # out of date, out of support, or vulnerable.
  #
  # Do NOT change this value unless you have manually inspected all the changes it would make to your configuration,
  # and migrated your data accordingly.
  #
  # For more information, see `man configuration.nix` or https://nixos.org/manual/nixos/stable/options#opt-system.stateVersion .
  system.stateVersion = "24.11"; # Did you read the comment?
}
