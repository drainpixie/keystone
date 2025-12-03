{
  config,
  tools,
  lib,
  ...
}: let
  cfg = config.rin.services.uptime;
  inherit (lib) mkIf;
in {
  options.rin.services.uptime = tools.mkServiceOption "uptime" {
    port = 3001;
    domain = "kuma.drainpixie.xyz";
  };

  config = mkIf cfg.enable {
    services = {
      uptime-kuma = {
        enable = true;

        settings = {
          HOST = cfg.host;
          PORT = toString cfg.port;
        };
      };

      nginx.virtualHosts.${cfg.domain}.locations."/" = {
        proxyPass = "http://${cfg.host}:${toString cfg.port}";
        proxyWebsockets = true;
      };
    };
  };
}
