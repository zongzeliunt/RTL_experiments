
class asyn_fifo_uvm_driver_class #( 
//{{{
    parameter DATA_BITS	= 10,
    parameter FIFO_LENGTH	= 16,
	parameter ADDR_BIT = 4
) extends uvm_driver ;
    
    virtual asyn_fifo_interface.tb channel;

    function new (virtual asyn_fifo_interface.tb channel, uvm_component parent = null);
    begin
        string name = "asyn fifo uvm driver";
        
        this.channel = channel;
        class_parameters_reset();
                
        super.new(name,parent);
        `uvm_info("my_driver","new is called",UVM_LOW)
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


    task read_data (
        output bit[DATA_BITS - 1 : 0] read_data);
    //{{{
    begin
        if (channel.empty == 0) begin
            channel.read <= 1;
        end
        else begin
            channel.read <= 0;
        end

        @(posedge channel.r_clk);
        channel.read <= 0;
        read_data = channel.output_data;//外面也能直接看output_data，意义其实不大。
    end
    endtask
    //}}}


    extern virtual task uvm_write_data (uvm_phase phase);
endclass  
//}}}

task asyn_fifo_uvm_driver_class::uvm_write_data (uvm_phase phase);
//{{{
begin
    bit [asyn_fifo_uvm_driver_class::DATA_BITS - 1 : 0] data;
    data = $urandom_range(0, 2 ** asyn_fifo_uvm_driver_class::DATA_BITS - 1);
    channel.input_data <= data;
    channel.write <= 1;
    `uvm_info("asyn fifo driver",$sformatf("write data %00x",data),UVM_LOW)

    //可以直接指派TB top module.clk，但是为了保证通用最好别这么做
    //@(posedge asyn_fifo_sim_main.clk);
    @(posedge channel.w_clk);
    channel.input_data <= 10'b11_1111_1111;
    channel.write <= 0; 
end
endtask
//}}}

