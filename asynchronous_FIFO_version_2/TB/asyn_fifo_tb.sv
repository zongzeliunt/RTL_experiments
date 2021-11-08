`timescale 1 ns / 1 ps

class asyn_fifo_driver_class #(

    parameter DATA_BITS	= 10,
    parameter FIFO_LENGTH	= 16,
	parameter ADDR_BIT = 4


);
    virtual asyn_fifo_interface.tb channel;


    function new (virtual asyn_fifo_interface.tb channel);
    begin
        this.channel = channel;
        class_parameters_reset();
    end
    endfunction

    function class_parameters_reset ();
    //{{{
    begin
        channel.input_data <= 0;
        channel.read        <= 0;
        channel.write       <= 0; 
    end
    endfunction
    //}}}

    task write_data (
        bit[DATA_BITS - 1 : 0] data);
    begin
        channel.input_data <= data;
        channel.write <= 1;
        //可以直接指派module.clk，但是为了保证通用最好别这么做
        //@(posedge asyn_fifo_sim_main.clk);
        @(posedge channel.clk);
        channel.input_data <= 10'b11_1111_1111;
        channel.write <= 0; 
    end
    endtask


endclass  





