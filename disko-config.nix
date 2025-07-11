{
  disko.devices = {
    disk.main = {
      type = "disk";
      device = "/dev/vda";  # 🛑 Replace with actual device (e.g. /dev/nvme0n1)
      content = {
        type = "gpt";
        partitions = {
          boot = {
            size = "512M";
            type = "EF00";
            content = {
              type = "filesystem";
              format = "vfat";
              mountpoint = "/boot";
            };
          };
          root = {
            size = "100%";
            content = {
              type = "filesystem";
              format = "ext4";
              mountpoint = "/";
            };
          };
        };
      };
    };
  };
}
