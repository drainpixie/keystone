_: {
  environment.etc."nginx/html/index.html".text = ''
    <b>incubator</b>
  '';

  services.nginx = {
    enable = false;

    recommendedGzipSettings = true;
    recommendedOptimisation = true;
    recommendedProxySettings = true;
    recommendedTlsSettings = true;

    appendHttpConfig = ''
      add_header X-Frame-Options DENY;
      add_header X-Content-Type-Options nosniff;
      add_header X-XSS-Protection "1; mode=block";
    '';

    virtualHosts = {
      default = {
        default = true;
        root = "/etc/nginx/html";
        locations = {
          "/".index = "index.html";
        };
      };
    };
  };
}
