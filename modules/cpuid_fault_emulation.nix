{ config, lib, pkgs, ... }:

let
  cpuidFaultEmulation = pkgs.callPackage ./hv/default.nix {
    kernel = config.boot.kernelPackages.kernel;
  };
in
{
  boot.extraModulePackages = [ cpuidFaultEmulation ];
  boot.kernelModules = [ "cpuid_fault_emulation" ];
}