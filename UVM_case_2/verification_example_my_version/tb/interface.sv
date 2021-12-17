// The interface allows verification components to access DUT signals
// using a virtual interface handle
interface des_if (input bit clk);
  	logic rstn;
	logic in;
	logic out;

	clocking cb @(posedge clk);
        //这其实是个不错的办法，就是cb是一套以posedge clk为基准的操作，cb里定义了方向，每call一次cb，必须等到posedge clk
        default input #1step output #3ns;
	    input out;
	    output in;
	endclocking
endinterface
