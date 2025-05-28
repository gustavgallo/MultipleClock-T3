module deserializer (

input logic data_in, // recebe o valor de 1 bit
input logic write_in, // como se fosse um enter
input logic reset, 
input logic clock_100KHZ,
input logic ack_in, // para confirmar que a fila ja tratou dos dados
output logic status_out, // 1 se pode receber dados, 0 se não pode
output logic [7:0] data_out, // saída de dados do modulo
output logic data_ready // sinal pra enviar


);

//vamo simplificar as coisas, ou ta recebendo ou ta esperando e ja era
typedef enum logic [1:0] { 
    
    RECEIVE,

    WAIT

} state_t;

state_t EA;


logic [2:0] counter; // contador para saber quantos bits foram recebidos

// always de dados
always_ff @(posedge clock_100KHZ, posedge reset)begin

    if (reset)begin
        status_out <= 1; // está em condição de receber bits
        data_ready <= 0; // não ta pronto
        data_out <= 0; //zera a saída
        counter <= 0; // reseta o contador


    end
    else begin

        case(EA)

            RECEIVE:begin
                if (status_out) begin
                    if (write_in) begin // se recebeu o write_in, significa que é pra receber o dado
                        data_out <= {data_out[6:0], data_in}; // shift left e coloca o bit recebido no final
                        if (counter == 3'd7) begin // se recebeu todos os bits escreve no data_ready
                            data_ready <= 1;
                            status_out <= 0; // nao pode receber mais dados
                            
                        end
                    end
                end

            end
 
            WAIT:begin
                if (ack_in) begin // se recebeu o ack_in, significa que a fila ja tratou dos dados
                    status_out <= 1; // pode receber mais dados
                    data_ready <= 0; // nao esta pronto
                    counter <= 0; // reseta o contador
                    data_out <= 0; // reseta a saída
                end

            end

        endcase


    end // end do else
end // end do always



// always dos estados
always_ff @(posedge clock_100KHZ, posedge reset)begin

    if (reset)begin
        EA <= RECEIVE;

    end
    else begin

        case(EA)

            RECEIVE:begin
            if (status_out) EA <= RECEIVE;
            else EA <= WAIT;

            end

            WAIT:begin

            if (ack_in) EA <= RECEIVE; // se recebeu o ack_in, volta para receber dados
            else EA <= WAIT; // se n recebeu o ack_in, continua esperando


            end

        endcase


    end // end do else
end // end do always






endmodule