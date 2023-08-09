
`timescale 1ns/1ps
module tb_DCFIFO (); /* this is automatically generated */

	reg rst_n;
	reg [1:0] cnt_4;

	//FIFO写端
	reg        wrclk;
	reg  [7:0] data;
	reg        wrreq;
	wire        wrempty;
	wire        wrfull;

	reg wrfull_reg0;
	reg wrfull_reg1;

	wire  [7:0] wrusedw;

	//FIFO读端
	reg        rdclk;
	reg        rdreq;
	wire [15:0] q;
	wire        rdempty;
	wire        rdfull;
	wire  [6:0] rdusedw;

	//初始化时钟、复位
	initial begin
		wrclk = 1'd0;
		rdclk = 1'd0;
		rst_n = 1'd0;
		#14
		rst_n = 1'd1;
	end

	//wrclk：模拟FIFO的写时钟
	always #10 wrclk <= ~wrclk;

	//rdclk：模拟FIFO的读时钟
	always #20 rdclk <= ~rdclk;

	always @(posedge wrclk or negedge rst_n) begin
		if(~rst_n) begin
			cnt_4 <= 2'd0;
		end else begin
			cnt_4 <= cnt_4 + 2'd1;
		end
	end

	always @(posedge wrclk or negedge rst_n) begin
		if(~rst_n) begin
			wrreq <= 1'd0;
		end else if(cnt_4 == 2'd3 && rdreq == 1'd0) begin
			wrreq <= 1'd1;
		end else begin
			wrreq <= 1'd0;
		end
	end

	always @(posedge wrclk or negedge rst_n) begin
		if(~rst_n) begin
			data <= 8'd0;
		end else if(wrreq) begin
			data <= data + 8'd1;
		end else begin
			data <= data;
		end
	end

	always @(posedge rdclk or negedge rst_n) begin
		if(~rst_n) begin
			wrfull_reg0 <= 1'b0;            
			wrfull_reg1 <= 1'b0; 
		end else begin
			wrfull_reg0 <= wrfull;
			wrfull_reg1 <= wrfull_reg0;
		end
	end

	always @(posedge rdclk or negedge rst_n) begin
		if(~rst_n) begin
			rdreq <= 1'd0;
		end else if(wrfull_reg1 == 1'd1) begin
			rdreq <= 1'd1;
		end else if(rdempty == 1'd1) begin
			rdreq <= 1'd0;
		end else begin
			rdreq <= rdreq;
		end
	end



	DCFIFO inst_DCFIFO
		(
			.wrclk   (wrclk),
			.data    (data),
			.wrreq   (wrreq),
			.wrempty (wrempty),
			.wrfull  (wrfull),
			.wrusedw (wrusedw),
			.rdclk   (rdclk),
			.rdreq   (rdreq),
			.q       (q),
			.rdempty (rdempty),
			.rdfull  (rdfull),
			.rdusedw (rdusedw)
		);

	
endmodule
