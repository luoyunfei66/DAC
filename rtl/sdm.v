module sdm
    (
// clk, rst_n
    input  wire                 clk,
    input  wire                 rst_n,
// input
    input  wire signed [25:0]   data_in,
// output
    output wire signed [17:0]   data_out
    );

// port declaration
    wire   signed      [26:0]   data_in_d1;
    wire   signed      [26:0]   data_in_d2;
    wire   signed      [27:0]   data_in_d3;
    wire   signed      [27:0]   data_in_d4;
    wire   signed      [28:0]   data_in_d6;
    wire   signed      [29:0]   data_in_d7;
    wire   signed      [29:0]   data_in_d8;
    wire   signed      [30:0]   data_in_d9;
    wire   signed      [30:0]   data_in_d10;
    reg    signed      [16:0]   data_in_d11;
    reg    signed      [16:0]   data_in_d5;

    reg    signed      [26:0]   data_in_d1_1;
    reg    signed      [26:0]   data_in_d2_1;
    reg    signed      [27:0]   data_in_d3_1;
    reg    signed      [27:0]   data_in_d4_1;
    reg    signed      [29:0]   data_in_d7_1;
    reg    signed      [29:0]   data_in_d8_1;
    reg    signed      [30:0]   data_in_d9_1;
    reg    signed      [30:0]   data_in_d10_1;

// adder
    assign data_in_d1 = data_in    - data_out;
    assign data_in_d3 = data_in_d2 - data_out;
    assign data_in_d6 = data_in_d5 - data_in_d4;
    assign data_in_d7 = data_in_d6 - data_in_d11;
    assign data_in_d9 = (data_in_d6 <<< 1) + data_in_d8 - (data_in_d11 <<< 1);
    assign data_out   = data_in_d5 - data_in_d11;

// delay
    always @ (posedge clk or negedge rst_n) begin
        if (!rst_n) begin
            data_in_d1_1  <= 27'b0;
            data_in_d2_1  <= 27'b0;
            data_in_d3_1  <= 28'b0;
            data_in_d4_1  <= 28'b0;
            data_in_d7_1  <= 30'b0;
            data_in_d8_1  <= 30'b0;
            data_in_d9_1  <= 31'b0;
            data_in_d10_1 <= 31'b0;
        end 
        else begin
            data_in_d1_1  <= data_in_d1;
            data_in_d2_1  <= data_in_d2;
            data_in_d3_1  <= data_in_d3;
            data_in_d4_1  <= data_in_d4;
            data_in_d7_1  <= data_in_d7;
            data_in_d8_1  <= data_in_d8;
            data_in_d9_1  <= data_in_d9;
            data_in_d10_1 <= data_in_d10;
        end
    end

// integrator
    assign data_in_d2  = (data_in_d1_1 >>> 1) + data_in_d2_1;
    assign data_in_d4  = (data_in_d3_1 <<< 1) + data_in_d4_1;
    assign data_in_d8  =  data_in_d7_1        + data_in_d8_1;
    assign data_in_d10 =  data_in_d9_1        + data_in_d10_1;

// ADC
    always @ (*) begin
        if (!rst_n)
            data_in_d5 = 17'sd0;
        else if (data_in_d4 > 28'sd63420  )
            data_in_d5 = 17'sd65535;  
        else if (data_in_d4 > 28'sd59192  )
            data_in_d5 = 17'sd61306;  
        else if (data_in_d4 > 28'sd54964  )
            data_in_d5 = 17'sd57078;  
        else if (data_in_d4 > 28'sd50736  )
            data_in_d5 = 17'sd52850;  
        else if (data_in_d4 > 28'sd46508  )
            data_in_d5 = 17'sd48622;  
        else if (data_in_d4 > 28'sd42280  )
            data_in_d5 = 17'sd44394;  
        else if (data_in_d4 > 28'sd38052  )
            data_in_d5 = 17'sd40166;
        else if (data_in_d4 > 28'sd33824  )
            data_in_d5 = 17'sd35938;  
        else if (data_in_d4 > 28'sd29596  )
            data_in_d5 = 17'sd31710;  
        else if (data_in_d4 > 28'sd25368  )
            data_in_d5 = 17'sd27482;  
        else if (data_in_d4 > 28'sd21140  )
            data_in_d5 = 17'sd23254;  
        else if (data_in_d4 > 28'sd16912  )
            data_in_d5 = 17'sd19026;  
        else if (data_in_d4 > 28'sd12684  )
            data_in_d5 = 17'sd14798;
        else if (data_in_d4 > 28'sd8456   )
            data_in_d5 = 17'sd10570;
        else if (data_in_d4 > 28'sd4228   )
            data_in_d5 = 17'sd6342;
        else if (data_in_d4 > 28'sd0      )
            data_in_d5 = 17'sd2114;
        else if (data_in_d4 > -28'sd4228  )
            data_in_d5 = -17'sd2114;
        else if (data_in_d4 > -28'sd8456  )
            data_in_d5 = -17'sd6342;
        else if (data_in_d4 > -28'sd12684 )
            data_in_d5 = -17'sd10570;
        else if (data_in_d4 > -28'sd16912 )
            data_in_d5 = -17'sd14798; 
        else if (data_in_d4 > -28'sd21140 )
            data_in_d5 = -17'sd19026; 
        else if (data_in_d4 > -28'sd25368 )
            data_in_d5 = -17'sd23254; 
        else if (data_in_d4 > -28'sd29596 )
            data_in_d5 = -17'sd27482; 
        else if (data_in_d4 > -28'sd33824 )
            data_in_d5 = -17'sd31710; 
        else if (data_in_d4 > -28'sd38052 )
            data_in_d5 = -17'sd35938; 
        else if (data_in_d4 > -28'sd42280 )
            data_in_d5 = -17'sd40166; 
        else if (data_in_d4 > -28'sd46508 )
            data_in_d5 = -17'sd44394; 
        else if (data_in_d4 > -28'sd50736 )
            data_in_d5 = -17'sd48622; 
        else if (data_in_d4 > -28'sd54964 )
            data_in_d5 = -17'sd52850; 
        else if (data_in_d4 > -28'sd59192 )
            data_in_d5 = -17'sd57078; 
        else if (data_in_d4 > -28'sd63420 )
            data_in_d5 = -17'sd61306;
        else if (data_in_d4 <= -28'sd63420)
            data_in_d5 = -17'sd65536;
        else
            data_in_d5 = 17'sd0;
    end
    always @ (*) begin
        if (!rst_n)
            data_in_d11 = 17'sd0;
        else if (data_in_d10 > 31'sd63420  )
            data_in_d11 = 17'sd65535;  
        else if (data_in_d10 > 31'sd59192  )
            data_in_d11 = 17'sd61306;  
        else if (data_in_d10 > 31'sd54964  )
            data_in_d11 = 17'sd57078;  
        else if (data_in_d10 > 31'sd50736  )
            data_in_d11 = 17'sd52850;  
        else if (data_in_d10 > 31'sd46508  )
            data_in_d11 = 17'sd48622;  
        else if (data_in_d10 > 31'sd42280  )
            data_in_d11 = 17'sd44394;  
        else if (data_in_d10 > 31'sd38052  )
            data_in_d11 = 17'sd40166;  
        else if (data_in_d10 > 31'sd33824  )
            data_in_d11 = 17'sd35938;  
        else if (data_in_d10 > 31'sd29596  )
            data_in_d11 = 17'sd31710;  
        else if (data_in_d10 > 31'sd25368  )
            data_in_d11 = 17'sd27482;  
        else if (data_in_d10 > 31'sd21140  )
            data_in_d11 = 17'sd23254;  
        else if (data_in_d10 > 31'sd16912  )
            data_in_d11 = 17'sd19026;  
        else if (data_in_d10 > 31'sd12684  )
            data_in_d11 = 17'sd14798;
        else if (data_in_d10 > 31'sd8456   )
            data_in_d11 = 17'sd10570;
        else if (data_in_d10 > 31'sd4228   )
            data_in_d11 = 17'sd6342;
        else if (data_in_d10 > 31'sd0      )
            data_in_d11 = 17'sd2114;
        else if (data_in_d10 > -31'sd4228  )
            data_in_d11 = -17'sd2114;  
        else if (data_in_d10 > -31'sd8456  )
            data_in_d11 = -17'sd6342;
        else if (data_in_d10 > -31'sd12684 )
            data_in_d11 = -17'sd10570; 
        else if (data_in_d10 > -31'sd16912 )
            data_in_d11 = -17'sd14798; 
        else if (data_in_d10 > -31'sd21140 )
            data_in_d11 = -17'sd19026; 
        else if (data_in_d10 > -31'sd25368 )
            data_in_d11 = -17'sd23254; 
        else if (data_in_d10 > -31'sd29596 )
            data_in_d11 = -17'sd27482; 
        else if (data_in_d10 > -31'sd33824 )
            data_in_d11 = -17'sd31710; 
        else if (data_in_d10 > -31'sd38052 )
            data_in_d11 = -17'sd35938; 
        else if (data_in_d10 > -31'sd42280 )
            data_in_d11 = -17'sd40166; 
        else if (data_in_d10 > -31'sd46508 )
            data_in_d11 = -17'sd44394; 
        else if (data_in_d10 > -31'sd50736 )
            data_in_d11 = -17'sd48622; 
        else if (data_in_d10 > -31'sd54964 )
            data_in_d11 = -17'sd52850; 
        else if (data_in_d10 > -31'sd59192 )
            data_in_d11 = -17'sd57078; 
        else if (data_in_d10 > -31'sd63420 )
            data_in_d11 = -17'sd61306;
        else if (data_in_d10 <= -31'sd63420)
            data_in_d11 = -17'sd65536;
        else
            data_in_d11 = 17'sd0;
    end
    
endmodule