
module CortexM0_SoC (
        input  wire  clk,
        input  wire  RSTn,
        inout  wire  SWDIO,  
        input  wire  SWCLK,
        // output wire [7:0] LED,
        // output wire       LEDclk,
        inout  wire [7:0] ioPin
);

//------------------------------------------------------------------------------
// DEBUG IOBUF 
//------------------------------------------------------------------------------

wire SWDO;
wire SWDOEN;
wire SWDI;

assign SWDI = SWDIO;
assign SWDIO = (SWDOEN) ?  SWDO : 1'bz;

//------------------------------------------------------------------------------
// Interrupt
//------------------------------------------------------------------------------

wire [31:0] IRQ;
wire interrupt_UART;
assign IRQ = 32'b0;

wire RXEV;
assign RXEV = 1'b0;

//------------------------------------------------------------------------------
// AHB
//------------------------------------------------------------------------------

wire [31:0] HADDR;
wire [ 2:0] HBURST;
wire        HMASTLOCK;
wire [ 3:0] HPROT;
wire [ 2:0] HSIZE;
wire [ 1:0] HTRANS;
wire [31:0] HWDATA;
wire        HWRITE;
wire [31:0] HRDATA;
wire        HRESP;
wire        HMASTER;
wire        HREADY;

//------------------------------------------------------------------------------
// RESET AND DEBUG
//------------------------------------------------------------------------------

wire SYSRESETREQ;
reg cpuresetn;

always @(posedge clk or negedge RSTn)begin
        if (~RSTn) cpuresetn <= 1'b0;
        else if (SYSRESETREQ) cpuresetn <= 1'b0;
        else cpuresetn <= 1'b1;
end

wire CDBGPWRUPREQ;
reg CDBGPWRUPACK;

always @(posedge clk or negedge RSTn)begin
        if (~RSTn) CDBGPWRUPACK <= 1'b0;
        else CDBGPWRUPACK <= CDBGPWRUPREQ;
end


//------------------------------------------------------------------------------
// Instantiate Cortex-M0 processor logic level
//------------------------------------------------------------------------------

cortexm0ds_logic u_logic (

        // System inputs
        .FCLK           (clk),           //FREE running clock 
        .SCLK           (clk),           //system clock
        .HCLK           (clk),           //AHB clock
        .DCLK           (clk),           //Debug clock
        .PORESETn       (RSTn),          //Power on reset
        .HRESETn        (cpuresetn),     //AHB and System reset
        .DBGRESETn      (RSTn),          //Debug Reset
        .RSTBYPASS      (1'b0),          //Reset bypass
        .SE             (1'b0),          // dummy scan enable port for synthesis

        // Power management inputs
        .SLEEPHOLDREQn  (1'b1),          // Sleep extension request from PMU
        .WICENREQ       (1'b0),          // WIC enable request from PMU
        .CDBGPWRUPACK   (CDBGPWRUPACK),  // Debug Power Up ACK from PMU

        // Power management outputs
        .CDBGPWRUPREQ   (CDBGPWRUPREQ),
        .SYSRESETREQ    (SYSRESETREQ),

        // System bus
        .HADDR          (HADDR[31:0]),
        .HTRANS         (HTRANS[1:0]),
        .HSIZE          (HSIZE[2:0]),
        .HBURST         (HBURST[2:0]),
        .HPROT          (HPROT[3:0]),
        .HMASTER        (HMASTER),
        .HMASTLOCK      (HMASTLOCK),
        .HWRITE         (HWRITE),
        .HWDATA         (HWDATA[31:0]),
        .HRDATA         (HRDATA[31:0]),
        .HREADY         (HREADY),
        .HRESP          (HRESP),

        // Interrupts
        .IRQ            (IRQ),          //Interrupt
        .NMI            (1'b0),         //Watch dog interrupt
        .IRQLATENCY     (8'h0),
        .ECOREVNUM      (28'h0),

        // Systick
        .STCLKEN        (1'b0),
        .STCALIB        (26'h0),

        // Debug - JTAG or Serial wire
        // Inputs
        .nTRST          (1'b1),
        .SWDITMS        (SWDI),
        .SWCLKTCK       (SWCLK),
        .TDI            (1'b0),
        // Outputs
        .SWDO           (SWDO),
        .SWDOEN         (SWDOEN),

        .DBGRESTART     (1'b0),

        // Event communication
        .RXEV           (RXEV),         // Generate event when a DMA operation completed.
        .EDBGRQ         (1'b0)          // multi-core synchronous halt request
);

//------------------------------------------------------------------------------
// AHBlite Interconncet
//------------------------------------------------------------------------------

wire            HSEL_P0;
wire    [31:0]  HADDR_P0;
wire    [2:0]   HBURST_P0;
wire            HMASTLOCK_P0;
wire    [3:0]   HPROT_P0;
wire    [2:0]   HSIZE_P0;
wire    [1:0]   HTRANS_P0;
wire    [31:0]  HWDATA_P0;
wire            HWRITE_P0;
wire            HREADY_P0;
wire            HREADYOUT_P0;
wire    [31:0]  HRDATA_P0;
wire            HRESP_P0;

wire            HSEL_P1;
wire    [31:0]  HADDR_P1;
wire    [2:0]   HBURST_P1;
wire            HMASTLOCK_P1;
wire    [3:0]   HPROT_P1;
wire    [2:0]   HSIZE_P1;
wire    [1:0]   HTRANS_P1;
wire    [31:0]  HWDATA_P1;
wire            HWRITE_P1;
wire            HREADY_P1;
wire            HREADYOUT_P1;
wire    [31:0]  HRDATA_P1;
wire            HRESP_P1;

wire            HSEL_P2;
wire    [31:0]  HADDR_P2;
wire    [2:0]   HBURST_P2;
wire            HMASTLOCK_P2;
wire    [3:0]   HPROT_P2;
wire    [2:0]   HSIZE_P2;
wire    [1:0]   HTRANS_P2;
wire    [31:0]  HWDATA_P2;
wire            HWRITE_P2;
wire            HREADY_P2;
wire            HREADYOUT_P2;
wire    [31:0]  HRDATA_P2;
wire            HRESP_P2;

wire            HSEL_P3;
wire    [31:0]  HADDR_P3;
wire    [2:0]   HBURST_P3;
wire            HMASTLOCK_P3;
wire    [3:0]   HPROT_P3;
wire    [2:0]   HSIZE_P3;
wire    [1:0]   HTRANS_P3;
wire    [31:0]  HWDATA_P3;
wire            HWRITE_P3;
wire            HREADY_P3;
wire            HREADYOUT_P3;
wire    [31:0]  HRDATA_P3;
wire            HRESP_P3;

wire            HSEL_P4;
wire    [31:0]  HADDR_P4;
wire    [2:0]   HBURST_P4;
wire            HMASTLOCK_P4;
wire    [3:0]   HPROT_P4;
wire    [2:0]   HSIZE_P4;
wire    [1:0]   HTRANS_P4;
wire    [31:0]  HWDATA_P4;
wire            HWRITE_P4;
wire            HREADY_P4;
wire            HREADYOUT_P4;
wire    [31:0]  HRDATA_P4;
wire            HRESP_P4;

wire            HSEL_P5;
wire    [31:0]  HADDR_P5;
wire    [2:0]   HBURST_P5;
wire            HMASTLOCK_P5;
wire    [3:0]   HPROT_P5;
wire    [2:0]   HSIZE_P5;
wire    [1:0]   HTRANS_P5;
wire    [31:0]  HWDATA_P5;
wire            HWRITE_P5;
wire            HREADY_P5;
wire            HREADYOUT_P5;
wire    [31:0]  HRDATA_P5;
wire            HRESP_P5;

wire            HSEL_P6;
wire    [31:0]  HADDR_P6;
wire    [2:0]   HBURST_P6;
wire            HMASTLOCK_P6;
wire    [3:0]   HPROT_P6;
wire    [2:0]   HSIZE_P6;
wire    [1:0]   HTRANS_P6;
wire    [31:0]  HWDATA_P6;
wire            HWRITE_P6;
wire            HREADY_P6;
wire            HREADYOUT_P6;
wire    [31:0]  HRDATA_P6;
wire            HRESP_P6;

AHBlite_Interconnect Interconncet(
        .HCLK           (clk),
        .HRESETn        (cpuresetn),

        // CORE SIDE
        .HADDR          (HADDR),
        .HTRANS         (HTRANS),
        .HSIZE          (HSIZE),
        .HBURST         (HBURST),
        .HPROT          (HPROT),
        .HMASTLOCK      (HMASTLOCK),
        .HWRITE         (HWRITE),
        .HWDATA         (HWDATA),
        .HRDATA         (HRDATA),
        .HREADY         (HREADY),
        .HRESP          (HRESP),

        // P0
        .HSEL_P0        (HSEL_P0),
        .HADDR_P0       (HADDR_P0),
        .HBURST_P0      (HBURST_P0),
        .HMASTLOCK_P0   (HMASTLOCK_P0),
        .HPROT_P0       (HPROT_P0),
        .HSIZE_P0       (HSIZE_P0),
        .HTRANS_P0      (HTRANS_P0),
        .HWDATA_P0      (HWDATA_P0),
        .HWRITE_P0      (HWRITE_P0),
        .HREADY_P0      (HREADY_P0),
        .HREADYOUT_P0   (HREADYOUT_P0),
        .HRDATA_P0      (HRDATA_P0),
        .HRESP_P0       (HRESP_P0),

        // P1
        .HSEL_P1        (HSEL_P1),
        .HADDR_P1       (HADDR_P1),
        .HBURST_P1      (HBURST_P1),
        .HMASTLOCK_P1   (HMASTLOCK_P1),
        .HPROT_P1       (HPROT_P1),
        .HSIZE_P1       (HSIZE_P1),
        .HTRANS_P1      (HTRANS_P1),
        .HWDATA_P1      (HWDATA_P1),
        .HWRITE_P1      (HWRITE_P1),
        .HREADY_P1      (HREADY_P1),
        .HREADYOUT_P1   (HREADYOUT_P1),
        .HRDATA_P1      (HRDATA_P1),
        .HRESP_P1       (HRESP_P1),

        // P2
        .HSEL_P2        (HSEL_P2),
        .HADDR_P2       (HADDR_P2),
        .HBURST_P2      (HBURST_P2),
        .HMASTLOCK_P2   (HMASTLOCK_P2),
        .HPROT_P2       (HPROT_P2),
        .HSIZE_P2       (HSIZE_P2),
        .HTRANS_P2      (HTRANS_P2),
        .HWDATA_P2      (HWDATA_P2),
        .HWRITE_P2      (HWRITE_P2),
        .HREADY_P2      (HREADY_P2),
        .HREADYOUT_P2   (HREADYOUT_P2),
        .HRDATA_P2      (HRDATA_P2),
        .HRESP_P2       (HRESP_P2),

        // P3
        .HSEL_P3        (HSEL_P3),
        .HADDR_P3       (HADDR_P3),
        .HBURST_P3      (HBURST_P3),
        .HMASTLOCK_P3   (HMASTLOCK_P3),
        .HPROT_P3       (HPROT_P3),
        .HSIZE_P3       (HSIZE_P3),
        .HTRANS_P3      (HTRANS_P3),
        .HWDATA_P3      (HWDATA_P3),
        .HWRITE_P3      (HWRITE_P3),
        .HREADY_P3      (HREADY_P3),
        .HREADYOUT_P3   (HREADYOUT_P3),
        .HRDATA_P3      (HRDATA_P3),
        .HRESP_P3       (HRESP_P3),

        // P4
        .HSEL_P4        (HSEL_P4),
        .HADDR_P4       (HADDR_P4),
        .HBURST_P4      (HBURST_P4),
        .HMASTLOCK_P4   (HMASTLOCK_P4),
        .HPROT_P4       (HPROT_P4),
        .HSIZE_P4       (HSIZE_P4),
        .HTRANS_P4      (HTRANS_P4),
        .HWDATA_P4      (HWDATA_P4),
        .HWRITE_P4      (HWRITE_P4),
        .HREADY_P4      (HREADY_P4),
        .HREADYOUT_P4   (HREADYOUT_P4),
        .HRDATA_P4      (HRDATA_P4),
        .HRESP_P4       (HRESP_P4),

        // P5
        .HSEL_P5        (HSEL_P5),
        .HADDR_P5       (HADDR_P5),
        .HBURST_P5      (HBURST_P5),
        .HMASTLOCK_P5   (HMASTLOCK_P5),
        .HPROT_P5       (HPROT_P5),
        .HSIZE_P5       (HSIZE_P5),
        .HTRANS_P5      (HTRANS_P5),
        .HWDATA_P5      (HWDATA_P5),
        .HWRITE_P5      (HWRITE_P5),
        .HREADY_P5      (HREADY_P5),
        .HREADYOUT_P5   (HREADYOUT_P5),
        .HRDATA_P5      (HRDATA_P5),
        .HRESP_P5       (HRESP_P5),

        // P6
        .HSEL_P6        (HSEL_P6),
        .HADDR_P6       (HADDR_P6),
        .HBURST_P6      (HBURST_P6),
        .HMASTLOCK_P6   (HMASTLOCK_P6),
        .HPROT_P6       (HPROT_P6),
        .HSIZE_P6       (HSIZE_P6),
        .HTRANS_P6      (HTRANS_P6),
        .HWDATA_P6      (HWDATA_P6),
        .HWRITE_P6      (HWRITE_P6),
        .HREADY_P6      (HREADY_P6),
        .HREADYOUT_P6   (HREADYOUT_P6),
        .HRDATA_P6      (HRDATA_P6),
        .HRESP_P6       (HRESP_P6)
);

//------------------------------------------------------------------------------
// AHB RAMCODE
//------------------------------------------------------------------------------

wire [31:0] RAMCODE_RDATA,RAMCODE_WDATA;
wire [13:0] RAMCODE_WADDR;
wire [13:0] RAMCODE_RADDR;
wire [3:0]  RAMCODE_WRITE;

AHBlite_Block_RAM RAMCODE_Interface(
        /* Connect to Interconnect Port 0 */
        .HCLK           (clk),
        .HRESETn        (cpuresetn),
        .HSEL           (HSEL_P0),
        .HADDR          (HADDR_P0),
        .HPROT          (HPROT_P0),
        .HSIZE          (HSIZE_P0),
        .HTRANS         (HTRANS_P0),
        .HWDATA         (HWDATA_P0),
        .HWRITE         (HWRITE_P0),
        .HRDATA         (HRDATA_P0),
        .HREADY         (HREADY_P0),
        .HREADYOUT      (HREADYOUT_P0),
        .HRESP          (HRESP_P0),
        .BRAM_WRADDR    (RAMCODE_WADDR),
        .BRAM_RDADDR    (RAMCODE_RADDR),
        .BRAM_RDATA     (RAMCODE_RDATA),
        .BRAM_WDATA     (RAMCODE_WDATA),
        .BRAM_WRITE     (RAMCODE_WRITE)
        /**********************************/
);

//---------------------
// AHB RAMDATA
//------------------------------------------------------------------------------

wire [31:0] RAMDATA_RDATA;
wire [31:0] RAMDATA_WDATA;
wire [13:0] RAMDATA_WADDR;
wire [13:0] RAMDATA_RADDR;
wire [3:0]  RAMDATA_WRITE;

AHBlite_Block_RAM RAMDATA_Interface(
        /* Connect to Interconnect Port 1 */
        .HCLK		(clk),
        .HRESETn	(cpuresetn),
        .HSEL           (HSEL_P1),
        .HADDR          (HADDR_P1),
        .HPROT          (HPROT_P1),
        .HSIZE          (HSIZE_P1),
        .HTRANS         (HTRANS_P1),
        .HWDATA         (HWDATA_P1),
        .HWRITE         (HWRITE_P1),
        .HRDATA         (HRDATA_P1),
        .HREADY         (HREADY_P1),
        .HREADYOUT      (HREADYOUT_P1),
        .HRESP          (HRESP_P1),
        .BRAM_WRADDR	(RAMDATA_WADDR),
        .BRAM_RDADDR    (RAMDATA_RADDR),
        .BRAM_RDATA	(RAMDATA_RDATA),
        .BRAM_WDATA	(RAMDATA_WDATA),
        .BRAM_WRITE	(RAMDATA_WRITE)

        /**********************************/
);




//------------------------------------------------------------------------------
// AHB GPIO
//------------------------------------------------------------------------------

// wire [7:0] oData;
// wire [7:0] iData;
// wire outEn;

// AHBlite_GPIO GPIO_Interface(
//         /* Connect to Interconnect Port 4 */
//         .HCLK			(clk),
//         .HRESETn		(cpuresetn),
//         .HSEL           (HSEL_P4),
//         .HADDR          (HADDR_P4),
//         .HPROT          (HPROT_P4),
//         .HSIZE          (HSIZE_P4),
//         .HTRANS         (HTRANS_P4),
//         .HWDATA         (HWDATA_P4),
//         .HWRITE         (HWRITE_P4),
//         .HRDATA         (HRDATA_P4),
//         .HREADY         (HREADY_P4),
//         .HREADYOUT      (HREADYOUT_P4),
//         .HRESP          (HRESP_P4),
//         .outEn            (outEn),
//         .oData            (oData),
//         .iData            (iData)

//         /**********************************/ 
// );
//------------------------------------------------------------------------------
// RAM
//------------------------------------------------------------------------------

Block_RAM RAM_CODE(
        .clka           (clk),
        .addra          (RAMCODE_WADDR),
        .addrb          (RAMCODE_RADDR),
        .dina           (RAMCODE_WDATA),
        .doutb          (RAMCODE_RDATA),
        .wea            (RAMCODE_WRITE)
);

Block_RAM RAM_DATA(
        .clka           (clk),
        .addra          (RAMDATA_WADDR),
        .addrb          (RAMDATA_RADDR),
        .dina           (RAMDATA_WDATA),
        .doutb          (RAMDATA_RDATA),
        .wea            (RAMDATA_WRITE)
);

//------------------------------------------------------------------------------
// WaterLight
//------------------------------------------------------------------------------

// WaterLight WaterLight(
//         .WaterLight_mode(WaterLight_mode),
//         .WaterLight_speed(WaterLight_speed),
//         .clk(clk),
//         .RSTn(cpuresetn),
//         .LED(LED),
//         .LEDclk(LEDclk)
// );

//------------------------------------------------------------------------------
// GPIO
//------------------------------------------------------------------------------

// GPIO GPIO(
//         .outEn(outEn),
//         .oData(oData),
//         .iData(iData),
//         .clk(clk),
//         .RSTn(cpuresetn),
//         .ioPin(ioPin)
// );

//------------------------------------------------------------------------------
// MicroCode_subsystem
//------------------------------------------------------------------------------

//AHB MicroCode_controller
wire [7:0] s_addr;
wire [7:0] e_addr;
wire       ena   ;
wire [7:0] indata;

AHBlite_MicroCode_controller u_AHBlite_MicroCode_controller(
        /* Connect to Interconnect Port 5 */
        .HCLK      (clk          ),
        .HRESETn   (cpuresetn    ),
        .HSEL      (HSEL_P5      ),
        .HADDR     (HADDR_P5     ),
        .HTRANS    (HTRANS_P5    ),
        .HSIZE     (HSIZE_P5     ),
        .HPROT     (HPROT_P5     ),
        .HWRITE    (HWRITE_P5    ),
        .HWDATA    (HWDATA_P5    ),
        .HREADY    (HREADY_P5    ),
        .HREADYOUT (HREADYOUT_P5 ),
        .HRDATA    (HRDATA_P5    ),
        .HRESP     (HRESP_P5     ),
        .s_addr    (s_addr       ),
        .e_addr    (e_addr       ),
        .ena       (ena          ),
        .indata    (indata       )
);


//---------------------
// AHB Microcode_RAM
//------------------------------------------------------------------------------

wire [31:0] Microcode_RAM_WDATA;
wire [7:0] Microcode_RAM_WADDR;
wire [3:0]  Microcode_RAM_WRITE;

AHBlite_Block_RAM #(
        .ADDR_WIDTH (8)
) Microcode_RAM_Interface (
        /* Connect to Interconnect Port 6 */
        .HCLK		(clk),
        .HRESETn	(cpuresetn),
        .HSEL           (HSEL_P6),
        .HADDR          (HADDR_P6),
        .HPROT          (HPROT_P6),
        .HSIZE          (HSIZE_P6),
        .HTRANS         (HTRANS_P6),
        .HWDATA         (HWDATA_P6),
        .HWRITE         (HWRITE_P6),
        .HRDATA         (HRDATA_P6),
        .HREADY         (HREADY_P6),
        .HREADYOUT      (HREADYOUT_P6),
        .HRESP          (HRESP_P6),
        .BRAM_WRADDR	(Microcode_RAM_WADDR),
        .BRAM_RDADDR    ( ),
        .BRAM_RDATA	(32'hffffffff),
        .BRAM_WDATA	(Microcode_RAM_WDATA),
        .BRAM_WRITE	(Microcode_RAM_WRITE)

        /**********************************/
);



wire [7:0]  addr;
wire [31:0] MicroCode;
wire [7:0]  idata;
wire [7:0]  odata;
wire outEn;

MicroCode_controller u_MicroCode_controller(
    	.clk       (clk       ),
        .RSTn      (cpuresetn ),
        .s_addr    (s_addr    ),
        .e_addr    (e_addr    ),
        .indata    (indata    ),
        .ena       (ena       ),
        .MicroCode (MicroCode ),
        .addr      (addr      ),
        .idata     (idata     ),
        .odata     (odata     ),
        .outEn     (outEn     )
    );

    GPIO u_GPIO(
    	.outEn (outEn      ),
        .clk   (clk        ),
        .RSTn  (cpuresetn  ),
        .oData (odata      ),
        .iData (idata      ),
        .ioPin (ioPin      )
    );

    MicroCode_RAM u_MicroCode_RAM(
    	.clka  (clk                ),
        .addra (Microcode_RAM_WADDR),
        .addrb (addr               ),
        .dina  (Microcode_RAM_WDATA),
        .wea   (Microcode_RAM_WRITE),
        .doutb (MicroCode          )
    );


endmodule
