module cic
    (
// clk, rst_n
    input  wire                 clk1,
    input  wire                 clk2,
    input  wire                 clk3,
    input  wire                 rst_n,
// input
    input  wire signed [25:0]   data_in,
// output
    output wire signed [25:0]   data_out 
    );

    wire signed        [25:0] data_out_1;
    wire signed        [25:0] data_out_2;

    cic1 inst1 (
               .clk         (clk1       ),
               .rst_n       (rst_n      ),
               .data_in     (data_in    ),
               .data_out    (data_out_1 )
               );

    cic1 inst2 (
               .clk         (clk2       ),
               .rst_n       (rst_n      ),
               .data_in     (data_out_1 ),
               .data_out    (data_out_2 )
               );

    cic1 inst3 (
               .clk         (clk3       ),
               .rst_n       (rst_n      ),
               .data_in     (data_out_2 ),
               .data_out    (data_out   )
               );

endmodule