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
          device = "/dev/disk/by-label/NIXBOOT";
          content = {
            format = "vfat";
            type = "filesystem";
            mountpoint = "/boot";
            mountOptions = ["defaults"];

            extraArgs = [
              "-n"
              "NIXBOOT"
            ];
          };
        };

        root = {
          size = "100%";
          device = "/dev/disk/by-label/NIXROOT";
          content = {
            format = "ext4";
            mountpoint = "/";
            type = "filesystem";
            mountOptions = ["defaults"];

            extraArgs = [
              "-L"
              "NIXROOT"
            ];
          };
        };
      };
    };
  };
}
