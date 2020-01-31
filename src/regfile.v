/***** Include Header File *****/
`include "regfile.h"

/***** Module *****/
module regfile (
    /***** Time_clock and Reset *****/
    input wire              clk,        //Clock
    input wire              reset_,     //Asynchronous Reset (Logic 0)

    /***** Access Interface *****/
    input wire [`AddrBus] addr,         //Address
    input wire [`DataBus] d_in,         //Input Data
    input wire             we_,         //Written enable (Logic 0)
    output wire [`DataBus] d_out        //Output Data
);

    /***** Internal signals *****/
    reg [`DataBus]          ff [`DATA_D-1:0];   //Register sequence
    integer                 i;                  //Iterator

    /***** Read Accessory *****/
    assign d_out = ff[addr];

    /***** Write Accessory *****/
    always @(posedge clk or negedge reset_) begin
        if (reset_ == `ENABLE_) begin
            /***** Asynchronous Reset *****/
            for (i = 0; i < `DATA_D; i = i + 1) begin
                ff[i]    <= #1 {`DATA_W{1'b0}};
            end
        end else begin
            /***** Write Accessory *****/
            if (we_ == `ENABLE_) begin
                ff[addr] <= #1 d_in;
            end
        end
    end
endmodule