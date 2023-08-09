`timescale 1ns/1ns

module tb_IRIG_B ();

	reg clk;
	reg rst_n;
	reg [31:0] ex_sig_B_code;

	initial begin
		clk <= 1'd0;
		rst_n <= 1'd0;
		#14
		rst_n <= 1'd1;
		ex_sig_B_code <= "P";
		#10_000_000
		ex_sig_B_code <= "P";
		#10_000_000
		ex_sig_B_code <= 48;
		#10_000_000
		ex_sig_B_code <= 48;
		#10_000_000
		ex_sig_B_code <= 48;
		#10_000_000
		ex_sig_B_code <= 49;
		#10_000_000
		ex_sig_B_code <= 48;
		#10_000_000
		ex_sig_B_code <= 48;
		#10_000_000
		ex_sig_B_code <= 48;
		#10_000_000
		ex_sig_B_code <= 48;
		#10_000_000
		ex_sig_B_code <= "P";
		#10_000_000
		ex_sig_B_code <= 48;
		#10_000_000
		ex_sig_B_code <= 48;
		#10_000_000
		ex_sig_B_code <= 48;
		#10_000_000
		ex_sig_B_code <= 49;
		#10_000_000
		ex_sig_B_code <= 48;
		#10_000_000
		ex_sig_B_code <= 48;
		#10_000_000
		ex_sig_B_code <= 48;
		#10_000_000
		ex_sig_B_code <= 49;
		#10_000_000
		ex_sig_B_code <= 48;
		#10_000_000
		ex_sig_B_code <= "P";
		#10_000_000
		ex_sig_B_code <= 49;
		#10_000_000
		ex_sig_B_code <= 48;
		#10_000_000
		ex_sig_B_code <= 48;
		#10_000_000
		ex_sig_B_code <= 48;
		#10_000_000
		ex_sig_B_code <= 48;
		#10_000_000
		ex_sig_B_code <= 48;
		#10_000_000
		ex_sig_B_code <= 48;
		#10_000_000
		ex_sig_B_code <= 48;
		#10_000_000
		ex_sig_B_code <= 48;
		#10_000_000
		ex_sig_B_code <= "P";
		#10_000_000
		ex_sig_B_code <= 49;
		#10_000_000
		ex_sig_B_code <= 48;
		#10_000_000
		ex_sig_B_code <= 48;
		#10_000_000
		ex_sig_B_code <= 48;
		#10_000_000
		ex_sig_B_code <= 48;
		#10_000_000
		ex_sig_B_code <= 49;
		#10_000_000
		ex_sig_B_code <= 48;
		#10_000_000
		ex_sig_B_code <= 49;
		#10_000_000
		ex_sig_B_code <= 48;
		#10_000_000
		ex_sig_B_code <= "P";


		#10_000_000
		ex_sig_B_code <= 48;
		#10_000_000
		ex_sig_B_code <= 49;
		#10_000_000
		ex_sig_B_code <= 48;
		#10_000_000
		ex_sig_B_code <= 48;
		#10_000_000
		ex_sig_B_code <= 48;
		#10_000_000
		ex_sig_B_code <= 48;
		#10_000_000
		ex_sig_B_code <= 48;
		#10_000_000
		ex_sig_B_code <= 48;
		#10_000_000
		ex_sig_B_code <= 48;
		#10_000_000
		ex_sig_B_code <= "P";
		#10_000_000
		ex_sig_B_code <= 49;
		#10_000_000
		ex_sig_B_code <= 48;
		#10_000_000
		ex_sig_B_code <= 48;
		#10_000_000
		ex_sig_B_code <= 48;
		#10_000_000
		ex_sig_B_code <= 48;
		#10_000_000
		ex_sig_B_code <= 48;
		#10_000_000
		ex_sig_B_code <= 49;
		#10_000_000
		ex_sig_B_code <= 48;
		#10_000_000
		ex_sig_B_code <= 48;
		#10_000_000
		ex_sig_B_code <= "P";
		#10_000_000
		ex_sig_B_code <= 48;
		#10_000_000
		ex_sig_B_code <= 48;
		#10_000_000
		ex_sig_B_code <= 48;
		#10_000_000
		ex_sig_B_code <= 48;
		#10_000_000
		ex_sig_B_code <= 48;
		#10_000_000
		ex_sig_B_code <= 48;
		#10_000_000
		ex_sig_B_code <= 48;
		#10_000_000
		ex_sig_B_code <= 48;
		#10_000_000
		ex_sig_B_code <= 48;
		#10_000_000
		ex_sig_B_code <= "P";
		#10_000_000
		ex_sig_B_code <= 48;
		#10_000_000
		ex_sig_B_code <= 48;
		#10_000_000
		ex_sig_B_code <= 48;
		#10_000_000
		ex_sig_B_code <= 48;
		#10_000_000
		ex_sig_B_code <= 48;
		#10_000_000
		ex_sig_B_code <= 49;
		#10_000_000
		ex_sig_B_code <= 48;
		#10_000_000
		ex_sig_B_code <= 48;
		#10_000_000
		ex_sig_B_code <= 48;
		#10_000_000
		ex_sig_B_code <= "P";


		#10_000_000
		ex_sig_B_code <= 48;
		#10_000_000
		ex_sig_B_code <= 48;
		#10_000_000
		ex_sig_B_code <= 48;
		#10_000_000
		ex_sig_B_code <= 49;
		#10_000_000
		ex_sig_B_code <= 49;
		#10_000_000
		ex_sig_B_code <= 48;
		#10_000_000
		ex_sig_B_code <= 49;
		#10_000_000
		ex_sig_B_code <= 48;
		#10_000_000
		ex_sig_B_code <= 49;
		#10_000_000
		ex_sig_B_code <= "P";
		#10_000_000
		ex_sig_B_code <= 48;
		#10_000_000
		ex_sig_B_code <= 48;
		#10_000_000
		ex_sig_B_code <= 49;
		#10_000_000
		ex_sig_B_code <= 49;
		#10_000_000
		ex_sig_B_code <= 48;
		#10_000_000
		ex_sig_B_code <= 48;
		#10_000_000
		ex_sig_B_code <= 48;
		#10_000_000
		ex_sig_B_code <= 48;
		#10_000_000
		ex_sig_B_code <= 48;
		#10_000_000
		ex_sig_B_code <= "P";

		#10_000_000
		ex_sig_B_code <= 95;
		

	end

	always #4 clk <= ~clk;

	wire second_units;
	wire second_tens;
	wire minute_units;
	wire minute_tens;
	wire hour_units;
	wire hour_tens;
	wire day_units;
	wire day_tens;
	wire day_hunds;
	wire year_units;
	wire year_tens;

	IRIG_B IRIG_B_1 (
		.clk(clk),
		.rst_n(rst_n),
		.ex_sig_B_code(ex_sig_B_code),
		.second_units_output(second_units_output),
		.second_tens_output(second_tens_output),
		.minute_units_output(minute_units_output),
		.minute_tens_output(minute_tens_output),
		.hour_units_output(hour_units_output),
		.hour_tens_output(hour_tens_output),
		.day_units_output(day_units_output),
		.day_tens_output(day_tens_output),
		.day_hunds_output(day_hunds_output),
		.year_units_output(year_units_output),
		.year_tens_output(year_tens_output)
);

endmodule