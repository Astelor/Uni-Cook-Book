module sort #(parameter WIDTH = 32)(
	input clk,
	input reset,
	input enable, // sort enable
	input [WIDTH-1:0] num,
	output reg[WIDTH-1:0] odd,
	output reg[WIDTH-1:0] even
);

always@(posedge clk or negedge reset)begin
	if(!reset)begin
		odd <= 0;
		even <= 0;
	end
	else if(enable)begin
		if(num & 1)begin
			odd <= num;
		end
		else begin
			even <= num;
		end
	end
	else begin
		odd <= odd;
		even <= even;
	end
end

endmodule
