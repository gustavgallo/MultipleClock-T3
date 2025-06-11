# 🕒 MultipleClock-T3

📚 Available in: [English](README.md) | [Portuguese](README.pt-BR.md)

## 👥 Authors

- Gustavo Gallo - [@gustavgallo](https://github.com/gustavgallo)  
- Rodrigo Machado - [@GncRodrigo](https://github.com/GncRodrigo)

## 📌 Description

This project aims to implement and simulate a digital system with multiple clock domains using the **SystemVerilog** hardware description language. The goal is to explore synchronization techniques between different clock domains — a crucial aspect in complex digital systems.

## 🧩 Project Structure

- **[1]** **deserializer**: receives data via `data_in`. Whenever `write_in` is active, the bit is stored in `data_out`, forming 8-bit sequences. Operates with a `100KHz` clock.
- **[2]** **queue**: stores 8-bit sequences in `data_out`, with capacity for up to 4 entries in `len_out`. Supports **enqueue** (insert) and **dequeue** (remove) operations, running at `10KHz`.
- **[3]** **module_top**: connects the `deserializer` to the `queue`, automatically sending `data_out` to the queue when the deserializer output is complete. It also generates simulation clocks and the **ack** signal used in module **[1]**.
- **[4]** **tb_module_top**: testbench module that stores eight words into the queue, then dequeues and displays them via `data_out`. Afterward, the `reset` signal is activated, another eight words are queued, and one more insertion is attempted — demonstrating a full queue condition (error case).
- **[5]** **Clock Generation**: inside `module_top`, a process generates `100KHz` and `10KHz` clocks derived from the `1MHz` clock produced by the `tb_module_top.sv` testbench.

## 🛠️ Technologies Used

- **Language:** SystemVerilog  
- **Simulation:** ModelSim, Questa, or any simulator compatible with SystemVerilog.

## 🚀 How to Run

Clone the repository:

```bash
git clone https://github.com/gustavgallo/MultipleClock-T3.git
```
after that, run the simulation with:

```bash
cd source
```
Make sure the sim.do file is correctly configured to compile the modules and start the simulation.
🖥️ Simulation

Below is the waveform output from the [4] testbench, along with its corresponding values:
![image](https://github.com/user-attachments/assets/910c7488-fac9-4774-b251-a50a17d9b491)
