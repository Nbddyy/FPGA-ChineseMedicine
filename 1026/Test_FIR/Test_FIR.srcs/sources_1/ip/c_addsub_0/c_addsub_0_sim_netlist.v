// Copyright 1986-2019 Xilinx, Inc. All Rights Reserved.
// --------------------------------------------------------------------------------
// Tool Version: Vivado v.2019.1 (win64) Build 2552052 Fri May 24 14:49:42 MDT 2019
// Date        : Thu Nov  2 14:27:23 2023
// Host        : DESKTOP-IB3MINB running 64-bit major release  (build 9200)
// Command     : write_verilog -force -mode funcsim
//               D:/.lnk/ChineseTechnology/ChineseMedicine/FPGA/1102/Test_FIR/Test_FIR.runs/c_addsub_0_synth_1/c_addsub_0_sim_netlist.v
// Design      : c_addsub_0
// Purpose     : This verilog netlist is a functional simulation representation of the design and should not be modified
//               or synthesized. This netlist cannot be used for SDF annotated simulation.
// Device      : xc7k160tffg676-2
// --------------------------------------------------------------------------------
`timescale 1 ps / 1 ps

(* CHECK_LICENSE_TYPE = "c_addsub_0,c_addsub_v12_0_13,{}" *) (* downgradeipidentifiedwarnings = "yes" *) (* x_core_info = "c_addsub_v12_0_13,Vivado 2019.1" *) 
(* NotValidForBitStream *)
module c_addsub_0
   (A,
    B,
    CLK,
    S);
  (* x_interface_info = "xilinx.com:signal:data:1.0 a_intf DATA" *) (* x_interface_parameter = "XIL_INTERFACENAME a_intf, LAYERED_METADATA undef" *) input [15:0]A;
  (* x_interface_info = "xilinx.com:signal:data:1.0 b_intf DATA" *) (* x_interface_parameter = "XIL_INTERFACENAME b_intf, LAYERED_METADATA undef" *) input [15:0]B;
  (* x_interface_info = "xilinx.com:signal:clock:1.0 clk_intf CLK" *) (* x_interface_parameter = "XIL_INTERFACENAME clk_intf, ASSOCIATED_BUSIF s_intf:c_out_intf:sinit_intf:sset_intf:bypass_intf:c_in_intf:add_intf:b_intf:a_intf, ASSOCIATED_RESET SCLR, ASSOCIATED_CLKEN CE, FREQ_HZ 100000000, PHASE 0.000, INSERT_VIP 0" *) input CLK;
  (* x_interface_info = "xilinx.com:signal:data:1.0 s_intf DATA" *) (* x_interface_parameter = "XIL_INTERFACENAME s_intf, LAYERED_METADATA undef" *) output [16:0]S;

  wire [15:0]A;
  wire [15:0]B;
  wire CLK;
  wire [16:0]S;
  wire NLW_U0_C_OUT_UNCONNECTED;

  (* C_ADD_MODE = "0" *) 
  (* C_AINIT_VAL = "0" *) 
  (* C_A_TYPE = "0" *) 
  (* C_A_WIDTH = "16" *) 
  (* C_BORROW_LOW = "1" *) 
  (* C_BYPASS_LOW = "0" *) 
  (* C_B_CONSTANT = "0" *) 
  (* C_B_TYPE = "0" *) 
  (* C_B_VALUE = "0000000000000000" *) 
  (* C_B_WIDTH = "16" *) 
  (* C_CE_OVERRIDES_BYPASS = "1" *) 
  (* C_CE_OVERRIDES_SCLR = "0" *) 
  (* C_HAS_BYPASS = "0" *) 
  (* C_HAS_CE = "0" *) 
  (* C_HAS_C_IN = "0" *) 
  (* C_HAS_C_OUT = "0" *) 
  (* C_HAS_SCLR = "0" *) 
  (* C_HAS_SINIT = "0" *) 
  (* C_HAS_SSET = "0" *) 
  (* C_IMPLEMENTATION = "1" *) 
  (* C_LATENCY = "1" *) 
  (* C_OUT_WIDTH = "17" *) 
  (* C_SCLR_OVERRIDES_SSET = "1" *) 
  (* C_SINIT_VAL = "0" *) 
  (* C_VERBOSITY = "0" *) 
  (* C_XDEVICEFAMILY = "kintex7" *) 
  (* downgradeipidentifiedwarnings = "yes" *) 
  c_addsub_0_c_addsub_v12_0_13 U0
       (.A(A),
        .ADD(1'b1),
        .B(B),
        .BYPASS(1'b0),
        .CE(1'b1),
        .CLK(CLK),
        .C_IN(1'b0),
        .C_OUT(NLW_U0_C_OUT_UNCONNECTED),
        .S(S),
        .SCLR(1'b0),
        .SINIT(1'b0),
        .SSET(1'b0));
endmodule

(* C_ADD_MODE = "0" *) (* C_AINIT_VAL = "0" *) (* C_A_TYPE = "0" *) 
(* C_A_WIDTH = "16" *) (* C_BORROW_LOW = "1" *) (* C_BYPASS_LOW = "0" *) 
(* C_B_CONSTANT = "0" *) (* C_B_TYPE = "0" *) (* C_B_VALUE = "0000000000000000" *) 
(* C_B_WIDTH = "16" *) (* C_CE_OVERRIDES_BYPASS = "1" *) (* C_CE_OVERRIDES_SCLR = "0" *) 
(* C_HAS_BYPASS = "0" *) (* C_HAS_CE = "0" *) (* C_HAS_C_IN = "0" *) 
(* C_HAS_C_OUT = "0" *) (* C_HAS_SCLR = "0" *) (* C_HAS_SINIT = "0" *) 
(* C_HAS_SSET = "0" *) (* C_IMPLEMENTATION = "1" *) (* C_LATENCY = "1" *) 
(* C_OUT_WIDTH = "17" *) (* C_SCLR_OVERRIDES_SSET = "1" *) (* C_SINIT_VAL = "0" *) 
(* C_VERBOSITY = "0" *) (* C_XDEVICEFAMILY = "kintex7" *) (* ORIG_REF_NAME = "c_addsub_v12_0_13" *) 
(* downgradeipidentifiedwarnings = "yes" *) 
module c_addsub_0_c_addsub_v12_0_13
   (A,
    B,
    CLK,
    ADD,
    C_IN,
    CE,
    BYPASS,
    SCLR,
    SSET,
    SINIT,
    C_OUT,
    S);
  input [15:0]A;
  input [15:0]B;
  input CLK;
  input ADD;
  input C_IN;
  input CE;
  input BYPASS;
  input SCLR;
  input SSET;
  input SINIT;
  output C_OUT;
  output [16:0]S;

  wire \<const0> ;
  wire [15:0]A;
  wire ADD;
  wire [15:0]B;
  wire CLK;
  wire [16:0]S;
  wire NLW_xst_addsub_C_OUT_UNCONNECTED;

  assign C_OUT = \<const0> ;
  GND GND
       (.G(\<const0> ));
  (* C_ADD_MODE = "0" *) 
  (* C_AINIT_VAL = "0" *) 
  (* C_A_TYPE = "0" *) 
  (* C_A_WIDTH = "16" *) 
  (* C_BORROW_LOW = "1" *) 
  (* C_BYPASS_LOW = "0" *) 
  (* C_B_CONSTANT = "0" *) 
  (* C_B_TYPE = "0" *) 
  (* C_B_VALUE = "0000000000000000" *) 
  (* C_B_WIDTH = "16" *) 
  (* C_CE_OVERRIDES_BYPASS = "1" *) 
  (* C_CE_OVERRIDES_SCLR = "0" *) 
  (* C_HAS_BYPASS = "0" *) 
  (* C_HAS_CE = "0" *) 
  (* C_HAS_C_IN = "0" *) 
  (* C_HAS_C_OUT = "0" *) 
  (* C_HAS_SCLR = "0" *) 
  (* C_HAS_SINIT = "0" *) 
  (* C_HAS_SSET = "0" *) 
  (* C_IMPLEMENTATION = "1" *) 
  (* C_LATENCY = "1" *) 
  (* C_OUT_WIDTH = "17" *) 
  (* C_SCLR_OVERRIDES_SSET = "1" *) 
  (* C_SINIT_VAL = "0" *) 
  (* C_VERBOSITY = "0" *) 
  (* C_XDEVICEFAMILY = "kintex7" *) 
  (* downgradeipidentifiedwarnings = "yes" *) 
  c_addsub_0_c_addsub_v12_0_13_viv xst_addsub
       (.A(A),
        .ADD(ADD),
        .B(B),
        .BYPASS(1'b0),
        .CE(1'b0),
        .CLK(CLK),
        .C_IN(1'b0),
        .C_OUT(NLW_xst_addsub_C_OUT_UNCONNECTED),
        .S(S),
        .SCLR(1'b0),
        .SINIT(1'b0),
        .SSET(1'b0));
endmodule
`pragma protect begin_protected
`pragma protect version = 1
`pragma protect encrypt_agent = "XILINX"
`pragma protect encrypt_agent_info = "Xilinx Encryption Tool 2019.1"
`pragma protect key_keyowner="Cadence Design Systems.", key_keyname="cds_rsa_key", key_method="rsa"
`pragma protect encoding = (enctype="BASE64", line_length=76, bytes=64)
`pragma protect key_block
hkYW+OZm6k9gF5yAUfXGm/n8kfXYD6tjFQYha968Ws0SqrM/NNAjCrrtMG8kIqTbkipnmceefxNr
sB0PtSpUrw==

`pragma protect key_keyowner="Synopsys", key_keyname="SNPS-VCS-RSA-2", key_method="rsa"
`pragma protect encoding = (enctype="BASE64", line_length=76, bytes=128)
`pragma protect key_block
NEPpD4CxNBVJLV3hg1agn83QnqiCz3YuR89MlVuNyQGERKVJ+uGolFDqHFzBKLQArFTiHBWivkzK
A2DQ42XdOxp30NKOgHjrjgmF+fZMjDs24rn3Ue1INLHwTS5RT84Kih7Jx/7R0dl03/COJq+33l9u
7l+ArdY7mLwqqI9iIjU=

`pragma protect key_keyowner="Aldec", key_keyname="ALDEC15_001", key_method="rsa"
`pragma protect encoding = (enctype="BASE64", line_length=76, bytes=256)
`pragma protect key_block
cfBwEwc95LpKuxDGqpON2gGac620iHNKrm/QNXYg3/OFA5ZQNdpdhRz4vCTQRVbOg7b1nIox6GR8
TD/cf0JW38RU0NuY+TR6CkFT19NCdy67gR6JTDdXifhr/zTKjOL5gvp0XjT9PSLwwPyDirNX4TMa
9y9X5pf4gEnt0dikHNgySZO+Qpr30MP7n6oAjuxowlf45cfmPqZthYPnIjBSCdQGBPfSF+kZ2F1N
XCDEja5xE4CQshPPodH5njadc6kj7/qp9C4PfKcyNtDug+qsws9UK25Z2IFc8vk6/15HlIkQHkXv
Wq0iHaPLidqh3035FinHyPD/FDnfGGa5Oa2qcg==

`pragma protect key_keyowner="ATRENTA", key_keyname="ATR-SG-2015-RSA-3", key_method="rsa"
`pragma protect encoding = (enctype="BASE64", line_length=76, bytes=256)
`pragma protect key_block
QmjD3HAHcP+h0RsjR0iH8h2N6drNxei50nfQN9RC8HobMEaARq/6rKjZEhHXMSCStQeCMhyVKRmN
HM7ZrqMf3W0s/8U4QMqp3M1VuYXVjEe2PCIpvtRcMY3JngdSWOydG2dH6dDA16ehxinMKgIr0TjA
PXA+lfyX6yTs1FWrne/6ufrl6ZAPpNG7EDKQ2aHqSm8DEXT1BJYMblBfAjAajwaJmPEu1aDlQeNo
onryTiFJkKP92pcZLCCufZL8ZAJ5uMvZZxiZRsiLd0BnCfOe3rl9AON+q53U+iK11EvAkpIBT+Cc
VYb5NqVAVaqXbQrqo3+YHEW5ft3fM9kZnlFDew==

`pragma protect key_keyowner="Xilinx", key_keyname="xilinxt_2019_02", key_method="rsa"
`pragma protect encoding = (enctype="BASE64", line_length=76, bytes=256)
`pragma protect key_block
FkHW107swc8fPv4xOTlQJU6PWERObturlywl6rsGCswc/v367bmQ1Maze/8QdmUPjEYwhAcHKVMu
7U4o3CvYhmrDpYiUQdQQ0B7gAbMZbJ8MFY5jRxn7KYDk+Bi9Ov8092IdW1a51FPWEVPmF4Kn6z4E
DSqpQDL58qieEUnrU2Ltb4GLJc3NrWTLvnbvRtHUUuQWTMZTQ7WqX4iH2dZ/EICpbRjlAF50iMAS
YHuuFTRKXcIFQlKYRyeQV4nyaA5JGbb3RC3N/Q2IZjdSXqQ9EOpmdhttpxReCnsdJiD/pPCtf7ZN
d/TheLy1Va2FZR+p4MozZorVui5/FtcCwKy6aw==

`pragma protect key_keyowner="Mentor Graphics Corporation", key_keyname="MGC-VELOCE-RSA", key_method="rsa"
`pragma protect encoding = (enctype="BASE64", line_length=76, bytes=128)
`pragma protect key_block
NgZm/7Jvy0UZQRVxBVxeZ/odxMd59IlnRFHjM+6Bof6o6u4Qy4u9MOoQ3Sr2paPuGq+B+5EhdcD8
a5WGiurBrPW0qF+L2CoUJsDqz0WonRehZECQynibSUlmctvvMyr790pwb+C78gtW47p8uALYdUCJ
NhcDkV8fE3jFdDEYmfQ=

`pragma protect key_keyowner="Mentor Graphics Corporation", key_keyname="MGC-VERIF-SIM-RSA-2", key_method="rsa"
`pragma protect encoding = (enctype="BASE64", line_length=76, bytes=256)
`pragma protect key_block
TxQNdd2WOThZCBZEYNgXxai4jK9AqWD/GRadYnarEfzmLUfcNDUoG7DxVWHCdTVuW8i2qZpouT1H
FUHt76rzZk8vI2tFLfUbKyTaRqik1aYwOCp1ZdqbgqQEDhBRWJjGxcJuxZbSQ2z8IUgiJ0eT148+
nf9UmzvYS1jrIsN/a7K4EjyRNMk0V917y85rxdk7itlisaUw4Cm72z9slByFtALj6/077uPjcK9U
mbWm7PbXk8PT44eQeaJl990wlWvD5/8BZS6AHqjg8520Xs+jftSeB6aNqTiYxfp21FJqmexwo7cG
G3BH/DRHhP7ZIsXHqSaJJFo20Nx9VgpLuF5t2g==

`pragma protect key_keyowner="Mentor Graphics Corporation", key_keyname="MGC-PREC-RSA", key_method="rsa"
`pragma protect encoding = (enctype="BASE64", line_length=76, bytes=256)
`pragma protect key_block
cVXgbL8iaVM2ESLJStuACNFelP0JgpPrbYgJ/gWlrYB53lckniya3H3UvHlAo4jd07HUm5NLCFak
7q0oeI5nMxfUALuujzvNCBGiFLNjj+MxydOBoIEmeVs0iJp1JWUzDC/eg5S7YbeLaPxexHeWpWzW
DsYELuaP4f/BxnKrTEjAwu/7YeCIpmleZRHD2zSilBF3Gs7ef5LRoQrA9PasukAHlbBwOcZOzq3C
HXfyTlJK0PbkyEPckL5gUwFISc9V62QZMNyZrHQrk6Q00ICp7mFm9nhOyKS6c25TGnRx8TJZx52i
rDcUU/py3ZS3IRd8yPhYMPT1XiGrrSr46vqlpA==

`pragma protect key_keyowner="Synplicity", key_keyname="SYNP15_1", key_method="rsa"
`pragma protect encoding = (enctype="BASE64", line_length=76, bytes=256)
`pragma protect key_block
yNZwnysJt+g+XvzJxOv1aALa2JkaiuINJ+w26AqjmTTdNycWg1E8frExDDv7XrhgTzhzoAmIB8ix
vEdnLzJ751omPqh0ef2AQKAvjVoJxyt968b1jSILq4DH8meZrfVLQti+8vTFHmPmabuI0VjbN/vW
EzYx+Ths1gYFVYrB54nmj7PIrpA7uKb2jJS9W89mAHtFefM4+1DxlHNwadSYlVeeveLZYjaLK85i
ijvthuVcm3dXAhh9awwUiy8W8SpTUEIzF/Hp2XWR5vogrk7dcB5kk82m/RBPxQdacKl6ay1nnIo2
pFIpwVXTqTVUA/NrlVVRurHqDsXHNSPnq2jJYg==

`pragma protect data_method = "AES128-CBC"
`pragma protect encoding = (enctype = "BASE64", line_length = 76, bytes = 12448)
`pragma protect data_block
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
z6GrOOed/uDK2YCgE9iW0mLw5jrdjA==
`pragma protect end_protected
`ifndef GLBL
`define GLBL
`timescale  1 ps / 1 ps

module glbl ();

    parameter ROC_WIDTH = 100000;
    parameter TOC_WIDTH = 0;

//--------   STARTUP Globals --------------
    wire GSR;
    wire GTS;
    wire GWE;
    wire PRLD;
    tri1 p_up_tmp;
    tri (weak1, strong0) PLL_LOCKG = p_up_tmp;

    wire PROGB_GLBL;
    wire CCLKO_GLBL;
    wire FCSBO_GLBL;
    wire [3:0] DO_GLBL;
    wire [3:0] DI_GLBL;
   
    reg GSR_int;
    reg GTS_int;
    reg PRLD_int;

//--------   JTAG Globals --------------
    wire JTAG_TDO_GLBL;
    wire JTAG_TCK_GLBL;
    wire JTAG_TDI_GLBL;
    wire JTAG_TMS_GLBL;
    wire JTAG_TRST_GLBL;

    reg JTAG_CAPTURE_GLBL;
    reg JTAG_RESET_GLBL;
    reg JTAG_SHIFT_GLBL;
    reg JTAG_UPDATE_GLBL;
    reg JTAG_RUNTEST_GLBL;

    reg JTAG_SEL1_GLBL = 0;
    reg JTAG_SEL2_GLBL = 0 ;
    reg JTAG_SEL3_GLBL = 0;
    reg JTAG_SEL4_GLBL = 0;

    reg JTAG_USER_TDO1_GLBL = 1'bz;
    reg JTAG_USER_TDO2_GLBL = 1'bz;
    reg JTAG_USER_TDO3_GLBL = 1'bz;
    reg JTAG_USER_TDO4_GLBL = 1'bz;

    assign (strong1, weak0) GSR = GSR_int;
    assign (strong1, weak0) GTS = GTS_int;
    assign (weak1, weak0) PRLD = PRLD_int;

    initial begin
	GSR_int = 1'b1;
	PRLD_int = 1'b1;
	#(ROC_WIDTH)
	GSR_int = 1'b0;
	PRLD_int = 1'b0;
    end

    initial begin
	GTS_int = 1'b1;
	#(TOC_WIDTH)
	GTS_int = 1'b0;
    end

endmodule
`endif
