#!/bin/bash
mkdir -p "$1/src"
mkdir -p "$1/testbench"
mkdir -p "$1/ise"
mkdir -p "$1/simu"

echo "# project name
PROJECT=$1
# vhdl files
FILES = src/*.vhd
# testbench
SIMTOP = $2
SIMFILES = testbench/$2.vhd" > "$1/Makefile"
echo '# Simu break condition
GHDL_SIM_OPT    = --assert-level=error

SIMDIR = simu
SYNTHFILES = 

GHDL_CMD        = ghdl
GHDL_FLAGS      = --ieee=synopsys --warn-no-vital-generic

VIEW_CMD        = /usr/bin/gtkwave

ghdl-compile :                                                                                                 
 mkdir -p simu                                                                                               
 $(GHDL_CMD) -i $(GHDL_FLAGS) --workdir=simu --work=work $(SIMFILES) $(FILES)                                
 $(GHDL_CMD) -m $(GHDL_FLAGS) --workdir=simu --work=work $(SIMTOP)                                           
 @mv $(SIMTOP) simu/$(SIMTOP)                                                                                
                                                                                                              
ghdl-run :                                                                                                    
 @$(SIMDIR)/$(SIMTOP) $(GHDL_SIM_OPT) --vcdgz=$(SIMDIR)/$(SIMTOP).vcdgz                                      
                                                                                                             
ghdl-view:                                                                                                    
 gunzip --stdout $(SIMDIR)/$(SIMTOP).vcdgz | $(VIEW_CMD) --vcd                                               
                                                                                                             
ghdl-clean :                                                                                                  
 $(GHDL_CMD) --clean --workdir=simu

ghdl-all :
  make ghdl-compile
  make ghdl-run
  make ghdl-view
  make ghdl-clean' >> "$1/Makefile"
