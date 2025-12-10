module AHBlite_Decoder
#(
    /*RAMCODE enable parameter*/
    parameter Port0_en = 0,
    /************************/

    /*RAMDATA  enable parameter*/
    parameter Port1_en = 0,
    /************************/

    /*GCD enable parameter*/
    parameter Port2_en = 0,
    /************************/

    /*Segdisp enable parameter*/
    parameter Port3_en=0,
    /************************/

    /*Keyboard enable parameter*/
    parameter Port4_en=0
    /************************/

    
)(
    input [31:0] HADDR,

    /*RAMCODE OUTPUT SELECTION SIGNAL*/
    output wire P0_HSEL,

    /*RAMDATA OUTPUT SELECTION SIGNAL*/
    output wire P1_HSEL,

    /*GCD OUTPUT SELECTION SIGNAL*/
    output wire P2_HSEL,

    /*Segdisp OUTPUT SELECTION SIGNAL*/
    output wire P3_HSEL,       

    /*Keyboard OUTPUT SELECTION SIGNAL*/
    output wire P4_HSEL  
);

//RAMCODE-----------------------------------

//0x00000000-0x0000ffff
/*Insert RAMCODE decoder code there*/
assign P0_HSEL = (HADDR[31:16] == 16'h0000) ? Port0_en : 1'd0;
/***********************************/



//PERIPHRAL-----------------------------

//0x40000000 GCD Input A
//0x40000004 GCD Input B
//0x40000008 GCD Control (Start)
//0x4000000C GCD Status/Result
/*Insert GCD decoder code there*/
assign P2_HSEL = (HADDR[31:4] == 28'h4000000) ? Port2_en : 1'd0;
/***********************************/

//0X40000010 Segdisp DATA (0x40000010 - 0x40000013)
assign P3_HSEL = (HADDR[31:4] == 28'h4000001) && (HADDR[3:2] == 2'b00) ? Port3_en : 1'd0;

//0X40000014 Keyboard DATA  (0x40000014 - 0x40000017)
assign P4_HSEL = (HADDR[31:4] == 28'h4000001) && (HADDR[3:2] == 2'b01) ? Port4_en : 1'd0;
/***********************************/

//RAMDATA-----------------------------
//0X20000000-0X2000FFFF
/*Insert RAMDATA decoder code there*/
assign P1_HSEL = (HADDR[31:16] == 16'h2000) ? Port1_en : 1'b0;
/***********************************/

endmodule