////////////////////////////////////////////////
//
// Name:  Chandani Lapasia
// Design: SPI Master Controller Testbench
// Date:   1-11-2022
//
///////////////////////////////////////////////

module tb;
     reg clk, rst, new_data;
   reg [7:0] din;
   wire sclk,cs_bar, mosi; 
  
 spi_controller s0(clk,rst,new_data,din,sclk,cs_bar,mosi);

always #5 clk=~clk;
  
  initial begin
    clk=1'b0;
    rst=1'b1;
    #6 rst=1'b0;
    new_data=1'b1;
    din=$random;
    #10000 din=$random;
    #30000 $finish;
  end
  
  initial begin
    $dumpfile("spi_wave.vcd");
	$dumpvars();
  end
endmodule