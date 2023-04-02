module MicroCode_controller (
    //AHB
    input  wire       clk,
    input  wire       RSTn,
    input  wire [7:0] s_addr,
    input  wire [7:0] e_addr,
    output wire [7:0] indata,
    input  wire       ena,

    //MicroCode ram
    input  wire [31:0] MicroCode,
    output reg  [7:0]  addr,

    //GPIO       
    input  wire [7:0] idata,
    output reg  [7:0] odata,
    output wire       outEn
);

  //state
  localparam IDLE = 4'b0001;
  localparam FETCH = 4'b0010;
  localparam DELAY = 4'b0100;
  localparam DONE = 4'b1000;


  //decode
  wire [3:0] opc;
  wire [7:0] branch;
  wire [7:0] value;




//meaning of microcode to be finished





  assign opc = 0;
  assign branch = 0;
  assign value = 0;





/****************************/



  //delay cnt
  localparam CNT = 32'd50000000;
  reg [31:0] cnt;
  wire delay_flag = (cnt > CNT-32'd3);

  //done
  wire done;
  assign done = (addr > e_addr);

  //FSM
  reg [3:0] state,nxt_state;
  always @(*) begin
    case (state)
        IDLE : nxt_state = (ena) ? FETCH : IDLE;
        FETCH : nxt_state = (ena) ?  DELAY : IDLE;
        DELAY : nxt_state = (ena) ? ((delay_flag) ? ((done) ? DONE : FETCH) : DELAY) : IDLE;
        DONE : nxt_state = (ena) ?  DONE : IDLE;
        default: nxt_state <= state;
    endcase
  end
 
  always @(posedge clk or negedge RSTn) begin
    if (~RSTn) state <= IDLE;
    else state <= nxt_state;
  end
 
  always @(posedge clk) begin
    case (state)
        IDLE: begin
              addr <= s_addr;
              cnt <= 32'd0;
        end
        FETCH:begin
            addr <= (opc[0])? branch : (addr+8'd1);
            odata <= value; 
            cnt <= 32'd0;
        end
        DELAY:begin
            cnt <= cnt + 32'd1;
        end
        DONE: begin
            odata <= 8'h00; 
        end
    endcase
  end

  assign outEn = (state == FETCH) | (state == DELAY) | (state == DONE);
  assign indata = idata;
endmodule
