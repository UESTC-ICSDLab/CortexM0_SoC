module AHBlite_MicroCode_controller(
    input  wire          HCLK,    
    input  wire          HRESETn, 
    input  wire          HSEL,    
    input  wire   [31:0] HADDR,   
    input  wire    [1:0] HTRANS,  
    input  wire    [2:0] HSIZE,   
    input  wire    [3:0] HPROT,   
    input  wire          HWRITE,  
    input  wire   [31:0] HWDATA,  
    input  wire          HREADY,  
    output wire          HREADYOUT, 
    output wire   [31:0] HRDATA,  
    output wire          HRESP,
    
    //MicroCode_controllerin
    output  wire [7:0] s_addr,
    output  wire [7:0] e_addr,
    output  wire       ena,
    input wire [7:0] indata   
);

assign HRESP = 1'b0;
assign HREADYOUT = 1'b1;

wire write_en;
assign write_en = HSEL & HTRANS[1] & HWRITE & HREADY;

wire read_en;
assign read_en=HSEL&HTRANS[1]&(~HWRITE)&HREADY;

reg [3:0] addr_reg;
always@(posedge HCLK or negedge HRESETn) begin
  if(~HRESETn) addr_reg <= 4'h0;
  else if(read_en || write_en) addr_reg <= HADDR[3:0];
end

reg rd_en_reg;
always@(posedge HCLK or negedge HRESETn) begin
  if(~HRESETn) rd_en_reg <= 1'b0;
  else if(read_en) rd_en_reg <= 1'b1;
  else rd_en_reg <= 1'b0;
end

reg wr_en_reg;
always@(posedge HCLK or negedge HRESETn) begin
  if(~HRESETn) wr_en_reg <= 1'b0;
  else if(write_en) wr_en_reg <= 1'b1;
  else  wr_en_reg <= 1'b0;
end



assign HRDATA = (rd_en_reg  & (addr_reg == 4'hc)) ? {24'd0,indata} : 32'd0;

reg [7:0] s_addr_reg;
reg [7:0] e_addr_reg;
reg ena_reg;
always@(posedge HCLK or negedge HRESETn) begin
    if(~HRESETn) begin
        s_addr_reg <= 8'd0;
        e_addr_reg <= 8'd0;
        ena_reg <= 1'd0;
    end
    else if(wr_en_reg & addr_reg == 4'h0)  s_addr_reg <= HWDATA[7:0];
    else if(wr_en_reg & addr_reg == 4'h4)  e_addr_reg <= HWDATA[7:0];
    else if(wr_en_reg & addr_reg == 4'h8)  ena_reg <= HWDATA[0];
  end
    

assign s_addr = s_addr_reg;
assign e_addr = e_addr_reg;
assign ena = ena_reg;

endmodule
