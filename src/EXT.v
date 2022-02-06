module EXT (
    ImmIn,
    EXTOp,
    ImmOut
);
    input [15:0] ImmIn;
    input EXTOp;
    output [31:0] ImmOut;
    assign  ImmOut = (EXTOp) ?{{16{ImmIn[15]}},{ImmIn}}:{{16{1'b0}},ImmIn};//signed ext and unsigned ext(ori

endmodule