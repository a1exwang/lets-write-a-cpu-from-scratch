module keyboard (
    input datain, clkin,
    input fclk, rst,
<<<<<<< HEAD
    output reg [7:0] scancode
=======
	 input rdn,
	 output data_ready,
    output reg [7:0] scancode
>>>>>>> Finish nothing.
);

reg [4:0] state;
reg data, clk1, clk2;
reg [7:0] code;
<<<<<<< HEAD
=======
reg dataready;
reg p2, p1;
>>>>>>> Finish nothing.
wire clk, odd;

localparam  DELAY   = 5'b00000,
            START   = 5'b00001,
            D0      = 5'b00010,
            D1      = 5'b00011,
            D2      = 5'b00100,
            D3      = 5'b00101,
            D4      = 5'b00110,
            D5      = 5'b00111,
            D6      = 5'b01000,
            D7      = 5'b01001,
            PARITY  = 5'b01010,
            STOP    = 5'b01011,
            FINISH  = 5'b01100;

initial begin
	state = 0;
<<<<<<< HEAD
=======
	dataready = 0;
	p1 = 0;
	p2 = 0;
>>>>>>> Finish nothing.
end

assign clk = (~clk1) & clk2;
assign odd = code[0] ^ code[1] ^ code[2] ^ code[3]
            ^ code[4] ^ code[5] ^ code[6] ^ code[7]; 

always @(posedge fclk) begin
    clk1 <= clkin;
    clk2 <= clk1;
    data <= datain;
end

always @(posedge fclk or negedge rst) begin
    if (rst == 0) begin
<<<<<<< HEAD
        // reset
=======
        // reset
		  p2 <= 0;
		  dataready <= 0;
>>>>>>> Finish nothing.
        state   <= DELAY;
        code    <= 8'b00000000;
    end
    else begin
<<<<<<< HEAD
=======
	 //when rdn is enabled (means the data is read over)
	 //we can set the dataready back to zero
		  if (p2 != p1) begin
				 p2 <= p1;
				 dataready <= 0;
		  end
>>>>>>> Finish nothing.
        case (state)
        DELAY:
            state <= START;
        START:
		  begin
            if (clk) begin
                if (!datain) begin
                    state <= D0;
                end else begin
                    state <= DELAY;
                end
            end
		  end
        D0:
            if (clk) begin
                code[0] <= data;
                state   <= D1;
            end
        D1:
            if (clk) begin
                code[1] <= data;
                state   <= D2;
            end
        D2:
            if (clk) begin
                code[2] <= data;
                state   <= D3;
            end
        D3:
            if (clk) begin
                code[3] <= data;
                state   <= D4;
            end
        D4:
            if (clk) begin
                code[4] <= data;
                state   <= D5;
            end
        D5:
            if (clk) begin
                code[5] <= data;
                state   <= D6;
            end
        D6:
            if (clk) begin
                code[6] <= data;
                state   <= D7;
            end
        D7:
            if (clk) begin
                code[7] <= data;
                state   <= PARITY;
            end 
        PARITY:
            if (clk) begin
                if (datain ^ odd == 1) begin
                    state <= STOP;
                end else begin
                    state <= DELAY;
                end
            end
        STOP:
            if (clk) begin
                if (data) begin
                    state <= FINISH;
                end else begin
                    state <= DELAY;
                end
            end
        FINISH:
            begin
                state <= DELAY;
                scancode <= code;
            end
        endcase
    end
end

always @(posedge rdn, negedge rst)  begin
	if (rst == 0)
		p1 <= 0;
	else begin
		p1 <= ~p1;
	end
end

endmodule
