`timescale 1ns/100ps

module tb_module_top;

   //geral
   logic reset = 0;
   logic clock = 0;
   //queue
   logic enqueue_in; //escreve
   logic dequeue_in; //escreve
   logic [3:0] len_out; 
   logic [7:0] data_out; 
   //deserializer
   logic data_in; // escreve
   logic data_ready; // escreve
   logic status_out; 
   logic write_in;

   // Instância do DUT (Device Under Test)
   top main(

      .reset(reset),
      .clock(clock),
      .enqueue_in(enqueue_in),
      .dequeue_in(dequeue_in),
      .len_out(len_out),
      .data_out(data_out),
      .data_in(data_in),
      .data_ready(data_ready),
      .status_out(status_out),
      .write_in(write_in)

   );
   initial begin
      reset <= 1;
      #100;
      reset <= 0;
   end
   always begin
       #500; clock <= ~clock; // clock de 1 MHz
   end
   initial begin 
      #500;
      data_in <= 0; #600;
      data_in <= 1; #600;
      data_in <= 0; #600;
      data_in <= 1; #600;
      data_in <= 0; #600;
      data_in <= 0; #600;
      data_in <= 1; #600;
      data_in <= 0; #600; // o código "01010010" significa: R

      enqueue_in <= 1; #600;
      dequeue_in <= 1; #600;

      #5000;
      $finish;
   end

 endmodule