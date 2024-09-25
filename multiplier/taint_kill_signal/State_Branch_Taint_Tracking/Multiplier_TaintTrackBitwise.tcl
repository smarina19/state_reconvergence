analyze -sv Multiplier_TaintTrackBitwise.v

elaborate -top Multiplier_TaintTrackBitwise

clock clk
reset rst -non_resettable_regs 0

# check if there is a taint flow from multiplier to productDone
assume {state < 2 * WIDTH + 2 -> state_t_kill = 1}
assume {multiplier_t == 1 && start_t == 0 && multiplicand_t == 0}
assert {productDone -> !productDone_t}

# Set the time limit to 1 hour (3600 seconds)
set_prove_time_limit 3600
set_engine_mode Tri
prove -all
