{
  description = "SvelteKit development environment";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    flake-utils.url = "github:numtide/flake-utils";
  };

  outputs = { self, nixpkgs, flake-utils }:
    flake-utils.lib.eachDefaultSystem (system:
      let
        pkgs = import nixpkgs { inherit system; };
      in
      {
        devShells.default = pkgs.mkShell {
          buildInputs = with pkgs; [
            nodejs_22
            nodePackages.npm
            nodePackages.pnpm  
            nodePackages.typescript-language-server 
            nodePackages.svelte-language-server 
          ];

          shellHook = ''
          
            echo "SvelteKit development environment"
            echo "Node version: $(node --version)"
            echo "npm version: $(npm --version)"

  
            export NPM_CONFIG_PREFIX=$PWD/.npm-global
            export PATH=$NPM_CONFIG_PREFIX/bin:$PATH

            mkdir -p .npm-global
            
          '';
        };
      });
}
