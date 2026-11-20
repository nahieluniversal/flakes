{ stdenv, kernel }:
     
stdenv.mkDerivation {
  pname = "cpuid_fault_emulation";
  version = "0.1";
  src = ./cpuid_fault_emulation;  
  nativeBuildInputs = kernel.moduleBuildDependencies;
  hardeningDisable = [
    "pic"
    "format"
  ];  
  # Patch the hardcoded host paths to point into the Nix store
  postPatch = ''
    substituteInPlace Makefile \
    --replace '/lib/modules/$(KERNEL)/build' '${kernel.dev}/lib/modules/${kernel.modDirVersion}/build' \
    --replace '$(shell uname -r)' '${kernel.modDirVersion}'
  '';
  installPhase = ''
    install -D cpuid_fault_emulation.ko \
    $out/lib/modules/${kernel.modDirVersion}/extra/cpuid_fault_emulation.ko

    if [ -f cpuid_fault_emulation.ko.cer ]; then
      install -D cpuid_fault_emulation.ko.cer \
      $out/lib/modules/${kernel.modDirVersion}/extra/cpuid_fault_emulation.ko.cer
    else
      mkdir -p $out/lib/modules/${kernel.modDirVersion}/extra
      : > $out/lib/modules/${kernel.modDirVersion}/extra/cpuid_fault_emulation.ko.cer
    fi
  '';   
  meta.platforms = [ "x86_64-linux" ];
  meta.description = "CPUID fault emulation module for the Linux kernel";
}