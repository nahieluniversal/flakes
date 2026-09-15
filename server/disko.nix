{
  disko.devices = {
    disk.nvme0 = {
      type = "disk";
      device = "/dev/nvme0n1";
      content = {
        type = "gpt";
        partitions = {
          # Partición boot EFI
          boot = {
            size = "1G";
            type = "EF00";
            content = {
              type = "filesystem";
              format = "vfat";
              mountpoint = "/boot";
              mountOptions = [
                "defaults"
                "fmask=0077"
                "dmask=0077"
              ];
              extraArgs = [ "-n" "nixos-boot" ];
            };
          };

          # Partición swap
          swap = {
            size = "8G";
            type = "8200";
            content = {
              type = "swap";
              resumeDevice = true;
            };
          };

          # Partición btrfs para / y /home
          root = {
            size = "100%";
            type = "8300";
            content = {
              type = "btrfs";
              extraArgs = [ "-L" "nixos-root" "-f" ];
              subvolumes = {
                "/" = {
                  mountpoint = "/";
                  mountOptions = [
                    "defaults"
                    "compress=zstd"
                    "noatime"
                  ];
                };
                "/home" = {
                  mountpoint = "/home";
                  mountOptions = [
                    "defaults"
                    "compress=zstd"
                    "noatime"
                  ];
                };
              };
            };
          };
        };
      };
    };
  };
}
