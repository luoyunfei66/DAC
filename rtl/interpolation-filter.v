module interpolation_filter
    (
// clk, rst_n
    input  wire                 clk1,
    input  wire                 clk2,
    input  wire                 clk3,
    input  wire                 clk4,
    input  wire                 rst_n,
// input
    input  wire signed [16:0]   data_in,
// output
    output wire signed [25:0]   data_out 
    );

    wire signed        [24:0] data_out_1;
    wire signed        [25:0] data_out_2;

    hbf inst1              (
                            .clk         (clk1       ),
                            .rst_n       (rst_n      ),
                            .data_in     (data_in    ),
                            .data_out    (data_out_1 )
                            );

    cic_compensation  inst2 (
                            .clk         (clk2       ),
                            .rst_n       (rst_n      ),
                            .data_in     (data_out_1 ),
                            .data_out    (data_out_2 )
                            );

    cic inst3               (
                            .clk1             (clk2            ),
                            .clk2             (clk3            ),
                            .clk3             (clk4            ),
                            .rst_n            (rst_n           ),
                            .data_in          (data_out_2      ),
                            .data_out         (data_out        )
                            );

endmodule