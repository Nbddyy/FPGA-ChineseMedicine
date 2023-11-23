// Copyright 1986-2019 Xilinx, Inc. All Rights Reserved.
// --------------------------------------------------------------------------------
// Tool Version: Vivado v.2019.1 (win64) Build 2552052 Fri May 24 14:49:42 MDT 2019
// Date        : Wed Nov  1 19:55:08 2023
// Host        : DESKTOP-IB3MINB running 64-bit major release  (build 9200)
// Command     : write_verilog -force -mode funcsim
//               D:/.lnk/ChineseTechnology/ChineseMedicine/FPGA/1101/ADC_DATA_XDH/ADC_DATA_XDH.srcs/sources_1/ip/addsub_real_imaginary/addsub_real_imaginary_sim_netlist.v
// Design      : addsub_real_imaginary
// Purpose     : This verilog netlist is a functional simulation representation of the design and should not be modified
//               or synthesized. This netlist cannot be used for SDF annotated simulation.
// Device      : xc7vx690tffg1927-2
// --------------------------------------------------------------------------------
`timescale 1 ps / 1 ps

(* CHECK_LICENSE_TYPE = "addsub_real_imaginary,c_addsub_v12_0_13,{}" *) (* downgradeipidentifiedwarnings = "yes" *) (* x_core_info = "c_addsub_v12_0_13,Vivado 2019.1" *) 
(* NotValidForBitStream *)
module addsub_real_imaginary
   (A,
    B,
    CLK,
    ADD,
    S);
  (* x_interface_info = "xilinx.com:signal:data:1.0 a_intf DATA" *) (* x_interface_parameter = "XIL_INTERFACENAME a_intf, LAYERED_METADATA undef" *) input [31:0]A;
  (* x_interface_info = "xilinx.com:signal:data:1.0 b_intf DATA" *) (* x_interface_parameter = "XIL_INTERFACENAME b_intf, LAYERED_METADATA undef" *) input [31:0]B;
  (* x_interface_info = "xilinx.com:signal:clock:1.0 clk_intf CLK" *) (* x_interface_parameter = "XIL_INTERFACENAME clk_intf, ASSOCIATED_BUSIF s_intf:c_out_intf:sinit_intf:sset_intf:bypass_intf:c_in_intf:add_intf:b_intf:a_intf, ASSOCIATED_RESET SCLR, ASSOCIATED_CLKEN CE, FREQ_HZ 100000000, PHASE 0.000, INSERT_VIP 0" *) input CLK;
  (* x_interface_info = "xilinx.com:signal:data:1.0 add_intf DATA" *) (* x_interface_parameter = "XIL_INTERFACENAME add_intf, LAYERED_METADATA undef" *) input ADD;
  (* x_interface_info = "xilinx.com:signal:data:1.0 s_intf DATA" *) (* x_interface_parameter = "XIL_INTERFACENAME s_intf, LAYERED_METADATA undef" *) output [32:0]S;

  wire [31:0]A;
  wire ADD;
  wire [31:0]B;
  wire CLK;
  wire [32:0]S;
  wire NLW_U0_C_OUT_UNCONNECTED;

  (* C_ADD_MODE = "2" *) 
  (* C_AINIT_VAL = "0" *) 
  (* C_A_TYPE = "0" *) 
  (* C_A_WIDTH = "32" *) 
  (* C_BORROW_LOW = "1" *) 
  (* C_BYPASS_LOW = "0" *) 
  (* C_B_CONSTANT = "0" *) 
  (* C_B_TYPE = "0" *) 
  (* C_B_VALUE = "00000000000000000000000000000000" *) 
  (* C_B_WIDTH = "32" *) 
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
  (* C_OUT_WIDTH = "33" *) 
  (* C_SCLR_OVERRIDES_SSET = "1" *) 
  (* C_SINIT_VAL = "0" *) 
  (* C_VERBOSITY = "0" *) 
  (* C_XDEVICEFAMILY = "virtex7" *) 
  (* downgradeipidentifiedwarnings = "yes" *) 
  addsub_real_imaginary_c_addsub_v12_0_13 U0
       (.A(A),
        .ADD(ADD),
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

(* C_ADD_MODE = "2" *) (* C_AINIT_VAL = "0" *) (* C_A_TYPE = "0" *) 
(* C_A_WIDTH = "32" *) (* C_BORROW_LOW = "1" *) (* C_BYPASS_LOW = "0" *) 
(* C_B_CONSTANT = "0" *) (* C_B_TYPE = "0" *) (* C_B_VALUE = "00000000000000000000000000000000" *) 
(* C_B_WIDTH = "32" *) (* C_CE_OVERRIDES_BYPASS = "1" *) (* C_CE_OVERRIDES_SCLR = "0" *) 
(* C_HAS_BYPASS = "0" *) (* C_HAS_CE = "0" *) (* C_HAS_C_IN = "0" *) 
(* C_HAS_C_OUT = "0" *) (* C_HAS_SCLR = "0" *) (* C_HAS_SINIT = "0" *) 
(* C_HAS_SSET = "0" *) (* C_IMPLEMENTATION = "1" *) (* C_LATENCY = "1" *) 
(* C_OUT_WIDTH = "33" *) (* C_SCLR_OVERRIDES_SSET = "1" *) (* C_SINIT_VAL = "0" *) 
(* C_VERBOSITY = "0" *) (* C_XDEVICEFAMILY = "virtex7" *) (* ORIG_REF_NAME = "c_addsub_v12_0_13" *) 
(* downgradeipidentifiedwarnings = "yes" *) 
module addsub_real_imaginary_c_addsub_v12_0_13
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
  input [31:0]A;
  input [31:0]B;
  input CLK;
  input ADD;
  input C_IN;
  input CE;
  input BYPASS;
  input SCLR;
  input SSET;
  input SINIT;
  output C_OUT;
  output [32:0]S;

  wire \<const0> ;
  wire [31:0]A;
  wire ADD;
  wire [31:0]B;
  wire CLK;
  wire [32:0]S;
  wire NLW_xst_addsub_C_OUT_UNCONNECTED;

  assign C_OUT = \<const0> ;
  GND GND
       (.G(\<const0> ));
  (* C_ADD_MODE = "2" *) 
  (* C_AINIT_VAL = "0" *) 
  (* C_A_TYPE = "0" *) 
  (* C_A_WIDTH = "32" *) 
  (* C_BORROW_LOW = "1" *) 
  (* C_BYPASS_LOW = "0" *) 
  (* C_B_CONSTANT = "0" *) 
  (* C_B_TYPE = "0" *) 
  (* C_B_VALUE = "00000000000000000000000000000000" *) 
  (* C_B_WIDTH = "32" *) 
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
  (* C_OUT_WIDTH = "33" *) 
  (* C_SCLR_OVERRIDES_SSET = "1" *) 
  (* C_SINIT_VAL = "0" *) 
  (* C_VERBOSITY = "0" *) 
  (* C_XDEVICEFAMILY = "virtex7" *) 
  (* downgradeipidentifiedwarnings = "yes" *) 
  addsub_real_imaginary_c_addsub_v12_0_13_viv xst_addsub
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
EELUseKc4+91XXgI9Nr1O2buBIMpcX2SYXFkyLTW5lqqyKp9bYa2mSEA7xUXGsFJqtG1RosCVXL5
2CdMDXMpfSTXQlyD4KlFhptrbCA/fTzg8tcr9kZlwxA8Q+jkfAfvigbb/vwp1eDKPoMsRJqWXLII
5X8P5gREOWzXDRSFb8DLBGs47E5j9BS/LvC1wb24DXqpG/LPoqj/j2/WOB7JBz00ANHFfSpK90Gu
UQfE6kL1oSoG9Ue0wXzeftYps9b3juLRs+XKT3d0I8jv2GOcml46zoisSK6iSgpXPcXPoekICGLm
J47fyD5ENDdZLflHd6S/S9Eosxoo+nE9SRPhiw==

`pragma protect key_keyowner="Synplicity", key_keyname="SYNP15_1", key_method="rsa"
`pragma protect encoding = (enctype="BASE64", line_length=76, bytes=256)
`pragma protect key_block
DbEsk+G1xzOAIfBIdsC0uy8qHUfgOQmpa3xd5r4ffmhX9bewxu0IRW97DykoqjMlq5Ol/2lK0seR
lmyJLsyIPpXUng5+lPcO562RXxaliOH3y3OPeGJNwmGOUi+LaeX/oURx1rfU8BRHYUA11PBKuRj4
zpZhM8IL0Vr2aWQJlw1sed+t9UnZXKiFy2CTa3GZDWCNy/sy3ne5gHUTY43FXK06tNp20wV/rytW
mPVUnHBBDbnvUF+YkdLxzKnOQcVmakc1gxvPFfMafbsnLiSyWYRpF97uc1DwPeCVUXrG0Grc0/Ch
KS7HrUFuHnuI9vcDpxundCuWD0tUN4s2Zyk0/A==

`pragma protect data_method = "AES128-CBC"
`pragma protect encoding = (enctype = "BASE64", line_length = 76, bytes = 12064)
`pragma protect data_block
uoZZ7zGdYkNidRceDjYAmMgOS8oe9vJFDjNwtMNq9FvMHyJzSfY4ahVqUNvOZ0BQRRzJVODe9LGC
0T6L5G0NEoadEVneRNIbeSkHtLrC+tKantxcxLGS7zex8C1PoZmJw2WI2vSH//BUbdwPzgWbFFmo
dsvPb4MuRleU2YuVObdawmPgJ64BYfzpKUB0YukfS3gpRAUhZvps6NJxk9fp5DeFxoMyd2mdBiEM
d3ZfgYcYxuNCoziw+6m+slf14HnLNas5Z37bAdeX6qAKyhMsXon+/VxUo8dr/w5qFh+UTMnwhY08
mGGKzNuqOTOSHBONE7Vaw8nPpNZCnscecPLL0oh+xTVqf0vni/mUbx2ON9HFlPpPVlz698Ppp3fS
+CGY4f88yNshELPm33UBUKv0FB30xRw+Fylt8yp8Ls3xkNUhefkEvf9B6ME3OohdBo06wrJUCTps
Fq6iPaCk9bkTmW9LLQb8f56Y3ZZaPk1TtnwemtAyns+TMv6IeSZPHRkCX19E8EymAuH+BAE0YY0z
WshQCBbR/5onViRM3SYD98cHaTsShlomsne6eHgEllHDxTGyxvYm+On80lzuplYDb4UwMfsiDaBo
Mw3ZiLp04J8h7BiTd5g9PLHujka6xhB6grNmEorjmjTDoqC9KcSXhrePbmnXc1oYPDXG6eEoH+nO
oE7hiMaXpwLZB5kbk3ZObMs6CPeQav7VeRi+ENCkKrnXa27+PTLBTIYRg8+SWsaMZFvYfM9Ji+8q
8IsKSd0kXvEqoT7jp27ejsaBooxX1/Aq0Wu6D1x7CQ/rCSnTyKOmXMdbuKb/etnbt7BCW9ujVTK5
4ZXiQmjWnHSSqO75RjHebaorMTeqjyn/1Yy9DyBCdNFE8Z9aYbRtXAS81EdWj2c+DNCHHr4EzBzt
Vfe+lJognjjtKB8k2ESsAW0ZXFwoi5tjZv87SAJyDRDPGtn7dJB4i0bmnqtQJ6kuNrX1GdfoQ4Jb
OjW03OrFR2ZMJm4EQ3DAyhenZAR1m0jcFWScLxQv0eUS6B/LIvfA9sx8ZO6BwHprSCLFCtX6PgvI
C3PdPkS7Ow1sS3+6/p6G408QC1JucqPvWn5eDdM32C2Nc9DN6kFa9n6WtZSC+QlD2S7dXe2069Qq
DuqjbeFd41PFD0Lo9h3RqvAQE4pCPrgpcqic9a7/CIRKTD++XZkbTooTw947TSwJCEliv3fe9iOe
ze745wYBje8M0/FZC8LPCWKHNT8HwiQwO66faqFAp6bLmoAyjr6dzAt9fyuDOLgyh51my3Ch8stc
XXK6Xh+8SbhKnrV93ErNy9mXfjpxKlzKdCTwzgylcdV6M+m+J3CX/yVCMT/6BLBogdvORmxnyRev
j27/9j8maU6xR/8radhPtqCNghAxIj26J/XvmzM8ifARhh5V1d4sgOR7TPmd3/FexmD3A1/yrIRF
l0U6N5ezH4LXWLPQdM3ukHxzXZqGxOjDq+vqZPcwlYeYvbl/E36QZAxLDysMJ46xy9/II1K5NCfS
OsK+bzY/GCVXDdPS529y0HC3o4bIQGJXkKz/XBZAHSi5YCwoNNbafQsGRJ0MCrguwznByitRCT80
BFuV86cwwb7wYn+61IpE2DB7tilKMlyXdxTPlD0RZGLdVYKqxb+vXbLVg+uOhWTTiFRFwNR89mLN
ogGPBDyARAxNPi9OdZ9ZX9rOTpXY1JchYHEAjm0BWKJm0JAB0Tj9ebmqzmokpeh+USoBMEF+hoza
X0/YlPNmtfvC5z2BkN6sEjJA+ASMmx37mSEytQZ2T5dFDqX51VrVVOu6ug/tlJWArrr1DBWp8CrF
NOYAD7g1PkaeQJLfcifyTZ985DCNOsEhREsmFrKkDy2h9tRlbReAE+64Y18U2eyeQLdDK/r2M+pm
sfixLE0ut6w+mTlfe06McZBTLHA7nsomtSzE/hhmLSHaEaPhAl977s4iKjnE43ew+wMeJJgn6sFA
853LQJOqpr2NtyaOAj34rbueCEDXoQkztfmttF3AU085om6TgN4re+dsMmPLeOUDk+KmBXpN2vMp
5uKS7x1/54+b0epSLtcRff/Vq4RGrKzK+LeXQONMQDm6Y0wIMyd57o9kXd1CTwfYRDPqx6DWq+Ri
9FW1pW93eimf9/wQVJUD3YboN14qt/j0q6Bkv4EdqcRpeaglmpRP0Rus2vpEYbo62XLjUlbPofz+
XwApY1CtTSu0GRgtB/42Pdef0y6g0OqaZznqsK4sQAL1GS/h2qHDkcek52IcWh+AECbHTtK+0vt5
xr2LaxbbkUg+jNlj8W1eRg/rKh/9O+137DmuxHwt4oEnouusCSLmzsgdAXPLlMbTtykxhUMV9GzS
gJN0WPMmzA7qb7PC1Su3TM7LhH5EU5mYaU5BlZr8k5bzFDTA20SfkW93B2/5V4GNj9DTrtuWNML7
9S6rI21JbmnHBDg0iNNnUEvnU0dWci+Jgx5lB7MaZkFNKq5zci5zoIRUtI3EXTZmI92Xms82NJfb
GPiJmdJyCKXdiF+KZxAJlXuAOCvL/15HOE9eijnDkgdc+HCo5uLocwcgG/20/liTMsPbu3UktPhB
Hrvs62NqwochVzxi+JERfu/LEkgXTBe5zazot1ezjUpJfjQYDQwEbvef42DlO/nBENNtakNkknus
Ped76BGdMbSpihzLOx+Hsm5PrOLyNODvozYrsKFf7n0vZUm0YtelwfIx8r1d5eZM/yPekuSIVeS1
fERBTJgE9EfPuyzOfcWD50r7YWc3Ax2qpRXKlIuBIF2JWjxQK7xMDcMAC/+epOlbi8aLPxIl4K/m
rONmwiRDH6wq0JuKituirjeiQ9JopGU5+U9EpNsqXjVAJavSpy/quhJCtaELH3EURJWOeMC2pLAw
O4vTRzEyMKwJAxdsv0NuS8Qz4lMwHhTZh55YBB9GU94TAMY4LYogPVN54jKbYRM5N2dPmHuitD5c
qZKz27x1xpK4d8evsTGylCxmY3IEE7HkvavZlfHdTM5+0RWQnVcZ7dw2Dp0rzp2va36il5d7HaK4
U/gosqI+3uiZvoPktG+v62COp1Eu2JD4SoRdM1vN7Oyvy0GFHROCFkM2VuHrYk5A1pWQaxEpBlbM
z3iaBby+0G+wbjRlBtY4q80cjE+EVyf7VxV+7upee6WzK4UEFINuvtMkchoOxIwM0DFCoAuvNkhx
8lGEYt/jS5xajr/Uie+ruhrnDQ87I4M5JO2sb1b7nPH9jKm8wFxoRojbZVWvagD4q+a7mm5rTVlI
pIZbxegV5LEWpgY+xM/1PuNou84z/mFN0ZGRNiAu/zb83VPjSbvCIdRNtj2u0eB/qi6tIy6lMgxI
2k1FNCKkpKRUhUsFMlVFl1VCEPqMISm3UVxezrceS15Que8nt6ktwJDz/TQ0Zaoj9HbrPkQFkWgD
MHb9rG+cW4dBZW8OB2q9dj6Bb8mdPKHMoJUMEbEuTdkTl7Fn3dTAdff4ifv0tCQeB5p/4r30Xy4A
XppVURam1KtNI+ZfXUtWqAnwp5Yj6utrHqx9Uiw3D1C4lDxQIoCTUgdymn/DPsnQSQPNIakZ7A+v
sB5hk6uO6bifgtVW1pMZyLv2SzoqevLBsy3ay0Y85vPxwpn3RaohmBiqJgQ1c3aj0IvaBRNPZRs2
LildQWQ/BzMjXcwqzyA3Jbq+gdlE8kK6JjYWJed2HBEyvAKPxbw2HqnMCRCbOWbE8qhFs7bop99k
UYEgcekCuf59h/j21+pj/sKustSoWJNHse32CH4Aq/vfCIti8efK0qznVToBtFgPgEV73ZuvrQL2
SUYYQdXIW+cLi8Sfx45rEjA/O36301O+XV4c+aLfPVAvsBMvE9IeslMZsFbDtsksLIq4G+9m5Nem
rAOizATlU+1QqIv9oy9IEcVqGEyj4L47RE4sX/6zp5zFEsr0WBfjkE3J0QgKHauLmS0XJyOyPpdN
J05heq6Nzovf5s1CjSEzmcQs1ul/6I2NvcK/uqJe6Tdy1LX9/sbnw3rulFh1G3KxYJf5T0ubM4DY
b2B6HAR56O4XloyOtvKQcqMdmh5rBiaYREAeVEzZQGcjPumWm5cK0kcyvsCYxemDNLAMn+yEMUNr
zWK9YdlJA3G1plRjJWvY9nGKMRcV9BMWLf9yWMf77HybEe4olyFRS2gBrJWrI5LyhoOR/h9i++QJ
xcuG+AzaXscQF2DvWKNwzykhyYHU2mBeH1gluKcfnXAdaRgeGYVg3gu/IKhdUCo1asrxK1dD9btd
rtpgS2BSoZrZU44yktkKhc7Vg7AV/2eIV3N4bCVqdL9GTvz3932PAKxPQohoXYkachVIQ9UNzJGE
RgqjvKt5xX49RaePN3YRev78oeO7J6CR+q+/8Q6w8fE2gWCEdV4QpZ1KHooGHxB49o/Xr2Mf9OuR
uMA4qgWpHMCZ1z6kB4UOhr5ybFgmL6IaHtxfUiS79i6kKO+fEPwHd3F5E9K1BUxq9yOf7dqF5LOy
lyH5gkiNfmx226lxk/J/10YerHiLtdaBVWfKURi/Q2aQzrIgaN57T0mVY2E/DWBsWfSFLmtF3GQv
/5874kYudZCnauoYIgn/au8W+tovq7Ho56F//FKLhQ4BzZpZS0fRF6Vq5yb1guH0x7irm6JOwiWr
T4s+F3jC0ANLjigV/3n9eVLTskMP6wLAFdPjMomoBUEXYQDUkZFNhkOvDDTb5L//M2aSQQ3WKv99
uPoVH1gGMiGnqQuIzcrwRXL6ZVvzFjAQu2DxAQFuqh4BDAhXhB4Prg2BcqCKO6r/hShQCOdcAD9V
AZ5O0t2phUcSAxvn5UpVMQD3xYufyOkcVxjwpJTpPC+10cwffow5ArGf7I9kc4fibT8KWojYwNae
xgLUoaHGlXwSYrjamFUxe4PAXPRc9Ggi3EOT41Z8PZcWWkEDFoyTXbAfSnnUNOqENIPk5KbuJWGt
5IOEucxviUWxDQmtu1Rr8Clu3TsRQrVwbLnqcmd5hYYPrK4k7PHBQctA22+2WMgTC6s6ijmeND2J
dSEhj2n5CFD7sGd9WwtjyTfvjP0X6SaiNePFMu7U5lw3l9jJNiagwNIn3NO03S+Gssxkqu3aDfkK
5CXkBGQ8VdnPI3MJ0+bbNcnUkvEB6wzCLeE4DuYT2SnC1xxIzgzGB/hiRtL1ipedeqLx3vC42Am2
TMltKcDC63xdFBo0EOjcYPuFUfUvhpjFwaQwFy5ZaQnE6R4wR8hyCTJubbNX1s7S4zUPPYYYB6ea
FHpPptcGDvJcGym72p3/BmP8DcldBDrkYmwyRSqjiFYSuThLqDrjSYhCTU3rINojdh/FWlm7IlYN
tUB6sSi6vqA+pOSs1d9KyLUUfGhwCSWWQHMHPytpPWdCrtc6qXDiTPIIKkhBeWDlSi6xkZjO1a3r
0RQiGyyyiG0lWn7gCI2668A24n1h/gD2cTfNhS1m3hEw/frWVioUTHG3vI3B2WpbnXiP1i7U3TTo
09P31Hm85BpxM7ETRoyJDR6em3TxpJlfyPNXbSca46lNV9GZZOxxTUb1w6yGIuYOiDs34WsQxU+z
k11OQLvUEAbJs3aMsPAwZHgbyO66xTqrIkjxPXsZnJnwHJMRoO6uAGbroNmEeylwzTRSo40wwGJV
QU3tv2iX6PMPnA9wjh8H/kMdk/J14eZe6aHAgF7/lKmLRnalYp/5phuvTmYTvxp/F40SVUTsyuMp
FyhVa911Ib3mhKIqoURGCBT2/dkStyUdKjUDbkeDuGfFJuwvp1fU7gqUpARsB0yBUnCbnctDiePe
SWUNctQT2+ytvCJZb/7YGe6SITCO4imQp7X5axUd9et0mte5GQ/ZHIZmJBmSnujJMVwcI23dFMLy
erVDxc8P0ElR47Czws8zCL1ptwg0wnyDxXZ1UpM9NVStf6bdT7rMUFefCnxIs/HhVH8mlQlw2PEI
H1f1+tCHsKi4+/tbo6KNGodqs1d43B8ON5t3mrJ2bwA9yK4zqGLGfp4tGf4y3GMo0oJ+4vgg9/xe
p6SylEMjF3VGJarkCD/7lqxmwR6R6DPTo18N/gkvDX3S07CDfKzDJpOPF0bQMjQkYHBNEzTGp5B1
Urgmm8klOA7kRu0QMZjfmNNcDqf6dAsCX07+6ypSSc2HVSYOuE6xTQjJpg0+2RAGw4OzW1IkA93U
kxePLaalHxpWXzRx8ICaKMXzANdvXenYPMfv84KzdaW6S3mKrytiYnf3KgJynYN9w9P1Pcy/O4fa
17Qmrnuvl4ERNPwpDHEddi2DF4gLlsPIxIJhFTcS4icBvIF/z76xS4E7TkWOH+SPAKgmdROInfpt
PmZZlbTNDe8Z/PWfMWolL2EnD0KwBnLQ5F/ykq2oVbr5PickCSodyujxuNiJMM09iyOM4Ko1bmG4
B2BcrSxRWu1+Xwv424j+YGOqn1EPb7iO+wd5NguLmzb93EVizNhHzpwmB6H/XlAIjUaM3O1K8fh8
WK0rjKHnTYJIphoZurNMxZAkvGZsU2B3b+ROCbhRLTSC3prgyRiYhAzawsuCfKyiJofIhHZSukYW
OObdIPOUu/5yXVfgGRTdH+YBSIgjesPLlkEeyRGyokxPzt1hLtx6jTm1NGri6jaUoWjnHaQxHToa
ERcur0ZSNzJO2l/rsjyJQmFhJqwDGnyQl3OftKHeBCwoYUNM7ZsWQIl4NIp0S0LsFzsuBt8xHPjL
jPm8bCcQvOVZdgcet0dWupPqX8epHrqKjyfMXo+ejpyn45QVXee/n6zfHJySL0kHEeoKtqp8s8XR
2eQjuMotJuGHmFXQXRYoLeCd2m/G8vN3L/AZdD4A/Sw40wq/FMGEXGX4laArG9qt2kpHekHeE2tz
ZZX8DxXRzBpTRnyE7Q1VmZJrov3d1+CA3btlOaX+aoxGetcKZFSvXuBvhNz9d5kCRuIXpf5mcK9M
+skmaom2zD62TGelLpvLX3rcd+8C+4W1SOB/PszYOAAz4qeLrhSyzYseO5LsP2k7pfgYlhud3Rso
ltOdgFUucN5hpWsYvhz4isJouOsGptSpUhiIC2+t9ZgVBOd/NHgD4NlVpBpbkgbl2Khb92M+BUgl
koUhzGI38jPHZ4tpdxT6Zr578VO2vOoZu+Ac30FPAlpVGpYHM3Yn6bzDmGk4kUtsZfdL6UYXI3LR
+U9juD/RCtwjEgkiV5M9DSqkciiwy9auZJVsuHI2O+yOkTMwzwd+ZQ8zfogRpcc3Bh+k7hw/ZCkt
7SsoLECoM6Q2KA07G6+wo5Inlm1f8uOwq2BaouQDBI0S83zmvQM+Lp/5LtAFPVWxvGIoFP9nx7f+
gYxnR0YEJ9hJ5Bfqrsmi+ng4kLSlKnFigfJaUiBM9uRaFi37OZ77O7OvTB4242zGr3B8u8Aj08i7
ukwjpMsg12eEAJXbrl2G9ZE08CmQ1dH2MgHn9o3cKQ5VWAnQzSW43HpHMWX7OzhW1spM14TD45JX
XWsOpaBJLG7EBrIDWYphge4cdFTncqBqMLU0SLAgpUQ8/vZfJkJ8DWB/lLurEM+60BDmwcUS6dBj
0q21H65XwtS9VhnCtjOop1Niar/GyoZqWEEe53TXo7zuUCBgZMrFJJIO1AFDjmAsMLSwxj2uJHr1
xbtYOVq4f1nXPqRpWz2A+Vsy3+ErIUhCb+6Qtm+i5gBu093azi7W04mJxIyWB1BiCR0PGB0EGlES
f10KiTVyu0ljOQccuyew9aw9gYwm3tglVTtNQQnXl1uTzbqDRsxKekgyBq//o7844uJGkj6ykD4O
LKyzxH1+Q2TTJ6br+0IsZFjfDvFfqhAMLJ+d1hHdOSCdvDrqoJ9BJIjYT89M0UrH+mgPmQJOms5W
BToLsDoDPhlvYYVYRLnSOnjTfnWiV32ujIgbno9uGXip57yF+ASP+N2fPFfdiZv9/AwHsjn+ZpPe
s6v88UavAqvfoXGP9pDYfn3lsPXe59Bi9KpO2LnrCbTK+gXa+yXdx5Yw+AWRNGyrzyA4SkAFdjnv
Br/8oDFF/CZ661RFD10HbQA9Ukq3UiwNQS5q/La+f7fJT/tV6vyynZFPFLGfedWTL+Wx2xLyK0pD
REqjtMnoJYoTakDAfhDUxilhQ4hu/n+d+Chwamb3t3+5ick/NHlcK89llR6IehylH6ux1bi5Ci7T
cns4ehd/vdxPcaUxnYUYE9LmsWo/eSHy8s4REEZOLGWGu3waJo2GMOIVGyMpomNK8LIVJaYrwzSC
UFMU9AnTShtVlQT40KpfegV6TFifueQaijWns9+/NJWx66cMj5bwwJBQ4GK9eGgjDoCETelx5GiE
LM92D7p2NcT93PIs+4SKtVwlBUYoEtY/6KRSdPEUgqYvoAyqr3PBXgIvN4w/cFc9HKMtlbxY7tCI
61iiE7Ih+Rhp2YpCfpnCuVcMoLmQDvc9QmNygP/SGvJVHp+xSaZ7MmFrUMrG+Lw39REot9Cxe2xx
VodpPjDJZxkcDCDD6ZERkvXCZ9QUMBpJthVY0x0QjaxSZkzpatDWI+jV544hrGiVVtQfbd6F9Vdh
+0mVWfYkye9TWcLV5cPSkciAwLUt0JYMqbMBopyEuJSDQbq8ZrgbmkwajTVnKL0A9u5krGHNNXwG
za0xDzGxwPW4T9o9ZFpZ5zu7E6tsvS5QhbDWd6X01ugT+5hagmeuWjwQtVqqis04RCtCV+/8HLVU
pC01uBm3OxnQPSFycq7qIsBuGjL+A3/jg+klaVbbyzSWz5pn/oj1w8nuJvSgeyGJq8zeHqpAzISs
V2bSDm0Pc1AcE8Ds4NFsjCVLG96haIytnZ3uigLUyduJzEYdiaDVRFyB2IrxmylUB2bBLTwaRBVg
mb4gvJDaipsDDPZv+RdnsmoUP+iifzja4QwHpeZih8gLoub+7pCn6NGLFgQjzNBkyg9Qo2IFlJOV
slnqWUS/N/XjfRU6CPMtpQhViRMbh+N3a8a4NocAxc5jqGul4RLvqjvWDWagH1aujScOyQVAmyQw
m3Y6aUzWwmHZ+C1z0JasBD7NI1mE/pYG3p/zleIe4HAKpVUtjKFk07qm7cZ6mw0C/vfML8hMdpl3
DoJ/6zxBUgdZtnv1jDK7hN++F2bh1OFB+f/RAa8L5NgmG+Imy03Ay1PyPJUuwxjCvjbgGP5cBK9e
OJS658YgSzxvIYpaCm/c8T6JFqWJ3zmQEKPKaEkHdyTshAuCcfsXx28+Zyg5TwDPneyYcoqf6XcA
gQ9Z7pjxTS4GDCRf//egurFW8+V+FNWBoDh6KWVpbV4vFTiVmogjdPU0hFgC7YP3c14SlO49bw9P
DJTyYWXrrD3WYKhzYee9CMZWPMy+aw6bHr01DgPLUDJ0XxC3+Q/lfHfm2JlMdvx/zGc/ogCvxvKZ
IhNW5crXmDVSCxOP1PaUh4CzqK8TIGq3YLru6dWTiuLHvm24lbpzdGmuxoUzfDNiUohPfs5leuR7
eJ3dQqm0GpbHw5f6H2EN1YV2gCi09ZUHdwPewspabn9KGpoEwgYT2DTuuLa6/AJ0KkmKT32MX4jV
o5IZHKuyfkr4t1Y0ou7zgfQUHbqPFum4W+9yk8hYAtRKZIzvYSTIl89FUu0+E4dUxpZdqGvZzyq7
fxdjQJFZF5aUl+hYFIZyo2TInL9NPvTJT1iR/oZUwx+mXYDgxsRj7EvEh0V9Og4on4YxwNgXUYJC
4smfE6S0K6hVcuwIh03nFtS82qKpDeVWgdBiCcthffWeZ3zdxK1A/D9HAYn5ERk6zK7pDZI/hkiS
smtoP9VzFdGETjZ9DiLfo3dZgTc5z9D8OdLABmtvK6r02JT0tSHHoobys5NGAwILrVjsjauyUB6R
a3bMLkgc12HF2PATIvy5q9g1FE239zOAEago/hE21Fg+PXl23jlYEyseKpDDmXKq0Zaz4mp8fYu0
7dJIiVTso/VSg9h8Hj/f8ffGOStXx7ZYANFNHHPCgWRxx+GV8VWsSIhb86wh5xSGVnAhpojf+DMC
DRreNOBoSWCrQwa74TsuSIIdCM2EDZuafJuMXUtMQ9/XRZmPBxPeoow6OGQts8eZDz0mS1U4WA8Z
LK3UibE3nTuzGtGG0ZgzIWZQEodvMKhVcMaGimIK1aRci6jTaLjs7kz9WeLnaK5mUZBAMkt1atQa
BhwtpXi3hdmjV8C89ZEZHtvpOQPAGLOfGNKLP2DA8b0msgXdO14/5wJBp2H5bPra4wJ+zH9gMlhR
M5NlSKsTPLvDzbn1PT72OhEpZJRTjSepO4oUd4WNxj8OkNbH2Lz4R5NKp57pyRSCtj0kMbgTuhri
2pnRQ14y8T+4tUh9cwoJFG3ycN66Bt2Kub/21FAK3meeaFk8pZmJjYGzWa4fmw3dyaWVrq+Tzooo
o+l79v+5OJo1MoWIE5S9L1gNzndcumJXaiTZW/uyx7PpG42DOM2skyZnxPjktamgvfdwDHDVoj/I
WO3zz9iizs8Ora2AzA0k9sG1q2s2+XExZja+l4g5bV0uaUtI6y2qIT5SM2D7C99dLmQSyGJke65n
gn67QoNVSeS7DsDmva5ZhebhcHH5erxzZhPe16+LuWIA53ZqjKMUokyl40srt06NE9QKDNYiH8A6
1RN2W2W8z9bzpvVjMT8sNGLtno1InuNwHSlaQCJlnKTH+N1VhgqGOSXSmthH5+6k1l6nhPvYHMFz
isssX1T+9nhxRGzYyED93Emgw3x/MrTJ+P0dFaXwiiyHpdW5ZSoLtoVcTUcyLrGokl85I4UxFJad
WJFMnMxTiw3g8hMxEPZfHg0EVUavJNERqwwD8v4zWgnuNuT0QiwCIcGW0TL3UTYbVkYlzKiA76iC
wGNkYte3caklSOOImMQe1lKQ+iXh2RoMnDC8U3Nl7c5X2eazXIMEclqZuW3aZS8roPHFzss3WR2w
ed2qbYgbCQ5yC0CLojMT9opIE8PQEpw5/wUMRkNslHSvA7gZ7ncB9MUTJWKRafCOYEoxI00Hy6lW
FSqI4XiqdHKgORy3TSfinG2L0xPOS0DyJ8SFHYlwKVmBUei5Sgov+yOD4nCJhwTPlpAHhS1JtSQF
+CALxiah1nV3jSImy8DnshJXipfALEIzVDFqzCNQOs1OOH/8kPIBEMsqZiNjd2mW4VU307zMWtWb
Hlvguxi1PGscGE+nqBNwWBYrZ6Aw90JG9ikp7oJ5tjoHS6H4yHBVsqh/lTBJ7I0yqjeHmfUEUw7E
MXdzIg9MlueQ+uyruFPKHERj0404HfHdXrwM8B1Q2TGZx9eK00OmyWj9nAMVSb/8DCvbY1BZlVj2
WBBDaTULUFz7yzpQC/1uYGtlwgRtPkE9c/PFv9qBNQ+HkZR2ldxh885zR6Jey0wYp51SDJpXs1JW
5KOxg4RJGiQpMzcSWR4swWgWdYvlr4UCioHfqIYxaV1z94liHm3m6cLk3PMD4Z90O0jmzb+YCWYq
UTXxi7VsKDVyJ81G/hvIseN7DEmN52jMmHmXSl2T6y89+yvhEh5LuFRQNI3inLIQSJGSENAfPW93
sRvsodQy1wcPFPBHENX535T9NJ+qxWTptES9Bqygmr8h78rV0xaLvzuMn/KgxCO+Uvd9ITI26XwV
XGDCxDBAfDN0/G72BAFMUUutS+XKszArGilCeX9FaoUlL3NwLC8OS9RkIp0wW9JAYu8fxbIaO+eL
TLrnlNk5y3/lVr3U+IPrSZK/fF6kj7914+ek02xctfph2422SM6gMhKJ/8CS6g1eeIaV4Mge9Vrl
qyT/pR6i58q7f99z4lCD2sixT2Xbe0hlgDpdWnXCeFkZdhGIYUmbqIo0rYI5avueR9pGmEdnG6o2
0Z7gd7dnvS7EdbLWtLiVZFveVwW344icjW0y+jXQR4eku7GQBsxtvc6OMxllCju+zS2eTPadK2bm
KNHxRUfXIP50XfjD9CCwMJ0pTg0RbHxwUdYS1WcyJJaqvt4MIiTidm5Qi1XBcMxYY4guP0BtO5Fl
U7PmDxGD9yi9ncnmFJRxD+QOChdk6s2j9Vlg7i8d7TtiUWkp4oG62Y5+FnPgB8QyVaVT0TbP3DwW
tx5gVVZt/+A8/JCaAiGOkpA9seg+Ax/8smkkO955D1yCKODl8UsNfS95aJBReF9gD7ivLfm8i2d2
91tzAgsxHq1/wUHnpqHtFpS9eHOymBsRk1G+Hq17m+75c05svq8K9OnItvxm3RDVe+Jp8ZNOtvlP
zV2MMkCV+h/V/lA/SuTjn7SbcJN6VXrKiKFG+I3YUK5eXdpEQ4eH6WdJcsGUTkKOyE+PzKdDSfht
fDG40jj6x5hFoBVqgH+xNPRN/uuuju0ELThyGZaLlXYxfECA3E/QJ8+pdppyGkNMORlzxcH8lK3p
PEi36WD1jyBaSLFhpMMiSZwkchtAMYwrR+qWGXPhGPglgqzIqh4XT0AJUobXbh90GWvp9eV7hGmr
q++H/KKpEfIDyhPsQqdB/TYulq2DNsRqiALMhRMTevUGbtJoKLKYxpfHRdiLfwENdZgZYBUpoQLj
70rwMcC3TYoZAAh/1WYDao1z1V+Mg1ehWLWT1Z5F3GA0BO8mlAnWHB9BXqlUnpHsj1alIpVasXSy
oRLLbQFNe5z5ZJ7FMcXA1ByA7+HUnn9FZAYj/fvOt7gl5CksCn8U7TZW1yqIV8fsmn/7x9ZMlYiC
1BjYJL14jLo9Y5jjOHx+bG0rr1I1a5gZPVT1+bIbaxa3wyQzI9a9iXXGPzj8IDtalbOyIzQqZB/e
9p6ZBXujLnYmsQRIf51COk38zdlBSxDwYHMlppXyHtAhY9BpxY3cja2Tj7eBjAEc0zgbo14vAKMS
aRs6YnufV5/9VvFCH5vE2fNH+QvZlLlZoaMOxt6AxTgdieypbt03HjHww7615mJ5LKgehADUMjMR
IlK8VvfDZpN5w29L8gVR1Smk5YEfGJYEmkDdPFNSLEstkiC8liKsmgiL21TXG3Vj+Z/RrXYAc0Kc
c+783NsPU3FOx5yp/nA7+dGSJrIZfHl0rR95/aamuVcHqpwr5JsaiMwMW5LQioKrUA+lg/c8tg3Z
NmVOihV4NlrlUb9Yv0DI5fZxDKf+C+qqtGFHMmBANeZuSAycPrso3kBTIOw9hfjxeFyzSokpB/Wp
A/TaattXcWp24VmBhfroAwCjrtqqc86RmPx8k9MXPNkP7JhYhf1qYbOWS1SGuCT/Q7GIGZ/aTgoc
x92QflTPYUwtUIk58WIGMtEbTgThheBOXCXywHqZpZxZZiXpuc7kuE5Uz7k4KUWgR8demIXGlinf
RNvt6f2RpradYadOJOBnEbiI45mBvrwFwZrAVdHHTQoR7wrC1a/2nl8TSXD8+WNyH1+QjDpr7EcN
IY7GwsQYiIp1PDUYztpORaGP1fvq5KRldJeD2gUF9EPTh10HZyMmF8h7op+Lzrqzq5+ti3VbyBZ3
1443p7K524n/rC1D6KC6N8UEzQ2UAKaC6dLLOnN3SaZQV96pcNWa/GFYglAriFy+ZrUWf89d+2hq
tLHLrHLVE7ymmR02EtzvCwyy67dsDpJ/IsvQ8X4f4aliOKM45dVGdBZXgqAlSa48t8choWN5vnVe
atkj3BZ8oiY+a3A3gCo3kjv9RIzqCKIr648gcomckbDgeqtD8Oe77m44zCes+oph7+IqmPUKPQ9T
3VJGhB7VLB9i1XE/cuHFYOuv5289lfKdyB8TQ2175rejUsAGB5SQzjkItFu8+1iHGqMdF4EfQgt7
uDaNA70l1sUTpRsoIOfnQk6RdutdWjIMlfxqnAuOI+MZAHCIDG9GcMCAIbJeJSsEBWjLjgyEbNjg
hoxIvA+IUnlGdLELZ+vToobLo6ebO/O4r5jJQP3dp1ApGxKR0mCri9SIEB3dVxU/KoMhra3wuCjW
FRaHbK8vhbA1N+1zs0yzZ4Qo4YgG5NCJH473ahNBYfaHawt31sAzeLwb/HfC83xTZ1/tLUQo9t5E
rs1KhO/7wuPiNjcfC2ZvkkSXgu6us4YOmZiesNizYY2tdSWzI6GL1DUwEHi+Igs6rv08KSqun/Ei
HltAdpaEkjtnR0OILGHgoqoTLdrNQa+9kn2zR+6M9ZH08J1yuirw5OhSW1PuA2mMAxUMZ19yZ1W7
BuZG1+el5IicRw/CeWaf43o7YkEl1eP/Xaun4ThKILkW4vzsVCRD7xX/we7oeosEcCWTbR0oPAbX
+EiarlCQwlIkHPRgIyKrshzEe1sObhwblGM54VN+7QPHzh0nGnSj4yj1dOcCaJidppTAX7dBzbWk
vHFy/I/SoQ+8hN1H8cIrfzyCnnnxWWycspTCspum4cuI+wjpmwSrEWCclatNpsWv2H1vZoPMBj3r
yjRB71mG66SQu04GC7hKmlNu49RCx4sz/xWPywpspx9nvLRpavjMxZJwkDv0ytFg5wX3qZkJ9Lic
iTmL4LUjoivNqiWaqpWH6HFgh8ffZhsMa368M9/67LI5FqGm+AbM8kmPxLb69wNOG/nempl7jfjK
3YWu9dBHAxrUA6TayNuzdv5wve38NbMXKAl1tMWfDH+H29367Xi7vZ+w/NmiOmMZcjBIg9nfU6gk
sqQoS6iGtSZSfmIbH9/MoLXn5OaO7rONgKcfDZunG/OaScvhBnl1zD4h8k+yULGiMctxtIhym62p
VO/niXzw2W9C+YJHyHxTm5s7seXvaOAwpj9Jw3u4CA2wWm3NW0kPQGkd5gnMFXbR2GHdDHb40Xi+
w2Y8S+6f1NeCZMzS/gj6EIOyqu45HzpBD2MXQYgM83lRbNtoXDO3FBDZWv68oAubccBCtNyO5RDL
jobAlLnT9sgOnpu7TipsZ1JWM0aYMhA5WrqhB8vPwAVMvxnGcRKuoZONGx6nTS99/ERB8KmVEoQU
qhLu0uUtWbfJuEADwY4NhqCj7mTbxcso70H8pl/O34nzQnuIE9FOhVoxcAOCLNiTaehB8q5bzLil
r3DB6HorbqLxdHXZZeyYGBJP21HHkqeIorZiZZ7uGR0nXerfYPH636T5UAv3eI57DDGvEu57hZaS
Pdrx7NvmXKKdMT8lTJBp5zQraH9ZXojBKHkY5yMkPihhOrnWqToGdue6ZoylKDlXXZzsQ8SKKjs2
unWOLgFVWRaf3YVjG/FFGjB71rkwdv4gDxnmSvQS1jHDB3682i60GlrRRgg9d/VuRP8lmgyMx/Uz
daB8pcCDz5OS/yhYo/5xNMuMwrUELOBcE8PSg+7BgOWCLzJKicF6sIU3Z1IMyd8hW8u1qOx/fnc3
VE+oowt2qE6JS4mJKde28rV4/Y6W4ryRwBvq+eZeiPD9b+1ECVE2jq4OQs8xxwehORpvvqfGiBl/
IQxk95dXWKdu0Vp37N/J/OnWdq9ESl0/plvq6c8vCQkC2zkBYu4CJaTC0oDqG3PKy3kjo0RwdXk8
E6+7Wa9MHQtrsxBsxReisYKVP9+8RCmYl0vum3uNrF5iO1ubsRNKvEF3mGIwFze7BLgECKr2WEE4
SNOZGlXC498fB3QVKewwtgWEDnZTY1KtWgWUyImHE5G1fqy0jekePqV+WPb3yikpSo2uW6vHPDQF
UslSknwYxxlcFcdx+D2zpzUWFoepwhrBbZHE+A2Z4kjWbVfjFeCcRrmJICGkZCpHeCqNdnGPhqC0
oYMnNT/AM0MnVnzcPJ+hRtDWr9FMUiyL4LvGhchmgUPsrxuOK9S8n3CLYrpDuYfX5waR4fxaDuM6
rR82zV96lf7HEZcdSiuoe2FpSem07w8toVnb7dfJFKiuceQeDi6kAQTY4vVsslrMr8rbxlfF0UlX
zjT04Wj22blJltMSgzhNTSJCKL5/oHy8eYYkheC2d0r45SztI+hE48B1G1h2RwFlMKq7jICa88uX
tCQMkhWgfpobeq+LHreOCcYP1dHm1yr6j+JnWbamdR26Z9vxlpKO4CCH9ptfqqRqicuolvesuBfv
Ud+ZjhW4z5znPouv+R2cM6P125lwAim235x7wn7jhktAOGABr7RfcmWqKILCIrlSqi1b7lKsFf1C
MVHm4aFksQBAYfgq5OrouEFVOInlo9eIS8KVzZafr+iDUwSMSg1ZtM1rZmSmZJfgJzlrIoIX7yCz
SitTykM4rSTDrXgqi+CUS0LZV9JL93lodIomSAwDY+znPuDRWA==
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
