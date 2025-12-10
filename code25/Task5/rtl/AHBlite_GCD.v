module AHBlite_GCD(
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
    output wire          HRESP
);

assign HRESP = 1'b0;
assign HREADYOUT = 1'b1;

wire write_en;
assign write_en = HSEL & HTRANS[1] & HWRITE & HREADY;

reg wr_en_reg;
always@(posedge HCLK or negedge HRESETn) begin
  if(~HRESETn) wr_en_reg <= 1'b0;
  else if(write_en) wr_en_reg <= 1'b1;
  else wr_en_reg <= 1'b0;
end

// Address decode - need to latch address for both read and write
reg [1:0] addr_reg;
wire read_en = HSEL & HTRANS[1] & (~HWRITE) & HREADY;

always@(posedge HCLK or negedge HRESETn) begin
    if(~HRESETn) begin
        addr_reg <= 2'b00;
    end else if(write_en || read_en) begin
        addr_reg <= HADDR[3:2];
    end
end

wire addr_a    = (addr_reg == 2'b00);  // 0x00: input a
wire addr_b    = (addr_reg == 2'b01);  // 0x04: input b
wire addr_ctrl = (addr_reg == 2'b10);  // 0x08: control (start)
wire addr_res  = (addr_reg == 2'b11);  // 0x0C: result & status

// Registers
reg [31:0] reg_a;
reg [31:0] reg_b;
reg start;
wire [31:0] gcd_result;
wire gcd_done;

// Write operations
always@(posedge HCLK or negedge HRESETn) begin
    if(~HRESETn) begin
        reg_a <= 32'h00000000;
        reg_b <= 32'h00000000;
        start <= 1'b0;
    end else begin
        if(wr_en_reg && HREADY) begin
            if(addr_a) reg_a <= HWDATA;
            else if(addr_b) reg_b <= HWDATA;
            else if(addr_ctrl) start <= HWDATA[0];
        end else begin
            start <= 1'b0;  // Auto clear start signal after one cycle
        end
    end
end

// GCD core instantiation
GCD gcd_core(
    .clk(HCLK),
    .RSTn(HRESETn),
    .start(start),
    .a(reg_a),
    .b(reg_b),
    .result(gcd_result),
    .done(gcd_done)
);

// Read operations - use latched address
reg [31:0] hrdata_reg;
always@(*) begin
    case(addr_reg)
        /********** 需要补充的代码 **********/
    endcase
end

assign HRDATA = hrdata_reg;

endmodule
