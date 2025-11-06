module interval(
    input  logic clk,
    input  logic reset,
    input  logic [15:0] delay_ms,
    output logic led_out
);

//simple counter as shown in class
    logic [31:0] count;
    logic [31:0] ncount;
    logic [15:0] ms_count;
    logic led;



// Increment count every clock cycle
// Roll over every 100,000 cycles to form 1 ms tick
// Increments our ms_count each ms tick
// Toggle LED when our count reaches the delay

    always_ff @(posedge(clk), posedge(reset)) begin
        if (reset) begin
            count <= 0;
            ms_count <= 0;
            led <= 0;
        end 
        else begin
        
            if (count >= 99_999) begin 
                count <= 0;
                ms_count <= ms_count + 1;
                
                // Toggle LED and reset ms counter when target delay is reached
                if (delay_ms != 0 && ms_count >= delay_ms) begin
                    ms_count <= 0;
                    led <= ~led;
                end
            end
            else count <= ncount;
        end
    end
    
assign ncount = count + 1;
assign led_out = led;    

endmodule
