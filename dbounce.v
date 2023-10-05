module motion (
    input wire clk,         // Clock input
    input wire pir_output,  // PIR sensor output
    output reg internal_led // Internal LED output
);

reg [31:0] counter = 0; // 24-bit counter for LED blink timing with reset
reg motion_detected;     // Motion detection flag
reg int_led;
reg [3:0] pir_debounce = 4'b0000; // Debounce register for PIR sensor

always @(posedge clk) begin
    // Reset the counter on each rising edge of the clock
    if (counter == 32000000) begin
        counter <= 0;
    end else begin
        counter <= counter + 1;
    end

    // Debounce the PIR sensor output
    pir_debounce <= {pir_debounce[2:0], pir_output};

    // Check PIR sensor output for motion
    if (pir_debounce == 4'b1111) begin
        motion_detected <= 1;
    end else if (pir_debounce == 4'b0000) begin
        motion_detected <= 0;
    end
end

always @(posedge clk) begin
    // Toggle the internal LED output based on the counter value if motion is detected
    if (motion_detected == 1) begin
        internal_led <= ~internal_led; // Toggle the internal LED state
    end
	 else begin
        internal_led <= ~internal_led; // Toggle the internal LED state
		  end
end

endmodule
