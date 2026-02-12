/////////////////////////////////////////////////////////////
// Created by: Synopsys DC Ultra(TM) in wire load mode
// Version   : X-2025.06-SP4
// Date      : Wed Feb 11 22:45:33 2026
/////////////////////////////////////////////////////////////


module rca ( A, B, Cin, Cout, S );
  input [3:0] A;
  input [3:0] B;
  output [3:0] S;
  input Cin;
  output Cout;
  wire   n19, n20, n21, n22, n23, n24, n25, n26, n27, n28, n29, n30, n31, n32,
         n33, n34, n35, n36, n37, n38, n39, n40, n41, n42, n43, n44, n45, n46,
         n47, n48, n49, n50, n51, n52, n53, n54, n55, n56, n57, n58, n59, n60,
         n61, n62, n63, n64, n65, n66, n67;

  IVI U24 ( .A(Cin), .Z(n47) );
  B4IP U25 ( .A(A[0]), .Z(n19) );
  IVI U26 ( .A(A[0]), .Z(n43) );
  B4IP U27 ( .A(B[0]), .Z(n20) );
  IVI U28 ( .A(B[0]), .Z(n44) );
  B4IP U29 ( .A(A[1]), .Z(n21) );
  IVI U30 ( .A(A[1]), .Z(n41) );
  B4IP U31 ( .A(B[1]), .Z(n22) );
  IVI U32 ( .A(B[1]), .Z(n42) );
  ND2I U33 ( .A(A[0]), .B(B[0]), .Z(n23) );
  IVI U34 ( .A(Cin), .Z(n24) );
  ND2I U35 ( .A(n42), .B(n41), .Z(n25) );
  ND2I U36 ( .A(A[1]), .B(B[1]), .Z(n26) );
  NR2I U37 ( .A(B[2]), .B(A[2]), .Z(n35) );
  B4IP U38 ( .A(A[2]), .Z(n27) );
  B4IP U39 ( .A(B[2]), .Z(n28) );
  ND2I U40 ( .A(n47), .B(n23), .Z(n29) );
  ND2I U41 ( .A(n44), .B(n43), .Z(n30) );
  ND2I U42 ( .A(n20), .B(n19), .Z(n31) );
  ND2I U43 ( .A(n45), .B(n31), .Z(n32) );
  IVDAP U44 ( .A(B[3]), .Y(n34) );
  IVDAP U45 ( .A(A[3]), .Y(n33) );
  ND2I U46 ( .A(n34), .B(n33), .Z(n37) );
  ND2I U47 ( .A(B[3]), .B(A[3]), .Z(n38) );
  ND2I U48 ( .A(n35), .B(n38), .Z(n36) );
  AN2I U49 ( .A(n37), .B(n36), .Z(n51) );
  IVDAP U50 ( .A(n38), .Y(n40) );
  ND2I U51 ( .A(B[2]), .B(A[2]), .Z(n39) );
  ND2I U52 ( .A(A[1]), .B(B[1]), .Z(n57) );
  ND2I U53 ( .A(n39), .B(n57), .Z(n61) );
  NR2I U54 ( .A(n40), .B(n61), .Z(n49) );
  ND2I U55 ( .A(n22), .B(n21), .Z(n45) );
  ND2I U56 ( .A(n25), .B(n30), .Z(n64) );
  IVI U57 ( .A(n64), .Z(n48) );
  ND2I U58 ( .A(A[0]), .B(B[0]), .Z(n46) );
  ND2I U59 ( .A(n24), .B(n46), .Z(n60) );
  ND2I U60 ( .A(n48), .B(n29), .Z(n56) );
  ND2I U61 ( .A(n49), .B(n56), .Z(n50) );
  ND2I U62 ( .A(n51), .B(n50), .Z(n52) );
  IVI U63 ( .A(n52), .Z(Cout) );
  ENI U64 ( .A(B[0]), .B(A[0]), .Z(n53) );
  ENI U65 ( .A(n53), .B(Cin), .Z(S[0]) );
  ND2I U66 ( .A(n31), .B(n29), .Z(n55) );
  ENI U67 ( .A(n22), .B(A[1]), .Z(n54) );
  ENI U68 ( .A(n55), .B(n54), .Z(S[1]) );
  ND2I U69 ( .A(n26), .B(n56), .Z(n59) );
  ENI U70 ( .A(B[2]), .B(A[2]), .Z(n58) );
  ENI U71 ( .A(n59), .B(n58), .Z(S[2]) );
  ND2I U72 ( .A(n28), .B(n27), .Z(n62) );
  ND2I U73 ( .A(n62), .B(n60), .Z(n65) );
  ND2I U74 ( .A(n62), .B(n61), .Z(n63) );
  AO7P U75 ( .A(n65), .B(n32), .C(n63), .Z(n67) );
  ENI U76 ( .A(B[3]), .B(A[3]), .Z(n66) );
  ENI U77 ( .A(n67), .B(n66), .Z(S[3]) );
endmodule

