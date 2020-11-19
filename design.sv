// Code your design here
`timescale 1ns/1ps

module mac(
  input wire sys_clock, sclr, load,
  input wire[3:0] a, b,
  output reg[3:0] product, sum, mac_out);
  
  always @ (a, b) begin
    product = a * b;
  end
  
  always @ (product, mac_out) begin
    sum = product + mac_out;
  end
  
  always @ (posedge sys_clock) begin
    if(sclr) mac_out <= 'b0;
    else if(load) mac_out <= sum;
  end
endmodule