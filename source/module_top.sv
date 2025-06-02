module top(

//geral
input logic reset,
input logic clock,
//queue
input logic dequeue_in, //se é pra dar dequeue
output logic [3:0] len_out, // tamanho da fila
output logic [7:0] data_out, // dado que foi retirado da fila
//deserializer
input logic data_in, // entrada pro deserializador
output logic status_out, // 1 se ta recebendo dados, 0 se não
input logic write_in// como se fosse um enter

);

logic clock_100KHz, clock_10KHz; // clocks para os modulos
logic [7:0] entrada_queue; // saída de dados do modulo desearializador
logic enable_queue; // sinal de habilitação para a fila
logic ack = 0; // sinal de confirmação que a fila ja tratou dos dados
logic [1:0] EA_des;
logic [1:0] EA_queue;



queue fila(
    .clock_10KHZ(clock_10KHz),
    .reset(reset),
    .data_in(entrada_queue),
    .enqueue_in(enable_queue),
    .dequeue_in(dequeue_in),
    .len_out(len_out),
    .data_out(data_out),
    .EA_queue(EA_queue)
);

deserializer des(
    .data_in(data_in),
    .write_in(write_in),
    .reset(reset),
    .clock_100KHZ(clock_100KHz),
    .ack_in(ack),
    .status_out(status_out),
    .data_out(entrada_queue),
    .data_ready(enable_queue),
    .EA_des(EA_des)
);
// counter para cada um dos clocks
logic [3:0] counter_100KHz = 0; 
logic [6:0] counter_10KHz = 0; 


  always_ff @(posedge clock) begin
        if (reset) begin // zera tudo necessário
            counter_100KHz <= 0;
            counter_10KHz  <= 0;
            clock_100KHz   <= 0;
            clock_10KHz    <= 0;
        end else begin
            if (counter_100KHz == 4'd4) begin // conta de 0 a 4, então, quando for 4, muda o sinal do clk
                clock_100KHz <= ~clock_100KHz; // muda sinal
                counter_100KHz <= 0;         // zera o count
            end else begin
                counter_100KHz <= counter_100KHz + 1; // count++
            end

            if (counter_10KHz == 7'd49) begin  // conta de 0 a 49, então, quando for 49, muda o clk
                clock_10KHz <= ~clock_10KHz; // muda sinal
                counter_10KHz <= 0;        // zera o count
            end else begin
                counter_10KHz <= counter_10KHz + 1; // count++
            end
        end
    end



// tentando gerar o ack, não sei se vai funcionar nesse jeito, to tentando pegar as atualizações dele
logic [3:0] len_out_prev;

always_ff @(posedge clock_100KHz or posedge reset) begin
    if (reset) begin
        ack <= 0;
        len_out_prev <= 0;
    end else begin
        // Gera ack quando len_out aumenta (enqueue realizado)
        if ((len_out != len_out_prev))
            ack <= 1;
        else
            ack <= 0;
        len_out_prev <= len_out;
    end
end

endmodule

// não pode adicionar mais saidas nos módulos q o professor deu, tem q usa o que tem