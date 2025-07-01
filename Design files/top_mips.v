module top_mips(
    input clk,
    input rst,
    output wire [3:0]leds
    );
parameter depth = 256; //depth of the memory
parameter width = 8;
 wire [31:0] instr;//used
 wire [31:0] readdata1;//used
 wire [31:0] readdata2;//used
 wire [31:0] readdata3;//used
 wire [31:0] sign_imm;//used
 wire [31:0] pc,pc_plus4,pc_branch,pc_next;//used
 wire [31:0] src_b,alu_result; //used
 wire zero;//used
 wire pcsrc;//used
 wire [4:0] write_reg;//used
 wire [31:0] mem_mux_result;//used
 wire [31:0] pcjump;//used
 wire [31:0] pc_plus4_mux1_result;//used
 //control wires
 wire memtoreg; //used
 wire memwrite;//used
 wire branch;//used
 wire [3:0] alucontrol;//used
 wire alusrc;//used
 wire regdst;//used
 wire regwrite;//used
 wire jump;//used
 //instantiation
   PC_reg pc_reg1(
       .clk(clk),//done
       .rst(rst),//done
       .pc_next(pc_next),//done
       .pc_current(pc)//done
       );//done
   sign_extend sign_extend1(
       .instr_imm(instr[15:0]),//done
       .sign_imm(sign_imm) //done
       );//done
   ram_memory #(.depth(depth),.width(width)) ram_instr(
       .clk(clk),//done
       .wr_en(1'b0), //done
       .addr(pc), //done
       .wr_data(32'h05), //done
       .rd_data(instr) //done
       );//done
   ram_memory #(.depth(depth),.width(width)) ram_data(
           .clk(clk), //done
           .wr_en(memwrite),//done
           .addr(alu_result), //done
           .wr_data(readdata2), //done
           .rd_data(readdata3) //done
           );//done
    ctrl_unit control_unit (
    .funct(instr[5:0]),//done
    .opcode(instr[31:26]),//done
    .mem_to_reg(memtoreg),//done
    .mem_write(memwrite),//done
    .branch(branch),//done
    .alu_control(alucontrol),//done
    .alu_src(alusrc), //done
    .reg_dst(regdst),//done
    .reg_write(regwrite),//done
    .jump(jump)//done
    );  //done
    ALU_MIPS ALu1(
    .src_A(readdata1), //done
    .src_B(src_b), //done
    .sel(alucontrol),//done
    .zero(zero),//done
    .alu_result(alu_result) //done
    ); //done
    register_file rg_file1(
    .clk(clk),//done
    .wr_en3(regwrite),//done
    .rd_addr1(instr[25:21]),//done
    .rd_addr2(instr[20:16]),//done
    .wr_addr3(write_reg), //done
    .wr_data3(mem_mux_result),//done
    .rd_data1(readdata1),//done
    .rd_data2(readdata2) //done
    //output s0_reg
        );  //done
 // assignments
 assign pc_plus4 = pc+4;
 assign pc_branch = pc_plus4+(sign_imm << 2);
 assign pcsrc = zero & branch ;
 assign src_b=alusrc?sign_imm:readdata2;
 assign mem_mux_result=memtoreg?readdata3:alu_result;
 assign write_reg=regdst?instr[15:11]:instr[20:16];
 assign pcjump={pc_plus4[31:28],{instr[25:0] << 2}};
 assign pc_plus4_mux1_result=pcsrc?pc_branch:pc_plus4;
 assign pc_next=jump?pcjump:pc_plus4_mux1_result;
 assign leds=rg_file1.rg_file[16][3:0];
endmodule

