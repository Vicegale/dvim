# How to build

Requires Docker. Just clone and run ./build.sh. It creates an image called nvim, make sure it won't replace anything.

# How to run

Move or symlink dvim into your path. Go into a directory you wish to edit and simply type dvim.
You'll bash into the container, in a directory where the contents of your current host directory are mounted.
Simply run nvim as usual to edit files.
