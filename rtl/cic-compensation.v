module cic_compensation
    (
// clk, rst_n
    input  wire                 clk,
    input  wire                 rst_n,
// input
    input  wire signed [24:0]   data_in,
// output
    output reg  signed [25:0]   data_out
    );

// port declaration
    reg   signed       [24:0]   data_in_d1;
    reg   signed       [24:0]   data_in_d2;

    always @ (posedge clk or negedge rst_n) begin
        if (!rst_n) begin
            data_in_d1  <= 25'b0;
            data_in_d2  <= 25'b0;
            data_out    <= 26'b0;
        end 
        else begin
            data_in_d1  <= data_in;
            data_in_d2  <= data_in_d1;
            data_out    <= -(data_in_d2  + data_in - (data_in_d1 <<< 1) - (data_in_d1 <<< 3)) >>> 3;
        end
    end

endmodule