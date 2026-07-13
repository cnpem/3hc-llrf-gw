# 3rd Harmonic Cavity (3HC) Low-Level Radio Frequency (LLRF) Gateware

Gateware for the Sirius' 3rd Harmonic Cavity (3HC) Low-Level Radio Frequency
(LLRF).

## Directory Structure

```
*
|
|-- hdl:
|    |   HDL (Verilog/VHDL) modules related to the Sirius' 3HC LLRF.
|    |
|    |-- ip_cores:
|    |        Third-party reusable modules.
|    |
|    |-- modules:
|    |        Application-specific modules.
|    |
|    |-- platform:
|    |        Platform-specific modules (e.g. Xilinx ChipScope wrappers).
|    |
|    |-- sim:
|    |        Generic simulation files (e.g. reusable Bus Functional
|    |        Modules (BFMs), constants definitions)
|    |
|    |-- syn:
|    |        Synthesis-specific files (user constraints files and top design
|    |          specification).
|    |
|    |-- testbench:
|    |        Testbenches for modules and top level designs. May use modules
|    |          defined within the "sim" directory.
|    |
|    |-- top:
|             Top design modules.
```
