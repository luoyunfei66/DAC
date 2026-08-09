`timescale 1ns / 1ps

module dac_tb();
    reg                clk1;
    reg                clk2;
    reg                clk3;
    reg                clk4;
    reg                clk5;
    reg                rst_n;
    reg  signed [16:0] data_in;
    wire signed [17:0] data_out;

    reg  signed [16:0] data_mem [0:12499];

    integer i;
    integer fout;

    dac dac_inst (
                 .clk1    (clk1    ),
                 .clk2    (clk2    ),
                 .clk3    (clk3    ),
                 .clk4    (clk4    ),
                 .clk5    (clk5    ),
                 .rst_n   (rst_n   ),
                 .data_in (data_in ),
                 .data_out(data_out)
                 );

    initial begin
        clk1 = 1'b1;
        forever #1.6 clk1 = ~clk1;
    end

    initial begin
        clk2 = 1'b1;
        forever #0.8 clk2 = ~clk2;
    end

    initial begin
        clk3 = 1'b1;
        forever #0.4 clk3 = ~clk3;
    end

    initial begin
        clk4 = 1'b1;
        forever #0.2 clk4 = ~clk4;
    end

    initial begin
        clk5 = 1'b1;
        forever #0.1 clk5 = ~clk5;
    end

    initial begin
        rst_n         = 1'b0;
        data_in       = 17'sd0;

        repeat (2) @ (posedge clk1);
        rst_n = 1'b1;

        for (i = 0; i < 12500; i = i + 1) begin
            data_in       = data_mem[i];
            @ (posedge clk1);
        end

        repeat (20) @ (posedge clk1);
        $fclose(fout);
        $stop;
    end

    initial begin
        $readmemb("C:\\Users\\luoyunfei\\Desktop\\matlab\\dac_in.txt", data_mem);
    end  

    initial begin
        fout = $fopen("C:\\Users\\luoyunfei\\Desktop\\matlab\\dac_out.txt", "w");
    end

    always @ (posedge clk5) begin
        if (rst_n) begin
            $fwrite(fout, "%0d\n", data_out);
        end
    end

endmodule