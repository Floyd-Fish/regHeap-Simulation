/***** Time scale *****/
`timescale 1ns/1ps

/***** Header File *****/
`include "regfile.h"

/***** Modules *****/
module regfile_test;
    /***** I/O Signals *****/
    //Clock & Reset 
    reg             clk;        //clock
    reg             reset_;     //Reset (Logic 0)
    //Access Interface
    reg [`AddrBus] addr;        //Address
    reg [`DataBus] d_in;        //Input Data
    reg             we_;        //Write Enable (Logic 0)
    wire [`DataBus] d_out;      //Output Data
    /***** Internal Variables *****/
    integer         i;          //Iterator
    /***** Define Simulation loop *****/
    parameter       STEP = 100.0000;     //10 M

    /***** Generate Clock Signal *****/
    always #(STEP/ 2 ) begin
        clk <= ~ clk;
    end

    /***** Instantiate Test_Bench *****/
    regfile regfile (
        /***** Clock & Reset *****/
        .clk        (clk),          //Clock
        .reset_     (reset_),       //Reset (Logic 0)
        /***** Access Interface *****/
        .addr       (addr),         //Address
        .d_in       (d_in),         //Input Data
        .we_        (we_),          //Write Enable (Logic 0)
        .d_out      (d_out)         //Output data    
    );

    /***** Example for test *****/
    initial begin
        # 0 begin 
            clk     <= `HIGH;
            reset_  <= `ENABLE_;
            addr    <= {`ADDR_W{1'b0}};
            d_in    <= {`DATA_W{1'b0}};
            we_     <= `DISABLE_;
        end
        # (STEP *3 / 4)
        # STEP begin
            reset_ <= `DISABLE_;    //Release Reset
        end
        # STEP begin 
            for (i = 0; i < `DATA_D; i = i + 1) begin
                # STEP begin
                    addr    <= i;
                    d_in    <= i;
                    we_     <= `ENABLE_;
                end
                # STEP begin
                    addr    <= {`ADDR_W{1'b0}};
                    d_in    <= {`DATA_W{1'b0}};
                    we_     <= `DISABLE_;
                    if (d_out == i) begin
                        $display ($time, " ff[%d] Read/Write Check OK !", i);
                    end else begin
                        $display ($time, " ff[%d] Read/Write Check NG !", i);
                    end
                end
            end
        end
        # STEP begin
            $finish;
        end
    end
    
    initial begin
        $dumpfile("regfile.vcd");
        $dumpvars(0, regfile);
    end

endmodule
