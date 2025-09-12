let
  users = {
    drainpixie = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIGjrd3Drz463j6IpRJzPIm+KczyhYE7upw7rjlGTlMnJ";
  };

  systems = {
    incubator = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIJpKeebWH0pr1k0CunGW5yGDyDuuUQna4yFR8zcqpuv+";
    timeline = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAINZsYT0r+KwVfP6i9sYRqIsrGvFytoQ5pDPfNLTNzA7u";
  };

  allUsers = builtins.attrValues users;
in {
  "wakapi-salt".publicKeys = allUsers ++ [systems.incubator];

  "wakapi-conf".publicKeys = allUsers ++ [systems.timeline];
  "incubator".publicKeys = allUsers ++ [systems.timeline];
}
