`ifndef __REGFILE_HEADER__
    `define __REGFILE_HEADER__

    /***** Signal Voltage level *****/
    `define HIGH                1'b1    //High level
    `define LOW                 1'b0    //Low level

    /***** Logic Value *****/
    `define ENABLE_             1'b0    //Low level
    `define DISABLE_            1'b1    //High level

    /***** Data *****/
    `define DATA_W              32      //Data Width
    `define DataBus             31:0    //Data Bus
    `define DATA_D              32      //Data Depth

    /***** Address *****/
    `define ADDR_W              5       //Addr Width
    `define AddrBus             4:0     //Addr Bus

`endif
