//--------------------------------------------------
//--    Author: Juan Sebastian Fabi
//--    Brief:  Programas para aprender verilor sobre
//--            EDU CIAA FPGA
//--------------------------------------------------

/*
module Fport(output [3:0] data);
wire [3:0] data;
 assign data = 4'b1010; //-- 4'hA
endmodule
*/

module inv (input A,output B);
wire A;
wire B;

    assign B = ~A;
    
endmodule

