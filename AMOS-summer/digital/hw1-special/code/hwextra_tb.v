module hwextra_tb #(parameter WIDTH = 32)();

// Corresponding ports:
reg clk;
reg reset;
reg FIFO_en;
reg FIFO_w_en;
reg sort_en;
reg add_en;
reg [WIDTH-1:0] data;
wire [WIDTH-1:0] FIFO_out;
wire FIFO_empty;
wire [WIDTH-1:0] odd;
wire [WIDTH-1:0] even;
wire [WIDTH-1:0] sum;

// Top module import:
hwextra p1(clk, reset, FIFO_en, FIFO_w_en, sort_en, add_en, data, FIFO_out, FIFO_empty, odd, even, sum);

always begin
	#5 clk = ~clk;
end

// Variables for testbench file reading:
integer file_desc; // file descriptor
integer file_stat; // value = 1 -> open; value = -1 -> closed;
reg file_r_en; // enable text file reading

always@(posedge clk)begin
	// read the data in test_dec.txt line by line
	if(file_desc) begin // check if the file is opened successfully
		if(file_r_en)begin
			file_stat <= $fscanf(file_desc, "%d\n", data);
		end
		if($feof(file_desc))begin
			$fclose(file_desc);
		end
		if(file_stat==-1)begin
			FIFO_w_en <= 0; 
			// Stops data input for FIFO module on the next clock,
			// when the file is closed.
		end
	end
end

initial begin
	clk = 0;
	reset = 1;
	FIFO_en = 0;
	FIFO_w_en = 0;
	sort_en = 0;
	add_en = 0;
	file_r_en = 0;
	// Initialization goes above :)
	#15
	reset = 0;
	// "test_dec.txt" contains randomly generated numbers
	file_desc = $fopen("D:/Documents/Quartus/hwextra/test_dec.txt", "r");
	// Ast: idk why it only eats absolute directory
	// Ast: could be my quartus living on C:/
	#10
	reset = 1;
	file_r_en = 1;
	FIFO_w_en = 1;
	#10
	FIFO_en = 1;
	sort_en = 1;
	add_en = 1;
	#50
	// FIFO module still pushes the data in buffer,
	// but stops popping data out here (very cool).
	FIFO_en = 0;
	#5
	FIFO_en = 1;
	#200
	$stop;
end

endmodule
