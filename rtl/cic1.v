module cic1
    (
// clk, rst_n
    input  wire                 clk,
    input  wire                 rst_n,
// input
    input  wire signed [25:0]   data_in,
// output
    output reg  signed [25:0]   data_out
    );

// port declaration:E0
    reg   signed       [25:0]   data_in_d1;
    reg   signed       [25:0]   data_in_d2;

    reg   signed       [28:0]   data_out_0;
    reg   signed       [28:0]   data_out_1;

    always @ (posedge clk or negedge rst_n) begin
        if (!rst_n) begin
            data_in_d1  <= 26'b0;
            data_in_d2  <= 26'b0;
            data_out_0  <= 29'b0;
        end 
        else begin
            data_in_d1  <= data_in;
            data_in_d2  <= data_in_d1;
            data_out_0  <= data_in_d2  + data_in + (data_in_d1 <<< 1) + (data_in_d1 <<< 2);
        end
    end

    always @ (posedge clk or negedge rst_n) begin
        if (!rst_n) begin
            data_out_1  <= 29'b0;
        end 
        else begin
            data_out_1  <= (data_in + data_in_d1) <<< 2;
        end
    end

    always @ (*) begin
        data_out = clk ? (data_out_0 >>> 3) : (data_out_1 >>> 3);
    end

endmodule