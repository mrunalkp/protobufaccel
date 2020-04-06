module requester #(
    parameter LINE_SIZE = 512,
    parameter PTR_SIZE = 4,
    parameter FIELD_SIZE = 4
) (
    input clk,
    input logic [LINE_SIZE-1:0] line_in
);

logic [79:0] encoded_header;
logic [63:0] decoded_header;
logic [4:0] size_header;

varint_decoder varint_decoder#(
    .DECODE_SIZE(64)
)(
    .data_in(encoded_header),
    .data_out(decoded_header),
    .size_out(size_header)
);

logic [60:0] field_id;
logic [2:0] field_type;
always_comb begin : field_decoder
    // TODO: set encoded_header from the line that was read
    field_id = decoded_header[63:3];
    field_type = decoded_header[2:0];
end



always_ff @(posedge clk) begin
    
end

endmodule