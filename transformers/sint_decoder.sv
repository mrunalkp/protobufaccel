module  sint_decoder #(
    parameter DECODE_SIZE = 64
)(
    input logic signed [DECODE_SIZE-1:0] data_in,
    output logic signed [DECODE_SIZE-1:0] data_out,
    output logic [3:0] size_out // in bytes
);

always_comb begin
    data_out = (data_in << 1) ^ (data_in >>> (DECODE_SIZE-1));
end

assign size_out = $clog2(DECODE_SIZE);

endmodule