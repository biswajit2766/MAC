// Code your testbench here
// or browse Examples
`timescale 1ns/1ps

module mac_tb;
  reg sys_clock, sclr, load;
  reg[3:0] a, b;
  wire[3:0] product, sum, mac_out;
  
  mac uut(
    .sys_clock(sys_clock),
    .sclr(sclr),
    .load(load),
    .a(a),
    .b(b),
    .product(product),
    .sum(sum),
    .mac_out(mac_out));
  
  time clock_period = 100;
  
  initial begin
    sys_clock = 0;
    
    forever begin
      #(clock_period/2);
      sys_clock =~ sys_clock;
    end
  end
  
  initial begin
    sclr = 0; load = 0;
    
    fork
      forever begin
        #15360;
        sclr =~ sclr;
      end
      forever begin
        #30720;
        load =~ load;
      end
    join
  end
    
  initial begin
    a = 0; b = 0;

    fork
      forever begin
        #60;
        a = a + 1'b1;
      end
      forever begin
        #960;
        b = b + 1'b1;
      end
    join
  end
    
  time run_time = 61440;

  initial begin
    #run_time;
    $finish;
  end
  
  initial begin
    $dumpfile("dump.vcd");
    $dumpvars(0, mac_tb);
  end
endmodule