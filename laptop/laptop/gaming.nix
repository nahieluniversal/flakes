{ config, pkgs, lib, millennium, ... }:

{
  nixpkgs.overlays = [
    millennium.overlays.default
    (final: prev: {
      millennium-64 = prev.millennium-64.overrideAttrs (old: {
        postPatch = (old.postPatch or "") + ''
          substituteInPlace thirdparty/forks/luajit/LuaJIT.cmake \
            --replace-fail 'detect_architecture(LJ_DETECTED_ARCH)' 'detect_architecture(LJ_DETECTED_ARCH)
if("${LJ_DETECTED_ARCH}" STREQUAL "" AND "${CMAKE_SYSTEM_PROCESSOR}" STREQUAL "x86_64")
  message(STATUS "Applying Nix fallback for LuaJIT architecture detection")
  set(LJ_DETECTED_ARCH "x86_64")
endif()' \
            --replace-fail 'detect_fpu_mode(LJ_DETECTED_FPU_MODE)' 'detect_fpu_mode(LJ_DETECTED_FPU_MODE)
if("${LJ_DETECTED_FPU_MODE}" STREQUAL "")
  set(LJ_DETECTED_FPU_MODE "Hard")
endif()' \
            --replace-fail 'detect_fpu_abi(LJ_DETECTED_FPU_ABI)' 'detect_fpu_abi(LJ_DETECTED_FPU_ABI)
if("${LJ_DETECTED_FPU_ABI}" STREQUAL "")
  set(LJ_DETECTED_FPU_ABI "Hard")
endif()'
        '';
      });
    })
  ];
  programs.gamemode.enable = true;
  programs.steam = {
    enable = true;
    remotePlay.openFirewall = true;
    dedicatedServer.openFirewall = true;
    localNetworkGameTransfers.openFirewall = true;
    extraCompatPackages = with pkgs; [
      proton-ge-bin
    ];
    package = pkgs.millennium-steam.override {
      extraEnv = {
        LD_AUDIT = "/home/olivernix/.local/share/SLSsteam/library-inject.so:/home/olivernix/.local/share/SLSsteam/SLSsteam.so";
      };
    };
  };

  # Gaming-related packages
  environment.systemPackages = with pkgs; [
    gamescope
    heroic
    mangohud
    ppsspp
    prismlauncher
    protontricks
    winetricks
    wineWow64Packages.staging
  ];
}
