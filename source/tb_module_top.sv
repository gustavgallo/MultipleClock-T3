`timescale 1ns/100ps

module tb_module_top();



queue fila(
    .clock_10KHZ(clock_10KHZ),
    .reset(reset),
    .data_in(entrada_queue),
    .enqueue_in(enqueue_in),
    .dequeue_in(dequeue_in),
    .len_out(len_out),
    .data_out(data_out)
);

deserializer des(
    .data_in(data_in),
    .write_in(write_in),
    .reset(reset),
    .clock_100KHZ(clock_100KHZ),
    .ack_in(ack),
    .status_out(status_out),
    .data_out(entrada_queue),
    .data_ready(data_ready)
);

  // Geração de clock
  always #1 clock = ~clock;


   initial begin
    reset = 1; #2;
    reset = 0; 
   end

   endmodule