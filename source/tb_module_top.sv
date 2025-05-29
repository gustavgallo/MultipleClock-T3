`timescale 1ns/100ps

module tb_module_top;

//geral
logic reset;
logic clock;
//queue
logic enqueue_in; 
logic dequeue_in; 
logic [3:0] len_out; 
logic [7:0] data_out; 
//deserializer
logic data_in; 
logic data_ready; 
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

  // Geração de clock
  always #1 clock = ~clock;


   initial begin
    reset = 1; #2;
    reset = 0; 
   end

   endmodule