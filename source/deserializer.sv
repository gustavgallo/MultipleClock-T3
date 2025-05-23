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


typedef enum logic [1:0] { 
    
    RECEIVE,

    WRITE,

    SEND,

    WAIT

} state_t;

state_t EA;


// always de dados
always_ff @(posedge clock_100KHZ, posedge reset)begin

    if (reset)begin
        status_out <= 1; // está em condição de receber bits
        data_ready <= 0; // não ta pronto
        data_out <= 0; //zera a saída

    end
    else begin

        case(EA)

            RECEIVE:begin


            end

            WRITE:begin



            end

            SEND:begin



            end

            WAIT:begin


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
            if (write_in) EA <= WRITE;
            else EA <= RECEIVE;

            end

            WRITE:begin
           

            end

            SEND:begin




            end

            WAIT:begin




            end



        endcase


    end // end do else
end // end do always






endmodule