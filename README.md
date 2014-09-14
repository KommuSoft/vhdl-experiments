vhdl-experiments
================

A set of vhdl experiments, can be used with `ghdl`.

Installation
------------

One can run

    sudo install.sh

The program will install `ghdl` and `gtkwave`.

Project creation
----------------

One can create a new project with the `createvhdlproject.sh` shell script:

    ./createvhdlproject.sh <project-name> <testbench-file>

With `<project-name>` the name of the project and `<testbench-file>` the name of the file that specifies testbench to run. The `<testbench-file>` will be located in the `testbench/` subdirectory.

The shell script will create a directory with the name of the project and additional subfolders as well as a `Makefile`.


Project commands
----------------

Each project supports the following commands (in the project directory):

 * `make ghdl-compile` compile the `*.vhd` files in the source directory;
 * `make ghdl-run` run the vhdl project and generate simulation files in the `simu` folder;
 * `make ghdl-view` to view the generated project data using `gtkwave`;
 * `make ghdl-clean` to clean the simulation folder.
 
One can run `make ghdl-all` to compile, run, view and clean the project.

Links
-----

 * `ghdl` [website](http://ghdl.free.fr/)
 * `ghdl` [manual](http://ghdl.free.fr/ghdl/)