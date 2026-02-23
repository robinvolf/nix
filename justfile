# Buildne virtuálku cíle target
buildvm target:
    @echo Buildím virtuálku pro {{target}}
    nix build .#nixosConfigurations.{{target}}.config.system.build.vm
