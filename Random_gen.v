//5.随机数生成器模块代码Random_gen.v

module Random_gen(
output [3:0]rnd,
input clk,
input [4:0]btn_pin_debounce
);

reg[63:0] out=0;
wire feedback;

assign feedback = ~(out[63] ^ out[62] ^ out[60] ^ out[59]);

always @(posedge clk, posedge btn_pin_debounce[1])
begin
if (btn_pin_debounce[1]==1)
out <= 64'b0;
else
out <= {out[62:0],feedback};
end


reg [3:0]dec_reg;
reg [3:0]dec;
always@(*)
begin
dec_reg<=out;
if(dec_reg>4'd0&&dec_reg<=4'd9) dec<=dec_reg;
end
 
assign rnd = dec;
 
endmodule