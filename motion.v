module motion (
    input wire clk,         // Clock input
    input wire pir_output,  // PIR sensor output
    output reg internal_led // Internal LED output
);

reg [23:0] counter = 0; // 24-bit counter for LED blink timing with reset
reg motion_detected;     // Motion detection flag

always @(posedge clk) begin
    // Reset the counter on each rising edge of the clock
    if (counter == 24000000) begin
        counter <= 0;
    end else begin
        counter <= counter + 1;
    end

    // Check PIR sensor output for motion
    if (pir_output) begin
        motion_detected <= 1;
    end else begin
        motion_detected <= 0;
    end
end

always @(posedge clk) begin
    // Toggle the internal LED output based on the counter value if motion is detected
    if (counter == 24000000 && motion_detected) begin
        internal_led <= ~internal_led; // Toggle the internal LED state
    end
end

endmodule
