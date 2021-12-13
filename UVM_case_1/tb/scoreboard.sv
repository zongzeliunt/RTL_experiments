
class scoreboard extends uvm_scoreboard;
//{{{
    `uvm_component_utils(scoreboard)
    uvm_analysis_port # (counter_trans)  ap_objseq;
 
    scoreboard sb;
    local counter_subscriber counter_sub;
    rand bit store;
    

 
    function new (string name, uvm_component parent=null);
        //super.new(name, null);
        super.new(.name(name), .parent(parent));
    endfunction
 
    function void build_phase (uvm_phase phase);
        super.build_phase(phase);
        // ap_objseq = sequence_gen::type_id::create("ap_objseq",this);
        ap_objseq = new(
            .name("ap_objseq"),
            .parent(this)
        );
        counter_sub=counter_subscriber::type_id::create("counter_sub",this);
    endfunction

    function void connect_phase(uvm_phase phase);
        super.connect_phase(phase);
        ap_objseq.connect( counter_sub.analysis_export );
    endfunction

    /*
    task run_phase();
        //if(Bus_if1.clk) begin
            //if(!Bus_if1.reset) begin
        if(sb.clk) begin
            if(!sb.reset) begin
        //if(req.clk) begin
            //if(!req.reset) begin
                sb.store = sb.store+1;
            end
            else begin
                sb.store = 0;
            end
       end
       if(sb.store==req.data) begin
        `uvm_info("","test has been passed","UVM_LOW");
       end
    endtask
    */
endclass
//}}}
