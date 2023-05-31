//3.数码管驱动模块代码ssdisplay.v

module ssdisplay
(
input clk_lo_freq, //changeable display freq
input [31:0] data,// game number and score
input [3:0] game_d, //the left game number
input test,//test display
input game,//game mode
output [7:0] seg_data_0_pin,//tube
output [7:0] seg_data_1_pin,
output [7:0] seg_cs_pin//digit
);


reg [3:0]dig_ctrl1=4'b0001;//digit control

always @(posedge clk_lo_freq)
dig_ctrl1<={dig_ctrl1[2:0],dig_ctrl1[3]};


reg [1:0]n1=0; //tube number 

always @(dig_ctrl1)
case(dig_ctrl1)
4'b0001:n1<=0;
4'b0010:n1<=1;
4'b0100:n1<=2;
5'b1000:n1<=3;
default:n1<=0;
endcase

reg [3:0] data_d1[3:0];
reg [31:0] data_reg1;

always@(n1)
begin
data_reg1=data;
if(game==1)//in game mode
begin
data_reg1=data_reg1/32'd10000;
data_d1[3]=data_reg1%32'd10;
data_reg1=data_reg1/32'd10;
data_d1[2]=data_reg1%32'd10;
data_d1[1]=32'd1;
data_d1[0]=game_d;
end
else//display score
begin
data_reg1=data_reg1/32'd10000;
data_d1[3]=data_reg1%32'd10;
data_reg1=data_reg1/32'd10;
data_d1[2]=data_reg1%32'd10;
data_reg1=data_reg1/32'd10;
data_d1[1]=data_reg1%32'd10;
data_reg1=data_reg1/32'd10;
data_d1[0]=data_reg1%32'd10;
end
end

reg [7:0] out1;

always @(n1)
begin
//data_dis per tube
case(data_d1[n1])
0:out1=8'b00111111;
1:out1=8'b00000110;
2:out1=8'b01011011;
3:out1=8'b01001111;
4:out1=8'b01100110;
5:out1=8'b01101101;
6:out1=8'b01111101;
7:out1=8'b00000111;
8:out1=8'b01111111;
9:out1=8'b01101111;
4'b1111:out1=8'b00000000;//clear display
default:out1=8'b00000000;
endcase
if(game==1)//in game mode
begin
if(data_d1[n1]==0) out1=8'b00000000;//don't display 0 in game mode
if(n1==1) out1=8'b01001001;//game symbol
end
if(test==1) out1=8'b11111111; // test control
end
//left 4 digit

reg [31:0] data_reg2;
reg [3:0] data_d2[3:0];

always@(n1)
begin
data_reg2<=data;
data_d2[3]=data_reg2%32'd10;
data_reg2=data_reg2/32'd10;
data_d2[2]=data_reg2%32'd10;
data_reg2=data_reg2/32'd10;
data_d2[1]=data_reg2%32'd10;
data_reg2=data_reg2/32'd10;
data_d2[0]=data_reg2%32'd10;
end

reg [7:0] out2;

always @(n1)
begin
//data_dis per tube
case(data_d2[n1])
0:out2=8'b00111111;
1:out2=8'b00000110;
2:out2=8'b01011011;
3:out2=8'b01001111;
4:out2=8'b01100110;
5:out2=8'b01101101;
6:out2=8'b01111101;
7:out2=8'b00000111;
8:out2=8'b01111111;
9:out2=8'b01101111;
4'b1111:out2=8'b00000000;//clear display
default:out2=8'b00000000;
endcase
if(game==1&&data_d2[n1]==0) out2=8'b00000000;//don't display 0 in game mode
if(test==1) out2=8'b11111111; // test control
end
//right 4 digit

assign seg_data_0_pin=out1;
assign seg_data_1_pin=out2;

assign seg_cs_pin[0]=dig_ctrl1[0];
assign seg_cs_pin[1]=dig_ctrl1[1];
assign seg_cs_pin[2]=dig_ctrl1[2];
assign seg_cs_pin[3]=dig_ctrl1[3];

assign seg_cs_pin[4]=dig_ctrl1[0];
assign seg_cs_pin[5]=dig_ctrl1[1];
assign seg_cs_pin[6]=dig_ctrl1[2];
assign seg_cs_pin[7]=dig_ctrl1[3];

endmodule