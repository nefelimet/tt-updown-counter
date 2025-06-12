module updown_counter(
    input [2:0] data_in,
    input rst_,
	  input ld_cnt,
	  input updn_cnt,
	  input count_enb,
	  input clk,
    output reg [2:0] data_out
);

always@(posedge clk) begin

    //If reset is active, data out is zero. Reset is active low.
	if(!rst_) begin
		data_out <= 3'b0;
	end

    //If ld_cnt (load counter) is active, load input data to output. ld_cnt is active low.
    //Load counter has a higher priority than count enable.
    if(!ld_cnt) begin
        data_out <= data_in;
    end

	//If count enable is active, count up or down, according to updn_cnt's value.
	else if(count_enb) begin
		if(updn_cnt) begin
			data_out <= data_out + 1;
		end

		else begin
			data_out <= data_out - 1;
		end
	end
end



endmodule
