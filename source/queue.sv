module queue (

input logic [7:0] data_in,
input logic enqueue_in,
input logic dequeue_in,
input logic reset,
input logic clock_10KHZ,
output logic [3:0] len_out,
output logic [7:0] data_out

);

logic [7:0] fila [7:0];
logic [1:0] enqueue_done, dequeue_done;

typedef enum logic [1:0] { 
    
    ENQUEUE,

    DEQUEUE,

    WAIT

} state_t;

state_t EA;

//bloco de dados para tratar do enqueue e dequeue
always_ff @(posedge clock_10KHZ, posedge reset)begin
    if(reset)begin
        len_out <= 0;
        data_out <= 0;
        
        enqueue_done <= 0;
        dequeue_done <= 0;
        fila <= 0;

    end else 
    begin
        case(EA)

            ENQUEUE:begin
                
                if(len_out < 4'd8)begin

                fila[len_out] <= data_in;
                if(len_out != 4'd7) len_out <= len_out + 1;
                enqueue_done <= 1;


                end
                
            end

            DEQUEUE:begin
            if(len_out > 0) begin

                data_out <= fila[0];
                fila[0] <= fila[1];
                fila[1] <= fila[2];
                fila[2] <= fila[3];
                fila[3] <= fila[4];
                fila[4] <= fila[5];
                fila[5] <= fila[6];
                fila[6] <= fila[7];
                fila[7] <= 0;
                len_out <= len_out - 1;
                dequeue_done <= 1;

            end

            end

            WAIT:begin
                dequeue_done <= 0;
                enqueue_done <= 0;

              
            end

        endcase
    end
end

// always da máquina de estados
always_ff @(posedge clock_10KHZ, posedge reset)begin

    if(reset)begin

        EA <= WAIT;

    end else 
    begin
        case(EA)

            ENQUEUE:begin
                if(enqueue_done) EA <= WAIT;
                else EA <= ENQUEUE;

            end

            DEQUEUE:begin
                if(dequeue_done) EA <= WAIT;
                else EA <= DEQUEUE;

            end
            WAIT:begin

                if(enqueue_in) EA <= ENQUEUE;
                else if(dequeue_in) EA <= DEQUEUE;
                else EA <= WAIT;
            end

        endcase
    end
end


endmodule