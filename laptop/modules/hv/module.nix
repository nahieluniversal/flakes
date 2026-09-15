{ config, pkgs, lib, ... }:

let
  cpuidFaultEmulation = pkgs.callPackage ./default.nix {
    kernel = config.boot.kernelPackages.kernel;
  };
in
{
  boot.extraModulePackages = [ cpuidFaultEmulation ];
  boot.kernelModules = [ "cpuid_fault_emulation" ];
  boot.blacklistedKernelModules = [ "kvm_amd" ];
}