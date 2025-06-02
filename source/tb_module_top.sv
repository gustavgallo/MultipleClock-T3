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
integer words;
logic [7:0] send_data = 8'b10000000;


initial begin
   reset = 1;
   data_in = 0;
   write_in = 0;
   dequeue_in = 0;

    #2500;
    reset = 0;
    #4000;

    forever begin
        @(posedge status);
        #10000;
        for(words = 0; words < 4; words = words + 1)begin
            for(index = 0; index < 8; index = index + 1) begin

                data_in = send_data[index];
                write_in = 1;
                #10000;
                write_in = 0;
                #10000;
            end 
            #30000;
            send_data = send_data + 1;
        end    
         #300000;
         dequeue_in = 1; // ranca fora 1
         #200000;
         dequeue_in = 0; // desiste de rancar fora
         #600000;
      $finish; // finaliza simulação
    end
end    

 endmodule