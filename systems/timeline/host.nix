{
  config,
  pkgs,
  ...
}: {
  imports = [
    ../../modules/neovim

    ../../modules/discord.nix
    ../../modules/shell.nix
    ../../modules/steam.nix
    ../../modules/de.nix
  ];

  my = {
    de = "gnome";
    layout = "it";

    shell.enable = true;
    shell.minimal = false;

    neovim.enable = true;
    neovim.minimal = false;

    vm = true;
    age = true;
    steam = true;
    docker = true;
    discord = true;
    bluetooth = true;
  };

  age.identityPaths =
    map (key: "${config.hm.home.homeDirectory}/.ssh/${key}")
    ["drainpixie" "incubator"];

  age.secrets = {
    incubator = {
      file = ../../secrets/incubator;
      path = "/etc/ssh/ssh_config.d/incubator";
      owner = "root";
      group = "root";
      mode = "0644";
    };

    waka-conf = {
      path = "${config.hm.home.homeDirectory}/.wakatime.cfg";
      file = ../../secrets/wakapi-conf;
      owner = config.my.user;
      group = "users";
      mode = "777";
    };
  };

  programs.ssh.startAgent = true;

  time.hardwareClockInLocalTime = true;
  documentation.nixos.enable = false;
  powerManagement.enable = true;

  services = {
    upower.enable = true;
    tlp.enable = true;

    openssh = {
      enable = true;
      settings = {
        PermitRootLogin = "no";
        PasswordAuthentication = false;
      };
    };
  };

  users.users.${config.my.user} = {
    description = "faye's user";
    extraGroups = ["networkmanager"];
  };

  boot = {
    kernelPackages = pkgs.linuxPackages_latest;
    loader = {
      systemd-boot.enable = true;
      efi.canTouchEfiVariables = true;
    };
  };

  networking = {
    networkmanager.enable = true;

    nameservers = [
      "8.8.8.8"
      "8.8.4.4"
    ];
  };
}
