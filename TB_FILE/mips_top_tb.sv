module mips_top_tb();
reg clk;
reg rst;
wire [3:0]leds;
top_mips Dut (
    .clk(clk),
    .rst(rst),
    .leds(leds)
);

initial begin
clk=0;
forever #5 clk=!clk;
end
initial begin
 $readmemh("test1.mem",Dut.ram_instr.mem);
 $readmemh("test1.mem",Dut.ram_data.mem);
 $readmemh("rg_test1.mem",Dut.rg_file1.rg_file);
end
initial begin
    rst =0;
    repeat(2) @(negedge clk);
    rst=1;
    @(negedge clk);
end
endmodule