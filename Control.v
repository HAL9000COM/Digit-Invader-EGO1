//4.主控模块代码Control.v

module Control(
input main_clk,//2000HZ
input [3:0]sw_pin_debounce,
input [4:0]btn_pin_debounce,
input [3:0]rnd_inp,
output [31:0] data,// game number and score
output [3:0] game_d, //the game number on the left
output test,//test display
output game//game mode
);

integer score=32'd0;
reg game_reg=1;//gamemode
integer freq=32'd0;//internal clock
integer rnd=32'd0;

always@(posedge main_clk)
begin//speed based on score
freq<=32'd5000;
if(score<=32'd10&&game_reg==1) 
begin
freq<=32'd4000;
end
if(32'd10<score&&score<=32'd25&&game_reg==1)
begin
freq<=32'd3000;
end
if(32'd25<score&&score<=32'd35&&game_reg==1)
begin
freq<=32'd2000;
end
if(32'd35<score&&score<=32'd45&&game_reg==1)
begin
freq<=32'd1600;
end
if(32'd45<score&&score<=32'd50&&game_reg==1)
begin
freq<=32'd1000;
end
end

integer play_d=32'd0;//the game number on the left
reg [4:0]btn_pin_reg=0;

always@(posedge main_clk)
begin
play_d<=sw_pin_debounce;//left digit
btn_pin_reg<=btn_pin_debounce;
rnd<=rnd_inp;
end

integer data_reg=32'd0;//internal data
integer data_dis_reg=32'd0;//data for display
integer num=32'd0;//data for digit calc
integer i=0;//highest number
integer n=0;//digit number
integer i_reg=0;//highest number for internal calc
integer n_reg=0;//digit number for internal calc
integer loopflag1=32'd0;
reg resetflag=0;
reg minusflag=0;
integer counter=32'd0;//main sequence counter

always@(main_clk)//calc for digit number and highest number
begin
if(resetflag==1) 
begin
n<=0;
n_reg<=0;
end
num<=data_reg;
i_reg<=0;
n_reg<=0;
for(loopflag1=0;loopflag1<10;loopflag1=loopflag1+1)
begin
if(num!=32'd0)
begin
i_reg=num%32'd10;
num=num/32'd10;
n_reg=n_reg+1;
end
if(num==32'd0)
begin
n=n_reg;
i=i_reg;
end
end
end


integer multiple=32'd1;
integer multiplei=32'd1;

always@(posedge main_clk)//lookup table for digit
begin
case(n)
32'd1: multiple<=32'd1;
32'd2: multiple<=32'd10;
32'd3: multiple<=32'd100;
32'd4: multiple<=32'd1000;
32'd5: multiple<=32'd10000;
32'd6: multiple<=32'd100000;
32'd7: multiple<=32'd1000000;
32'd8: multiple<=32'd10000000;
default:multiple<=32'd1;
endcase
if(game_reg==0) multiple<=32'd1;
multiplei=multiple*i;
end


always@(posedge main_clk)//main sequence
begin
if(resetflag==1)//reset
begin
data_reg<=32'd0;
score<=32'd0;
counter<=32'd0;
end
if(resetflag==0&&minusflag==1&&play_d==i&&game_reg==1&&counter%10==32'd0)//hi-digit delete & wait for n and i to reflesh
begin
data_reg<=data_reg-multiplei;
score<=score+32'd1;
end
if(resetflag==0&&counter==freq&&game_reg==1)//internal clock
begin
data_reg=data_reg*32'd10;
data_reg=data_reg+rnd;
counter<=32'd0;
end
if(game_reg==0) data_reg<=32'd0;//game over reset
counter<=counter+32'd1;//internal clock
if(counter>32'd5000) counter<=32'd0;
end


//game mode
always@(posedge main_clk)
begin
if(n>32'd6) game_reg<=0;
if(resetflag==1) game_reg<=1;
end

always@(main_clk)//ok-button
begin
if(btn_pin_reg[2]==1)
begin
minusflag<=1;
end
else
begin
minusflag<=0;
end
end

always@(main_clk)//reset
begin
if(btn_pin_reg[1]==1)
begin
resetflag<=1;
end
else
begin
resetflag<=0;
end
end


reg test_reg=0;//test display
always@(main_clk)
begin
if (btn_pin_reg[0]==1)
begin
test_reg<=1;
end
else
begin
test_reg<=0;
end
end

always@(game_reg)//display score when game ends
begin
if(game_reg==1) data_dis_reg<=data_reg;
if(game_reg==0) data_dis_reg<=score;
end

assign game=game_reg;
assign data=data_dis_reg;
assign test=test_reg;
assign game_d=play_d;
endmodule