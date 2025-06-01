`timescale 1ns/100ps

module tb_module_top;

   //geral
   logic reset = 0;
   logic clock = 0;
   //queue
   
   logic dequeue_in; //escreve
   logic [3:0] len_out; 
   logic [7:0] data_out; 
   //deserializer
   logic data_in; // envia dados
   logic status; 
   logic write_in;

   // Instância do DUT (Device Under Test)
   top main(

      .reset(reset),
      .clock(clock),
      .dequeue_in(dequeue_in),
      .len_out(len_out),
      .data_out(data_out),
      .data_in(data_in),
      .status_out(status),
      .write_in(write_in)

   );
   
   always begin
       #500; clock <= ~clock; // clock de 1 MHz
   end

integer index;
integer index2;

logic [7:0] send_data = 8'b10011001;
logic [7:0] send_data2 = 8'b11110000;


initial begin
    reset = 1;
    data_in = 0;
    write_in = 0;

    #2500;
    reset = 0;
    #4000;

    forever begin
        @(posedge status);
        #10000;
        for(index = 0; index < 8; index = index + 1) begin

            data_in = send_data[index];
            write_in = 1;
            #10000;
            write_in = 0;
            #10000;
        end
         // testando escrever 2 words na fila
         for(index2 = 0; index2 < 8; index2 = index2 + 1) begin

            data_in = send_data2[index2];
            write_in = 1;
            #10000;
            write_in = 0;
            #10000;
        end

         dequeue_in = 1; // ranca fora 1
         #10000;
         dequeue_in = 0; // desiste de rancar fora
         #10000;

    end
end    

 endmodule