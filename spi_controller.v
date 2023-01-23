////////////////////////////////////////////////
//
// Name:  Chandani Lapasia
// Design: SPI Master Controller
// Date:   1-11-2022
//
///////////////////////////////////////////////


module spi_controller (clk,rst,new_data,din,sclk,cs_bar,mosi);
  input clk, rst, new_data;
  input [7:0] din;
  output reg sclk,cs_bar, mosi;

  int count=32'd0;
  int count_spi=32'd0;
  
  typedef enum bit [1:0] {idle=2'b00, send=2'b01} my_state;
  my_state state;
  
  
  always @(posedge clk) begin
    if(rst)
      begin
        sclk=1'b0;
        count=32'd0;
      end
  else 
    if(count < 50) begin
      sclk<= sclk;
      count<=count+1; end
    else  begin
      sclk<=~sclk;
      count<=32'd0; end
      
  end
  
  always @(posedge sclk)
    begin
      if(rst) 
        begin 
          cs_bar<=1'b1;
          mosi<= 1'bx;
          state<=idle;
        end
      else
        case (state)
        
      idle : begin  
        if(new_data==1)
        begin
          state <=send;
          cs_bar<= 1'b0;
          $strobe($time, "din=%b",din);
    	end
        else begin
          state <=idle;
          cs_bar<=1'b1;
      end
      end
          
          send : begin
        if(count_spi < 8) begin
           mosi<= din[count_spi];
          $strobe($time, "mosi=%d, count_spi=%d", mosi, count_spi);
          count_spi<=count_spi+1;
        end
          else begin
            count_spi<=32'd0;
      	    mosi<=1'bx;
            state<=idle;	
	        cs_bar<=1'b1;
          end
          end
        endcase
    	end 
          endmodule     