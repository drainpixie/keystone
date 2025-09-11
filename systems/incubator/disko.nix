{
  disko.devices.disk.main = {
    type = "disk";
    device = "/dev/vda";

    content = {
      type = "gpt";
      partitions = {
        ESP = {
          size = "512M";
          type = "EF00";
          device = "/dev/vda1";
          content = {
            format = "vfat";
            type = "filesystem";
            mountpoint = "/boot";
            mountOptions = ["defaults"];
          };
        };

        root = {
          size = "100%";
          device = "/dev/vda2";
          content = {
            format = "ext4";
            mountpoint = "/";
            type = "filesystem";
            mountOptions = ["defaults"];
          };
        };
      };
    };
  };
}
