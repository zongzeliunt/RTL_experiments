//class test_case extends uvm_sequence#(Item);
class test_case extends uvm_sequence#(Item);
    `uvm_object_utils(test_case)

    function new(string name="test_case");
        super.new(name);
    endfunction

    Item m_item = Item::type_id::create("m_item");

    extern virtual task send_w ();

    virtual task body ();
        //$display ("ARES this is testcase body");
        send_w();
    endtask

endclass

task test_case::send_w();
    //$display ("ARES this is testcase send_w");
    start_item(m_item);
    m_item.randomize();
    `uvm_info("SEQ", $sformatf("Generate new item: %s", m_item.convert2str()), UVM_HIGH)
    finish_item(m_item);
endtask







