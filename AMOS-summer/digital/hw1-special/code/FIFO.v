module FIFO #(parameter WIDTH = 32, parameter DEPTH = 10)(
	input clk,
	input reset,
	input enable_out, // flag that allows data popping out of the queue
	input enable_in, // flag that allows data pushing into the queue
	input [WIDTH-1:0] data,
	output reg [WIDTH-1:0] FIFO_out,
	output reg empty // empty flag to control the adder
);
reg [WIDTH-1:0] queue [0:DEPTH-1]; //circular queue
reg [7:0] head;
reg [7:0] tail;
reg full;

// pop out the queue if enable is on until the queue is empty
always@(posedge clk or negedge reset)begin
		if(!reset)begin
			head <= 0;
			full <= 0;
			FIFO_out <= 0;
		end
		else begin
			if (!empty && enable_out)begin
				FIFO_out <= queue[head];
				head <= (head + 1) % DEPTH;
			end
			else begin
				FIFO_out <= FIFO_out;
				head <= head;
			end
			// check and update the "full" flag
			full <= ( (tail + 1) % DEPTH == head);
		end
end

// push data into the queue 
always@(negedge clk or negedge reset)begin
	if(!reset)begin
		tail <= 0;
		empty <= 1;
		queue[0] <= 0;
	end
	else begin
		if(!full && enable_in)begin
			queue[tail] <= data;
			tail <= (tail + 1) % DEPTH;
		end
		else begin
			queue[tail] <= queue[tail];
			tail <= tail;
		end
		// check and update the "empty" flag
		empty <= (head == tail);
	end
end

endmodule
