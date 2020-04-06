module bit_adder_tree #(
    parameter NBITS = 10,
    parameter LEVELS = $clog2(NBITS),
    parameter SIZE = 1 << LEVELS
)(
    input  logic [NBITS-1:0] data_in,
    output logic [LEVELS-1:0] size
);

logic [LEVELS-1:0] sum [0:(SIZE*2)-1];
logic [SIZE-1:0] data;

always_comb begin
    data = data_in;
    genvar i, j, k, base, n;
    generate
    for (i = 0; i < SIZE; i++) begin
        sum[i] = data[i];
    end
    for (i = 0; i < LEVELS; i++) begin
        n = 1 << (LEVELS - i);
        for (j = base, k = base+n; j < base + n; j+=2, k++) begin
            sum[k] = sum[j] + sum[j+1];
        end
        base += n;
    end
    endgenerate
end

assign size = sum[(SIZE*2)-2];