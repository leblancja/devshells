A selection of nix flakes for setting up nix devshells (conntained development environments) with all required libraries and tools installed and configured.

I recommend installing direnv which enables the shell automatically upon navigating into the project directory.

How to use:

-Move the desired flake.nix file into the project's root directory.
-Run the command ``$ nix develop`` to enter the devshell.

(optional, if using direnv):
-create a new file named envrc or .envrc in the same directory as flake.nix. This file should contain one line: ``use flake``.
-allow direnv to access the directory by running the command ``$ direnv allow``.

