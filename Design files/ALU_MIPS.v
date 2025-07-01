module ALU_MIPS (
    input  [31:0] src_A,
    input  [31:0] src_B,
    input  [3:0]  sel,
    output        zero,
    output reg [31:0] alu_result
);

always @(*) begin
    case (sel)
        4'b0000: alu_result = src_A & src_B;             // AND
        4'b0001: alu_result = src_A | src_B;             // OR
        4'b0011: alu_result = src_A ^ src_B;             // xOR
        4'b1001: alu_result = (~src_A) | (~src_B);       // nOR
        4'b0010: alu_result = src_A + src_B;             // ADD
        4'b0110: alu_result = src_A - src_B;             // SUB
        4'b0111: alu_result = (src_A < src_B) ? 32'b1 : 32'b0; // SLT (Set on Less Than)
        default: alu_result = 32'b0;
    endcase
end
//assign zero = (alu_result == 32'b0);
assign zero = ~|alu_result;  // Zero flag

endmodule