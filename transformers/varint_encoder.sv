module  varint_encoder #(
    parameter DECODE_SIZE = 64,
    parameter ENCODE_SIZE = ((DECODE_SIZE-1)/7 + 1)*8
)(
    input logic [DECODE_SIZE-1:0] data_in,
    output logic [ENCODE_SIZE-1:0] data_out,
    output logic [3:0] size_out // in bytes
);
    
local parameter ENCODE_BYTES = ENCODE_SIZE/8
local parameter TEMP_SIZE = ((DECODE_SIZE+1)/ENCODE_BYTES)*DECODE_SIZE;

logic [ENCODE_SIZE-1:0] data_temp;
logic [0:ENCODE_BYTES-1] nextbyte; // next byte bit vector 
logic [3:0] size_adder, size; 

bit_adder_tree addtree(.data_in(nextbyte), .size(size_adder));

always_comb begin
    
    data_temp = data_in;
    for (int i = 0; i < ENCODE_BYTES; i++) begin
        data_out[(ENCODE_BYTES-1-i)*8+6:(ENCODE_BYTES-1-i)*8] = data_temp[i*7+6:i*7]; // move data around
        nextbyte[i] = |data_temp[i*7+6:i*7]; // or reduce (| 0'b1010)
    end
    
    // size and decoder
    size = size_adder;
    case (size_adder)
        4'h1: begin
            data_out[7] = 0;
        end
        4'h2: begin
            genvar i2;
            for (i2 = 1; i2 < 2; i2++) begin
                data_out[i2*7] = 1;
            end
            data_out[i2*7] = 0;
        end
        4'h3: begin
            genvar i3;
            for (i3 = 1; i3 < 3; i3++) begin
                data_out[i3*7] = 1;
            end
            data_out[i3*7] = 0;
        end
        4'h4: begin
            genvar i4;
            for (i4 = 1; i4 < 4; i4++) begin
                data_out[i4*7] = 1;
            end
            data_out[i4*7] = 0;
        end
        4'h5: begin
            genvar i5;
            for (i5 = 1; i5 < 5; i5++) begin
                data_out[i5*7] = 1;
            end
            data_out[i5*7] = 0;
        end
        4'h6: begin
            genvar i6;
            for (i6 = 1; i6 < 6; i6++) begin
                data_out[i6*7] = 1;
            end
            data_out[i6*7] = 0;
        end
        4'h7: begin
            genvar i7;
            for (i7 = 1; i7 < 7; i7++) begin
                data_out[i7*7] = 1;
            end
            data_out[i7*7] = 0;
        end
        4'h8: begin
            genvar i8;
            for (i8 = 1; i8 < 8; i8++) begin
                data_out[i8*7] = 1;
            end
            data_out[i8*7] = 0;
        end
        4'h9: begin
            genvar i9;
            for (i9 = 1; i9 < 9; i9++) begin
                data_out[i9*7] = 1;
            end
            data_out[i9*7] = 0;
        end
        4'ha: begin
            genvar i10;
            for (i10 = 1; i10 < 10; i10++) begin
                data_out[i10*7] = 1;
            end
            data_out[i10*7] = 0;
        end
        default: begin 
            size = 0;
            data_out = 0;
        end
    endcase 

end

assign size_out = size;

endmodule