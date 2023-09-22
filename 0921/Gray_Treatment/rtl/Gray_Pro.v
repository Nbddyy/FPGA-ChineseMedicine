module Gray_Pro (
	input [15:0] rgb,
	output [15:0] rgb_out
);

	// assign red   = {rgb[15:11],rgb[15:11],1'b0,rgb[15:11]}; 
	// assign green = {rgb[10:6],rgb[10:5],rgb[10:6]};        
	assign rgb_out  = {rgb[4:0],rgb[4:0],1'b0,rgb[4:0]}; 

	// assign rgb_out = rgb;

endmodule