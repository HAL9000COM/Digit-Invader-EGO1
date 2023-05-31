//7.时钟生成器模块代码Clock.v

module Clock
(input sys_clk_in,
output dis_clk,//50Hz
output main_clk//2000Hz
);

reg [31:0]clk_cnt1=0;
reg clk_2000Hz=0;

always @(posedge sys_clk_in)
if(clk_cnt1==32'd25000)
begin clk_cnt1 <= 1'b0; clk_2000Hz <= ~clk_2000Hz;end else
clk_cnt1 <= clk_cnt1 + 1'b1;

reg [31:0]clk_cnt2=0;
reg clk_50Hz=0;

always @(posedge sys_clk_in)
if(clk_cnt2==32'd125000)
begin clk_cnt2 <= 1'b0; clk_50Hz <= ~clk_50Hz;end else
clk_cnt2 <= clk_cnt2 + 1'b1;

assign main_clk=clk_2000Hz;
assign dis_clk=clk_50Hz;

endmodule