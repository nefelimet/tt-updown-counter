# SPDX-FileCopyrightText: © 2024 Tiny Tapeout
# SPDX-License-Identifier: Apache-2.0

import cocotb
from cocotb.clock import Clock
from cocotb.triggers import ClockCycles


@cocotb.test()
async def test_project(dut):
    dut._log.info("Start")
    
    # Pin mapping
    en_port = dut.ui_in[6]
    updn_port = dut.ui_in[5]
    ld_port = dut.ui_in[4]
    rst_port = dut.ui_in[3]
    data_in_port = [dut.ui_in[2], dut.ui_in[1], dut.ui_in[0]]
    data_out_port = [dut.uo_out[2], dut.uo_out[1], dut.uo_out[0]]

    # Set the clock period to 20 ns (50 MHz)
    clock = Clock(dut.clk, 20, units="ns")
    cocotb.start_soon(clock.start())

    # Reset
    dut._log.info("Reset")
    en_port.value = 0
    ld_port.value = 1
    updn_port.value = 0
    rst_port.value = 0
    await ClockCycles(dut.clk, 2)
    rst_port.value = 1
    await ClockCycles(dut.clk, 2)
    
    dut._log.info("Test project behavior")

    # Set the input values you want to test
    value = 3
    data_in_port[0].value = (value >> 0) & 1
    data_in_port[1].value = (value >> 1) & 1
    data_in_port[2].value = (value >> 2) & 1
    
    ld_port.value = 0

    # Wait for one clock cycle to see the output values
    await ClockCycles(dut.clk, 2)
    
    exp_value = (data_out_port[2].value << 2) | (data_out_port[1].value << 1) | data_out_port[0].value
    assert exp_value == 3
    
    value = 6
    data_in_port[0].value = (value >> 0) & 1
    data_in_port[1].value = (value >> 1) & 1
    data_in_port[2].value = (value >> 2) & 1
    
    await ClockCycles(dut.clk, 2)
    
    exp_value = (data_out_port[2].value << 2) | (data_out_port[1].value << 1) | data_out_port[0].value
    assert exp_value == 6

    
