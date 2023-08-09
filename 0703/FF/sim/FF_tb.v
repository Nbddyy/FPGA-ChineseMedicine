`timescale 1ns/1ps

module FF_tb ();

reg D;
reg CLK;
reg RST;
wire Q;
wire Q_NOT_GATE;

initial begin
	D <= 0;
	CLK <= 0;
	RST <= 0;
	#10
	RST <= 1;
	#200
	$stop;
end

always #10 CLK <= ~CLK;
always #34 D <= {$random} % 2;


FF FF1 (
	.D(D),
	.CLK(CLK),
	.RST(RST),
	.Q(Q),
	.Q_NOT_GATE(Q_NOT_GATE)
);

endmodule