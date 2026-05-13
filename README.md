# UART Implementation using Basys 3 FPGA

## Overview
This project implements UART (Universal Asynchronous Receiver Transmitter) communication using Verilog HDL on the Basys 3 FPGA board.

The project demonstrates:
- UART transmission (TX)
- UART reception (RX)
- Baud rate generation
- Echo functionality
- LED display of received data

The FPGA communicates serially with a PC terminal using UART protocol at 9600 baud.

---

## Features
- UART Transmitter
- UART Receiver
- Baud Rate Generator
- Echo Communication
- LED Output Display
- Serial Communication using Tera Term
- FPGA implementation on Basys 3

---

## Hardware Used
- Basys 3 FPGA Board
- USB Cable
- Computer/Laptop

---

## Software Used
- Vivado
- Tera Term

---

## UART Configuration

| Parameter | Value |
|---|---|
| Baud Rate | 9600 |
| Data Bits | 8 |
| Parity | None |
| Stop Bits | 1 |

---

## Project Structure

| File Name | Description |
|---|---|
| `baud_generator.v` | Generates baud rate tick |
| `uart_tx.v` | UART transmitter module |
| `uart_rx.v` | UART receiver module |
| `echo.v` | Echo functionality module |
| `top_module.v` | Top-level integration module |
| `constraints.xdc` | Basys 3 pin mapping constraints |

---

## System Architecture

```text
PC Terminal → UART RX → FPGA → UART TX → PC Terminal
                         ↓
                       LEDs
```

The received data is displayed on onboard LEDs using ASCII representation and echoed back to the terminal.

---

## Working Principle

1. The PC sends serial data through Tera Term.
2. The FPGA receives the data using UART RX.
3. The received character is displayed on LEDs.
4. The FPGA retransmits the same character using UART TX.
5. The echoed character appears back on the terminal.

---

## Steps to Run

### 1. Open Vivado
Create a new RTL project for Basys 3 FPGA.

### 2. Add Source Files
Add:
- baud_generator.v
- uart_tx.v
- uart_rx.v
- uart_echo.v
- top_module.v

### 3. Add Constraints File
Add:
- constraints.xdc

### 5. Program FPGA
Open Hardware Manager and program the Basys 3 board.

### 6. Open Tera Term/putty
Configure:
- Baud Rate = 9600
- Data Bits = 8
- Parity = None
- Stop Bits = 1

### 7. Test
Type characters in Tera Term.
- RX/TX LEDs blink during communication
- Characters are echoed back
- LEDs display ASCII values

---

## Results
- Successful UART communication achieved
- Data transmission and reception verified
- Echo functionality implemented successfully
- RX/TX LEDs indicated active serial communication

---

## Challenges Faced
- UART timing synchronization
- Baud rate debugging
- COM port configuration
- LED update timing

---

## Future Improvements
- Parity bit checking
- FIFO buffering
- Full duplex optimization
- 7-segment display integration
- Higher baud rates

---

## GitHub Repository
Repository Link:
https://github.com/SrujanxShadow/UART.git

---
