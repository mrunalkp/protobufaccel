module  varint_decoder #(
    parameter DECODE_SIZE = 64,
    parameter ENCODE_SIZE = ((DECODE_SIZE-1)/7 + 1)*8
)(
    input logic [ENCODE_SIZE-1:0] data_in,
    output logic [DECODE_SIZE-1:0] data_out,
    output logic [3:0] size_out // in bytes
);

local parameter ENCODE_BYTES = ENCODE_SIZE/8
local parameter TEMP_SIZE = ((DECODE_SIZE+1)/ENCODE_BYTES)*DECODE_SIZE;

logic [7:0] data;
logic [TEMP_SIZE-1:0] out_temp;
logic [0:ENCODE_BYTES] cond;
logic [3:0] size;

bit_adder_tree addtree(.data_in(cond[0:ENCODE_BYTES-1]), .size(size));

always_comb begin
    cond[0] = 1;
    out_temp = 0;
    for (int i = 0, int j = ENCODE_BYTES-1; i < ENCODE_BYTES; i++, j--) begin
        data = data_in[8*j+7:8*j];
        if (cond[i]) begin
            out_temp[7*i+6:7*i] = data[6:0];
        end
        cond[i+1] = cond[i] & data[7];
    end
end

assign data_out = out_temp[DECODE_SIZE-1:0];
assign size_out = size;

endmodule