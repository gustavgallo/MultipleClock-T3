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

logic clock_100KHZ, clock_10KHZ; // clocks para os modulos
logic [7:0] entrada_queue; // saída de dados do modulo desearializador
logic enable_queue; // sinal de habilitação para a fila
logic ack; // sinal de confirmação que a fila ja tratou dos dados


queue fila(
    .clock_10KHZ(clock_10KHZ),
    .reset(reset),
    .data_in(entrada_queue),
    .enqueue_in(enable_queue),
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
    .data_ready(enable_queue)
);

logic [5:0] clock_counter;

always_ff @(posedge clock, posedge reset) begin
    if (reset) begin
        clock_100KHZ <= 0;
        clock_10KHZ <= 0;
        clock_counter <= 0; // reseta o contador de ciclos do clock principal
    end else begin
        // Gera os clocks de 100KHz e 10KHz a partir do clock principal
        if(clock_counter == 6'd4)begin
        clock_100KHZ <= ~clock_100KHZ; // cada ciclo atualiza
        end
        clock_counter <= clock_counter + 1; // incrementa o contador de ciclos
        if (clock_counter == 6'd49) begin
            clock_10KHZ <= ~clock_10KHZ; // atualiza a cada 10 ciclos do clock_100KHZ
            clock_counter <= 0; // reseta o contador de ciclos
        end
    end
end
// tentando gerar o ack, não sei se vai funcionar nesse jeito, to tentando pegar as atualizações dele
logic [3:0] len_out_prev;

always_ff @(posedge clock_10KHZ or posedge reset) begin
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