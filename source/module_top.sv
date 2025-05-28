module top(

//geral
input logic reset,
input logic clock,
//queue
input logic enqueue_in,
input logic dequeue_in,
output logic [3:0] len_out,
output logic [7:0] data_out,
//deserializer
input logic data_in, // entrada pro deserializador
output logic data_ready // sinal pra enviar
output logic status_out, // 1 se pode receber dados, 0 se não pode
input logic write_in, // como se fosse um enter



);

logic clock_100KHZ, clock_10KHZ;
output logic [7:0] entrada_queue, // saída de dados do modulo desearializador
logic ack;


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
    .verifica(verifica),
    .ack_in(ack),
    .status_out(status_out),
    .data_out(entrada_queue),
    .data_ready(data_ready)
);



endmodule

always_ff @(posedge clock_100KHZ, posedge reset)begin
    if(data_ready) begin // enquanto o deserializer ainda estiver funcionando, o queue tem que ficar parado
        verifica <= 1; // proximo clock o queue vai começar a dar enqueue nos numeros do deserializer
    end
end