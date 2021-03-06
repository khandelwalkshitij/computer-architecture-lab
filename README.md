# computer-architecture-lab

Random Pieces of Information Based On Real Life Experiences:

1. By default, go for `output reg` and `input wire`. In the testbench, the inputs will be just `reg` and outputs will be just `wire`. Beware of using `output reg` for structural modelling.
2. When there's a `reg` that needs to be used to store and change the value of an `input wire`, with behavioral modelling, use the `always @ (*)` block to contain the assignment of that `reg`. [Example](https://stackoverflow.com/questions/14443608/assigning-value-to-a-register-in-a-module-instance-in-verilog)
3. All `$` system tasks and functions must end with a `;`.
4. Use non-blocking assignment, `<=`, in cases where counters or shift registers are to be designed.