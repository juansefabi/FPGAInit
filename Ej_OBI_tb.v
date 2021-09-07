//---------------------------------------------------
//-- Banco de prueba para Fport
//-- (c) BQ August 2015
//-- Written by Juan Gonzalez (obijuan)
//---------------------------------------------------
//-- GPL v2 license
//---------------------------------------------------


//-- Modulo para el test bench
module Ej_OBI_tb;

//-- Registro de 1 bit conectado a la entrada del inversor
reg din;
    
//-- Cable conectado a la salida del inversor
wire dout;
    
//-- Instaciar el inversor, conectado din a la entrada A, y dout a la salida B
inv NOT1 (
 .A (din),
 .B (dout)
);

//-- Comenzamos las pruebas
initial begin

	//-- Fichero donde almacenar los resultados
	$dumpfile("Ej_OBI_tb.vcd");
	$dumpvars(0, Ej_OBI_tb);
	
  //-- Ponemos la entrada del inversor a 0
  #5 din = 0;
    
  //-- Tras 5 unidades de tiempo comprobamos la salida
  # 5 if (dout != 1)
        $display("---->¡ERROR! Esperado: 1. Leido: %d", dout);
    
  //-- Tras otras 5 unidades ponemos un 1 en la entrada
  # 5 din = 1;
     
  //-- Tras 5 unidades comprobamos si hay un 0 en la entrada
  # 5 if (dout != 0)
        $display("---> ¡ERROR! Esperado: 0. Leido: %d", dout);
    
  # 5 $display("FIN de la simulacion");
  # 10 $finish;
end

endmodule


