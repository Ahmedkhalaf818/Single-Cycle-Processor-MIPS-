module sign_extend(
    input [15:0] instr_imm,
    output [31:0] sign_imm
    );
    assign sign_imm ={{16{instr_imm[15]}},instr_imm};
endmodule

