{
  description = "basic dotnet shell";

  inputs = {

    nixpkgs-unstable.url = "github:nixos/nixpkgs/nixos-unstable";
    flake-utils.url = "github:numtide/flake-utils";

  };

  outputs = { self, nixpkgs-unstable, flake-utils, ...}:

    flake-utils.lib.eachDefaultSystem(
      system: let
        pkgs = nixpkgs-unstable.legacyPackages.${system};
        dotnet-combined = 
          (with pkgs.dotnetCorePackages;
            combinePackages [
              sdk_9_0
              sdk_8_0
          ])
        .overrideAttrs (finalAttrs: previousAttrs: {
            # This is needed to install workload in $HOME
            # https://discourse.nixos.org/t/dotnet-maui-workload/20370/2

          postBuild =
            (previousAttrs.postBuild or '''')
            + ''
              for i in $out/sdk/*
              do
                i=$(basename $i)
                length=$(printf "%s" "$i" | wc -c)
                substring=$(printf "%s" "$i" | cut -c 1-$(expr $length - 2))
                i="$substring""00"
                mkdir -p $out/metadata/workloads/''${i/-*}
                touch $out/metadata/workloads/''${i/-*}/userlocal
              done
            '';
        });
    in {
      devShell = pkgs.mkShell {
        nativeBuildInputs = [
          dotnet-combined
        ];
        buildInputs = [];
        shellHook = ''
          export DOTNET_ROOT=${dotnet-combined}
          export NIX_LD_LIBRARY_PATH=$(pkgs.lib.makeLibraryPath [
            ${pkgs.lib.getLib pkgs.llvm_18}
            ${pkgs.lib.getLib pkgs.glibc}
          ])
          export NIX_LD=${pkgs.stdenv.cc}/bin/ld
        '';
      };
    }
  );
}
