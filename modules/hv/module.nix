# modules/hv/module.nix
{ config, pkgs, lib, ... }:

let
  # Aquí llamamos al paquete, pasándole el kernel actual del sistema
  cpuidFaultEmulation = pkgs.callPackage ./default.nix {
    kernel = config.boot.kernelPackages.kernel;
  };
in
{
  boot.extraModulePackages = [ cpuidFaultEmulation ];
  boot.kernelModules = [ "cpuid_fault_emulation" ];
  
  # Si necesitas blacklisitear kvm_amd, descomenta la siguiente línea:
  boot.blacklistedKernelModules = [ "kvm_amd" ];
}