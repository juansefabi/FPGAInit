#-------------------------------------------------------
#-- Author: Juan Sebastian Fabi
#-- MAKEFILE EDUCIAA FPGA
#-------------------------------------------------------

#-------------------------------------------------------
#-- Objetivo:
#--		COMPILACION: 	Herramienta "iverilog"
#--		SIMULACION: 	Herramienta "gtkwave"
#--		SINTESIS:		Herramienta "yosys"
#--		PLACE & ROUTE:	Herramienta "ARACHNE" o "NEXTPNR"
#--		BITSTREAM:		Herramienta "icepack"
#--		PROGRAM:		Herramienta "iceprog"
#-------------------------------------------------------

# Por defecto suponemos que se va a trabajar con la EDU-FPGA 
TARGET = EDUFPGA
PACKAGE = tq144:4k
SIZE = 8k

all: sim sint clean

sim: $(NAME)_tb.vcd

sint: $(NAME).bin
#-------------------------------------------------------
#--	COMPILAR Y SIMULAR
#-------------------------------------------------------
$(NAME)_tb.vcd: $(NAME).v $(NAME)_tb.v

	iverilog -o $(NAME)_tb.out $(NAME).v $(NAME)_tb.v

	./$(NAME)_tb.out
	gtkwave $(NAME)_tb.vcd

#-------------------------------------------------------
#--	SINTESIS, P&R, GEN. BIN t PROGRAMAR
#-------------------------------------------------------
$(NAME).bin: $(NAME).pcf $(NAME).v

	yosys -p "synth_ice40 -blif $(NAME).blif" $(NAME).v

	arachne-pnr -d $(SIZE) -P $(PACKAGE) -p $(NAME).pcf $(NAME).blif -o $(NAME).txt

	icepack $(NAME).txt $(NAME).bin

	iceprog $(NAME).bin

#-------------------------------------------------------
#-- LIMPIAR TODO
#-------------------------------------------------------
clean:
	rm -f *.bin *.txt *.blif *.out *.vcd *~