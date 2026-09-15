{ lib, stdenv, kernel, llvmPackages, ... }:

stdenv.mkDerivation {
  pname = "cpuid-fault-emulation";
  version = "1.0";
  
  src = ./cpuid_fault_emulation; 
  
  # Añadimos clang-unwrapped Y lld al entorno de construcción
  nativeBuildInputs = kernel.moduleBuildDependencies ++ [ llvmPackages.clang-unwrapped llvmPackages.lld ];
  
  hardeningDisable = [ "pic" ];

  patchPhase = ''
    cat > Makefile <<EOF
    obj-m += cpuid_fault_emulation.o
    cpuid_fault_emulation-objs := src/cpuid_fault_emulation.o src/capture_context.o src/run_vm.o
    
    ccflags-y += -Iinc
    asflags-y += -Iinc
    
    ccflags-y += -Wno-unused-command-line-argument
    asflags-y += -Wno-unused-command-line-argument
    
    KDIR := ${kernel.dev}/lib/modules/${kernel.modDirVersion}/build
    
    all:
    	make LLVM=1 -C \$(KDIR) M=\$(PWD) modules
    
    install:
    	make LLVM=1 -C \$(KDIR) M=\$(PWD) INSTALL_MOD_PATH=\$(out) modules_install
    EOF
  '';

  buildPhase = ''
    make all
  '';

  installPhase = ''
    make install
  '';
  
  meta = with lib; {
    description = "CPUID Fault Emulation kernel module";
    license = licenses.gpl2Only;
    platforms = platforms.linux;
  };
}