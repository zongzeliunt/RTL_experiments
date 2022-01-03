//class test_case extends uvm_sequence#(Item);
class test_case extends uvm_sequence#(Item);
    `uvm_object_utils(test_case)

    function new(string name="test_case");
        super.new(name);
    endfunction

    Item m_item = Item::type_id::create("m_item");

    extern virtual task send_w ();
    extern virtual task send_r ();
    

    virtual task body ();
        //$display ("ARES this is testcase body");
        send_w();
        send_r();
    endtask

endclass

task test_case::send_w();
    //$display ("ARES this is testcase send_w");
    start_item(m_item);
    m_item.randomize();
    m_item.write = 1;
    m_item.read = 0;
    `uvm_info("SEQ", $sformatf("Generate new w item", ), UVM_HIGH)
    finish_item(m_item);
endtask

task test_case::send_r();
    //$display ("ARES this is testcase send_r");
    start_item(m_item);
    m_item.write = 0;
    m_item.read = 1;
    `uvm_info("SEQ", $sformatf("Generate new r item",), UVM_HIGH)
    finish_item(m_item);
endtask





