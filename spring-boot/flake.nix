{
  description = "Spring Boot Development Environment";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    flake-utils.url = "github:numtide/flake-utils";
  };

  outputs = { self, nixpkgs, flake-utils }: 
    flake-utils.lib.eachDefaultSystem (system:
      let
        pkgs = import nixpkgs { inherit system; };

        jdk = pkgs.jdk21; # Change to jdk17 if needed
        maven = pkgs.maven;
        gradle = pkgs.gradle;
      in
      {
        devShells.default = pkgs.mkShell {
          buildInputs = [ jdk maven gradle ];

          shellHook = ''
            export JAVA_HOME=${jdk}
            export PATH=$PWD/.m2/bin:$PATH
            export MAVEN_USER_HOME=$PWD/.m2
            export GRADLE_USER_HOME=$PWD/.gradle
            echo "Spring Boot Dev Environment Ready!"
          '';
        };
      }
    );
}  
