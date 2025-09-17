_: {
  environment.etc."nginx/html/index.html".text = ''
    <b>incubator</b>
  '';

  security.acme = {
    acceptTerms = true;
    defaults.email = "faye.keller06+web@gmail.com";
  };

  services.nginx = {
    enable = true;

    recommendedGzipSettings = true;
    recommendedOptimisation = true;
    recommendedProxySettings = true;
    recommendedTlsSettings = true;

    appendHttpConfig = ''
      add_header X-Frame-Options DENY;
      add_header X-Content-Type-Options nosniff;
      add_header X-XSS-Protection "1; mode=block";
    '';

    virtualHosts."drainpixie.duckdns.org" = {
      enableACME = true;
      forceSSL = true;

      root = "/etc/nginx/html";

      locations = {
        "/".index = "index.html";

        "/wakapi/" = {
          proxyPass = "http://0.0.0.0:8080/";
          proxyWebsockets = true;
        };
      };
    };
  };
}
