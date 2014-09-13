#!/bin/bash

tsb=$(basename "$2" ".vhd")

mkdir -p "$1/src"
mkdir -p "$1/testbench"
mkdir -p "$1/ise"
mkdir -p "$1/simu"

echo -n '' > "$1/testbench/$tsb.vhd"

echo "# project name
PROJECT=$1
# vhdl files
FILES = src/*.vhd
# testbench
SIMTOP = $tsb
SIMFILES = testbench/$tsb.vhd

# Simu break condition
GHDL_SIM_OPT    = --assert-level=error
#GHDL_SIM_OPT    = --stop-time=500ns

SIMDIR = simu
SYNTHFILES = bin/$1/netgen/synthesis" > "$1/Makefile"

echo '
GHDL_CMD        = ghdl
GHDL_FLAGS      = --ieee=synopsys --warn-no-vital-generic

VIEW_CMD        = /usr/bin/gtkwave

ghdl-analyze :
	$(GHDL_CMD) -i $(GHDL_FLAGS) --workdir=$(SIMDIR) --work=work $(FILES)

ghdl-compile :                                                                                                 
	mkdir -p $(SIMDIR)
	$(GHDL_CMD) -i $(GHDL_FLAGS) --workdir=$(SIMDIR) --work=work $(SIMFILES) $(FILES)
	$(GHDL_CMD) -m $(GHDL_FLAGS) --workdir=$(SIMDIR) --work=work $(SIMTOP)
	@mv $(SIMTOP) $(SIMDIR)/$(SIMTOP)

ghdl-run :
	@$(SIMDIR)/$(SIMTOP) $(GHDL_SIM_OPT) --vcdgz=$(SIMDIR)/$(SIMTOP).vcdgz

ghdl-view :
	gunzip --stdout $(SIMDIR)/$(SIMTOP).vcdgz | $(VIEW_CMD) --vcd

ghdl-clean :
	$(GHDL_CMD) --clean --workdir=$(SIMDIR)

ghdl-all :
	make ghdl-compile
	make ghdl-run
	make ghdl-view
	make ghdl-clean' >> "$1/Makefile"
