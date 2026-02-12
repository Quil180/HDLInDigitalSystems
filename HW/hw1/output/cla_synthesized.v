/////////////////////////////////////////////////////////////
// Created by: Synopsys DC Ultra(TM) in wire load mode
// Version   : X-2025.06-SP4
// Date      : Wed Feb 11 22:35:44 2026
/////////////////////////////////////////////////////////////


module cla ( A, B, Cin, Cout, S );
  input [3:0] A;
  input [3:0] B;
  output [3:0] S;
  input Cin;
  output Cout;
  wire   n25, n26, n27, n28, n29, n30, n31, n32, n33, n34, n35, n36, n37, n38,
         n39, n40, n41, n42, n43, n44, n45, n46, n47, n48, n49, n50, n51, n52,
         n53, n54, n55, n56, n57, n58, n59, n60, n61, n62, n63, n64, n65, n66,
         n67, n68, n69, n70, n71, n72, n73;

  IVI U27 ( .A(Cin), .Z(n53) );
  B4IP U28 ( .A(A[0]), .Z(n25) );
  IVI U29 ( .A(A[0]), .Z(n49) );
  B4IP U30 ( .A(B[0]), .Z(n26) );
  IVI U31 ( .A(B[0]), .Z(n50) );
  B4IP U32 ( .A(A[1]), .Z(n27) );
  IVI U33 ( .A(A[1]), .Z(n47) );
  B4IP U34 ( .A(B[1]), .Z(n28) );
  IVI U35 ( .A(B[1]), .Z(n48) );
  ND2I U36 ( .A(A[0]), .B(B[0]), .Z(n29) );
  IVI U37 ( .A(Cin), .Z(n30) );
  ND2I U38 ( .A(n48), .B(n47), .Z(n31) );
  ND2I U39 ( .A(A[1]), .B(B[1]), .Z(n32) );
  NR2I U40 ( .A(B[2]), .B(A[2]), .Z(n41) );
  B4IP U41 ( .A(A[2]), .Z(n33) );
  B4IP U42 ( .A(B[2]), .Z(n34) );
  ND2I U43 ( .A(n53), .B(n29), .Z(n35) );
  ND2I U44 ( .A(n50), .B(n49), .Z(n36) );
  ND2I U45 ( .A(n26), .B(n25), .Z(n37) );
  ND2I U46 ( .A(n51), .B(n37), .Z(n38) );
  IVDAP U47 ( .A(B[3]), .Y(n40) );
  IVDAP U48 ( .A(A[3]), .Y(n39) );
  ND2I U49 ( .A(n40), .B(n39), .Z(n43) );
  ND2I U50 ( .A(B[3]), .B(A[3]), .Z(n44) );
  ND2I U51 ( .A(n41), .B(n44), .Z(n42) );
  AN2I U52 ( .A(n43), .B(n42), .Z(n57) );
  IVDAP U53 ( .A(n44), .Y(n46) );
  ND2I U54 ( .A(B[2]), .B(A[2]), .Z(n45) );
  ND2I U55 ( .A(A[1]), .B(B[1]), .Z(n63) );
  ND2I U56 ( .A(n45), .B(n63), .Z(n67) );
  NR2I U57 ( .A(n46), .B(n67), .Z(n55) );
  ND2I U58 ( .A(n28), .B(n27), .Z(n51) );
  ND2I U59 ( .A(n31), .B(n36), .Z(n70) );
  IVI U60 ( .A(n70), .Z(n54) );
  ND2I U61 ( .A(A[0]), .B(B[0]), .Z(n52) );
  ND2I U62 ( .A(n30), .B(n52), .Z(n66) );
  ND2I U63 ( .A(n54), .B(n35), .Z(n62) );
  ND2I U64 ( .A(n55), .B(n62), .Z(n56) );
  ND2I U65 ( .A(n57), .B(n56), .Z(n58) );
  IVI U66 ( .A(n58), .Z(Cout) );
  ENI U67 ( .A(B[0]), .B(A[0]), .Z(n59) );
  ENI U68 ( .A(n59), .B(Cin), .Z(S[0]) );
  ND2I U69 ( .A(n37), .B(n35), .Z(n61) );
  ENI U70 ( .A(n28), .B(A[1]), .Z(n60) );
  ENI U71 ( .A(n61), .B(n60), .Z(S[1]) );
  ND2I U72 ( .A(n32), .B(n62), .Z(n65) );
  ENI U73 ( .A(B[2]), .B(A[2]), .Z(n64) );
  ENI U74 ( .A(n65), .B(n64), .Z(S[2]) );
  ND2I U75 ( .A(n34), .B(n33), .Z(n68) );
  ND2I U76 ( .A(n68), .B(n66), .Z(n71) );
  ND2I U77 ( .A(n68), .B(n67), .Z(n69) );
  AO7P U78 ( .A(n71), .B(n38), .C(n69), .Z(n73) );
  ENI U79 ( .A(B[3]), .B(A[3]), .Z(n72) );
  ENI U80 ( .A(n73), .B(n72), .Z(S[3]) );
endmodule

