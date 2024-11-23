module hwextra #(parameter WIDTH = 32)(
	input clk,
	input reset,
	input FIFO_en, // flag that data output
	input FIFO_w_en, // flag that controls data input
	input sort_en,
	input add_en,
	input [WIDTH-1:0] data,
	output wire [WIDTH-1:0] FIFO_out,
	output wire FIFO_empty,
	output wire [WIDTH-1:0] odd,
	output wire [WIDTH-1:0] even,
	output wire [WIDTH-1:0] sum
);

FIFO n1(clk, reset, FIFO_en, FIFO_w_en, data, FIFO_out, FIFO_empty);
sort n2(clk, reset, sort_en, FIFO_out, odd, even);
adder n3(clk, reset, add_en, FIFO_out, FIFO_empty, FIFO_en, sum);

endmodule
