module PC_reg(
    input clk,
    input rst,
    input [31:0] pc_next,
    output reg [31:0] pc_current
    );
always @(posedge clk or negedge rst) begin
// asyn active low rst
    if (! rst) begin
        pc_current <= 32'b0;
    end
    
    else begin
    pc_current <= pc_next;
    end
end
endmodule