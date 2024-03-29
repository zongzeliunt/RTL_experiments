
// environment defination 
class environment extends uvm_env;
//{{{
    `uvm_component_utils(environment)
    
    //ARES 大概没用
    //uvm_analysis_port # (counter_trans)   ap_objseq;
 
    agent agt;
    //coverage cov;
    scoreboard sb;
    counter_subscriber count_sub;
 
 
    function new(string name, uvm_component parent=null);
        //super.new(name, null);
        super.new(.name(name), .parent(parent));
    endfunction
 
    function void build_phase(uvm_phase phase);
        agt = agent::type_id::create("agt",this);
        // seq_env = sequence_gen :: type_id::create("seq_env",this);
        //cov = coverage :: type_id::create("cov",this);
        sb = scoreboard :: type_id::create("sb",this);
        count_sub=counter_subscriber::type_id::create("count_sub",this);
    endfunction
 
    function void connect_phase(uvm_phase phase);
        super.connect_phase(phase);
        //ARES
        //agt.ap_objseq.connect(cov.analysis_export);
        //agt.ap_objseq.connect(sb.analysis_export);
        //agt.ap_objseq.connect(count_sub.analysis_export);


        //cov.analysis_export.connect(agt.ap_objseq);
        //sb.ap_objseq.connect(agt.ap_objseq);
        //count_sub.analysis_export.connect(agt.ap_objseq);


        agt.ap_objseq.connect(sb.ap_objseq);
        //agt.ap_objseq.connect(count_sub.ap_objseq);


    endfunction
endclass
//}}}
