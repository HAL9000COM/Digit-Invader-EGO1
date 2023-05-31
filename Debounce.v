//6.防抖模块代码Debounce.v

module Debounce(
input main_clk,//2000Hz
input [3:0]sw_pin,
input [4:0]btn_pin,
output [3:0]sw_pin_debounce,
output [4:0]btn_pin_debounce
);

reg [3:0]sw_pin_r1=0;
reg [3:0]sw_pin_r2=0;
reg [3:0]sw_pin_r3=0;

reg [4:0]btn_pin_r1=0;
reg [4:0]btn_pin_r2=0;
reg [4:0]btn_pin_r3=0;

always@(posedge main_clk)
begin
sw_pin_r1<=sw_pin;
sw_pin_r2<=sw_pin_r1;
sw_pin_r3<=sw_pin_r2;
btn_pin_r1<=btn_pin;
btn_pin_r2<=btn_pin_r1;
btn_pin_r3<=btn_pin_r2;
end

assign sw_pin_debounce=sw_pin_r1&sw_pin_r2&sw_pin_r3;
assign btn_pin_debounce=btn_pin_r1&btn_pin_r2&btn_pin_r3;
endmodule

