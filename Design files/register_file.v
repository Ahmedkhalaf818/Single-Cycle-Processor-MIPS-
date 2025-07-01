module register_file(
    input clk,wr_en3,
    input [4:0] rd_addr1,
    input [4:0] rd_addr2,
    input [4:0] wr_addr3,
    input [31:0] wr_data3,
    output [31:0] rd_data1,
    output [31:0] rd_data2
    //output s0_reg
    );
    reg [31:0] rg_file [0:31];
    assign rd_data1 = rg_file[rd_addr1];
    assign rd_data2 = rg_file[rd_addr2];
    //assign s0_reg = rg_file[16][3:0];
always @(posedge clk) begin
    if (wr_en3) begin
        rg_file[wr_addr3] <= wr_data3;
    end
end
endmodule