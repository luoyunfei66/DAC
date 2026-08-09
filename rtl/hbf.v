module hbf
    (
// clk, rst_n
    input  wire                 clk,
    input  wire                 rst_n,
// input
    input  wire signed [16:0]   data_in,
// output
    output reg  signed [24:0]   data_out
    );

// port declaration:E0
    reg   signed       [23:0]   data_in_d1;
    reg   signed       [22:0]   data_in_d2;
    reg   signed       [21:0]   data_in_d3;
    reg   signed       [20:0]   data_in_d4;
    reg   signed       [19:0]   data_in_d5;
    reg   signed       [18:0]   data_in_d6;
    reg   signed       [17:0]   data_in_d7;
    reg   signed       [16:0]   data_in_d8;
    reg   signed       [14:0]   data_in_d9;
    reg   signed       [13:0]   data_in_d10;
    reg   signed       [12:0]   data_in_d11;
    reg   signed       [7 :0]   data_in_d12;
    reg   signed       [6 :0]   data_in_d13;

// port declaration:E1
    reg   signed       [16:0]   data_in_d1_1;
    reg   signed       [16:0]   data_in_d2_1;
    reg   signed       [16:0]   data_in_d3_1;
    reg   signed       [16:0]   data_in_d4_1;
    reg   signed       [16:0]   data_in_d5_1;
    reg   signed       [16:0]   data_in_d6_1;
    reg   signed       [16:0]   data_in_d7_1;

    reg   signed       [24:0]   data_out_0;
    reg   signed       [16:0]   data_out_1;

// port:input * coefficient
    wire   signed      [6 :0]   data_in_0;
    wire   signed      [9 :0]   data_in_1;
    wire   signed      [11:0]   data_in_2;
    wire   signed      [12:0]   data_in_3;
    wire   signed      [13:0]   data_in_4;
    wire   signed      [15:0]   data_in_5;
    wire   signed      [16:0]   data_in_6;

// CS
    wire   signed      [17:0]   CS1;
    wire   signed      [17:0]   CS2;

// CSE
    assign CS1       = data_in + (data_in >>> 2);
    assign CS2       = data_in - (data_in >>> 2);

    assign data_in_0 = data_in >>> 10;
    assign data_in_1 = -((data_in >>> 8) + (data_in >>> 11));
    assign data_in_2 = (data_in >>> 6) - (CS2 >>> 9);
    assign data_in_3 = -((data_in >>> 5) + (CS1 >>> 8));
    assign data_in_4 = (CS1 >>> 4) + (CS1 >>> 9);
    assign data_in_5 = -((CS2 >>> 2) - (data_in >>> 7) + (data_in >>> 11));
    assign data_in_6 = (CS1 >>> 1) + (data_in >>> 11);

    always @ (posedge clk or negedge rst_n) begin
        if (!rst_n) begin
            data_in_d1   <= 24'b0;
            data_in_d2   <= 23'b0;
            data_in_d3   <= 22'b0;
            data_in_d4   <= 21'b0;
            data_in_d5   <= 20'b0;
            data_in_d6   <= 19'b0;
            data_in_d7   <= 18'b0;
            data_in_d8   <= 17'b0;
            data_in_d9   <= 15'b0;
            data_in_d10  <= 14'b0;
            data_in_d11  <= 13'b0;
            data_in_d12  <=  8'b0;
            data_in_d13  <=  7'b0;
            data_out_0   <= 25'b0;
        end 
        else begin
            data_in_d13  <= data_in_0;
            data_in_d12  <= data_in_d13 + data_in_1;
            data_in_d11  <= data_in_d12 + data_in_2;
            data_in_d10  <= data_in_d11 + data_in_3;
            data_in_d9   <= data_in_d10 + data_in_4;
            data_in_d8   <= data_in_d9  + data_in_5;
            data_in_d7   <= data_in_d8  + data_in_6;
            data_in_d6   <= data_in_d7  + data_in_6;
            data_in_d5   <= data_in_d6  + data_in_5;
            data_in_d4   <= data_in_d5  + data_in_4;
            data_in_d3   <= data_in_d4  + data_in_3;
            data_in_d2   <= data_in_d3  + data_in_2;
            data_in_d1   <= data_in_d2  + data_in_1;
            data_out_0   <= data_in_d1  + data_in_0;
        end
    end

    always @ (posedge clk or negedge rst_n) begin
        if (!rst_n) begin
            data_in_d1_1 <= 17'b0;
            data_in_d2_1 <= 17'b0;
            data_in_d3_1 <= 17'b0;
            data_in_d4_1 <= 17'b0;
            data_in_d5_1 <= 17'b0;
            data_in_d6_1 <= 17'b0;
            data_in_d7_1 <= 17'b0;
            data_out_1   <= 17'b0;
        end 
        else begin
            data_in_d1_1 <= data_in;
            data_in_d2_1 <= data_in_d1_1;
            data_in_d3_1 <= data_in_d2_1;
            data_in_d4_1 <= data_in_d3_1;
            data_in_d5_1 <= data_in_d4_1;
            data_in_d6_1 <= data_in_d5_1;
            data_in_d7_1 <= data_in_d6_1;
            data_out_1   <= data_in_d7_1;
        end
    end

    always @ (*) begin
        data_out = clk ? data_out_0 : data_out_1;
    end

endmodule