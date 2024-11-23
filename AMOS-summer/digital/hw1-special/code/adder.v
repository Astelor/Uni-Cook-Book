module adder #(parameter WIDTH = 32)(
	input clk,
	input reset,
	input add_en,
	input [WIDTH-1:0] num,
	input FIFO_empty,
	input FIFO_en,	// adder is tied with FIFO module
	output reg [WIDTH-1:0] sum
);

always@(posedge clk or negedge reset)begin
	if(!reset)begin
		sum <= 0;
	end
	else begin
		if(add_en && !FIFO_empty && FIFO_en)begin
			sum <= sum + num;
		end
		else begin
			sum <= sum;
		end
	end
end

endmodule
