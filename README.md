# ASDi — VHDL Exercises and Final Project

Coursework for the Digital Systems Architecture, Master's Degree in Computer Engineering, University of Naples Federico II.

A sequence of digital-design exercises in VHDL, developed and simulated/synthesized with Xilinx Vivado, mostly targeting a Digilent Nexys A7-100T FPGA board. Full report: [`ASDI_Vitale_Russo.pdf`](ASDI_Vitale_Russo.pdf).

This was a group project with a course mate (Russo) — the report and exercises reflect joint work, not a strict 50/50 split of authorship.

## Exercises

Each folder under [`Esercizi/`](Esercizi/) is a self-contained Vivado project (`.xpr` + VHDL sources under `.srcs/`, build artifacts removed):

| Folder | Topic |
|---|---|
| [`Esercizio1`](Esercizi/Esercizio1) | Combinational networks: 16:1 multiplexer built from 2:1/4:1 muxes, then a 16×4 switching network, including a board-synthesizable version |
| [`Esercizio2`](Esercizi/Esercizio2) | ROM-based combinational system (`Sistema_ROM_M`), plus board version |
| [`Esercizio3`](Esercizi/Esercizio3) | Sequence recognizer as a Mealy FSM, plus board version |
| [`Esercizio4`](Esercizi/Esercizio4) | Shift register |
| [`Esercizio5`](Esercizi/Esercizio5) | Chronometer (synchronous version included), plus board version |
| [`Esercizio6`](Esercizi/Esercizio6) | Arithmetic machine with separate operative/control units (PO/PC), plus board version |
| [`Esercizio7`](Esercizi/Esercizio7) | Booth multiplier, plus board version |
| [`Esercizio8`](Esercizi/Esercizio8) | Handshaking-based communication between two units |
| [`Esercizio10`](Esercizi/Esercizio10) | Serial (RS232) interface, built around [`RS232RefComp.vhd`](Esercizi/Esercizio10/RS232RefComp.vhd) — see [`Documentazione DIGILENT RS232RefComp.pdf`](Documentazione%20DIGILENT%20RS232RefComp.pdf) for the reference component this is based on |
| [`Esercizio11`](Esercizi/Esercizio11) | Multistage switching network |
| [`Esercizio12`](Esercizi/Esercizio12) | December 2024 exam exercise |

**Not included — Esercizio9 (Processore):** this exercise was carried out inside the MIC-1 lab virtual machine provided for the course, following the instructions in its handout (`dispensa-mic.pdf`), rather than as a standalone Vivado project with its own exported sources, so there's nothing self-contained to publish here.

## Notes

- Each `board_*`/`*_board_ok` project is the FPGA-targeted variant of the preceding exercise (I/O mapped to the Nexys A7 board's switches, buttons, and seven-segment display via its constraints file), while the plain `Myproject_*` variants are the base design and testbench.
