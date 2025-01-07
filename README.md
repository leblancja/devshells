A selection of nix flakes for setting up contained development environment shells with all required libraries and tools installed and configured.

I recommend also installing direnv which enables the shell automatically upon navigating into the project directory.

How to use:

-Move the desired flake.nix file into the project's root directory.

-Run the command ``$ nix develop`` to enter the devshell.

(optional, if using direnv):

-create a new file named envrc or .envrc in the same directory as flake.nix. This file should contain one line: ``use flake``.

-allow direnv to access the directory by running the command ``$ direnv allow``.

-the shell should now automatically activate without needing to run ``$ nix develop`` when you are within the project directory.

