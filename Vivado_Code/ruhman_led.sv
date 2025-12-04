module ruhman_led
   #(parameter W = 16)  // width of output port
   (
    input  logic clk,
    input  logic reset,
    // slot interface
    input  logic cs,
    input  logic read,
    input  logic write,
    input  logic [4:0] addr,
    input  logic [31:0] wr_data,
    output logic [31:0] rd_data,
    // external port    
    output logic [W-1:0] dout
   );
   
// everything above taken from chu_gpo but changed the width parameter to match what I want
logic [15:0] interval_reg [0:15];
logic [15:0] interval_reg_new [0:15];
logic [15:0] led; 

always_ff @(posedge(clk), posedge(reset)) begin
    if (reset) begin
        for (int i = 0; i < 16; i++)
            interval_reg[i] <= 16'd0;
    end
    
    
    // Check
    else if (cs && write) begin
        for (int i = 0; i < 16; i++)
            interval_reg[i] <= interval_reg_new[i];
    end
end


always_comb begin
    for (int i = 0; i < 16; i++)
        interval_reg_new[i] = interval_reg[i];
    case (addr)
        0: interval_reg_new[0] = wr_data[15:0];
        1: interval_reg_new[1] = wr_data[15:0];
        2: interval_reg_new[2] = wr_data[15:0];
        3: interval_reg_new[3] = wr_data[15:0];
        4: interval_reg_new[4] = wr_data[15:0];
        5: interval_reg_new[5] = wr_data[15:0];
        6: interval_reg_new[6] = wr_data[15:0];
        7: interval_reg_new[7] = wr_data[15:0];
        8: interval_reg_new[8] = wr_data[15:0];
        9: interval_reg_new[9] = wr_data[15:0];
        10: interval_reg_new[10] = wr_data[15:0];
        11: interval_reg_new[11] = wr_data[15:0];
        12: interval_reg_new[12] = wr_data[15:0];
        13: interval_reg_new[13] = wr_data[15:0];
        14: interval_reg_new[14] = wr_data[15:0];
        15: interval_reg_new[15] = wr_data[15:0];
        default: interval_reg_new[0] = wr_data[15:0];
    endcase
end

generate
   genvar i;
   for (i = 0; i < 16; i = i + 1) begin : gen_intervals
        interval led_inst (
            .led_out(led[i]),
            .delay_ms(interval_reg[i]),
            .clk(clk),
            .reset(reset)
        );
    end
endgenerate

assign rd_data = 0;
assign dout = led;

endmodule
