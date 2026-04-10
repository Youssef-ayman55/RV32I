# RISC-V RV32I CPU Implementation Checklist

This document tracks the implementation status of all **RV32I base integer instruction set (unprivileged)** instructions in this CPU.

## Legend
- [ ] Not implemented  
- [~] In progress  
- [x] Completed  

---

## 📦 Load Instructions
- [x] `LB`  — Load Byte  
- [x] `LH`  — Load Halfword  
- [x] `LW`  — Load Word  
- [x] `LBU` — Load Byte Unsigned  
- [x] `LHU` — Load Halfword Unsigned  

---

## 📦 Store Instructions
- [x] `SB` — Store Byte  
- [x] `SH` — Store Halfword  
- [x] `SW` — Store Word  

---

## ➕ Immediate Arithmetic Instructions
- [ ] `ADDI`  — Add Immediate  
- [ ] `SLTI`  — Set Less Than Immediate  
- [ ] `SLTIU` — Set Less Than Immediate Unsigned  
- [ ] `XORI`  — XOR Immediate  
- [ ] `ORI`   — OR Immediate  
- [ ] `ANDI`  — AND Immediate  
- [ ] `SLLI`  — Shift Left Logical Immediate  
- [ ] `SRLI`  — Shift Right Logical Immediate  
- [ ] `SRAI`  — Shift Right Arithmetic Immediate  

---

## ➕ Register Arithmetic Instructions
- [x] `ADD`  — Add  
- [x] `SUB`  — Subtract  
- [ ] `SLL`  — Shift Left Logical  
- [ ] `SLT`  — Set Less Than  
- [ ] `SLTU` — Set Less Than Unsigned  
- [ ] `XOR`  — XOR  
- [ ] `SRL`  — Shift Right Logical  
- [ ] `SRA`  — Shift Right Arithmetic  
- [x] `OR`   — OR  
- [x] `AND`  — AND  

---

## 🔀 Branch Instructions
- [x] `BEQ`  — Branch if Equal  
- [ ] `BNE`  — Branch if Not Equal  
- [ ] `BLT`  — Branch if Less Than  
- [ ] `BGE`  — Branch if Greater or Equal  
- [ ] `BLTU` — Branch if Less Than Unsigned  
- [ ] `BGEU` — Branch if Greater or Equal Unsigned  

---

## 🚀 Jump Instructions
- [ ] `JAL`  — Jump and Link  
- [ ] `JALR` — Jump and Link Register  

---

## 🧱 Upper Immediate Instructions
- [ ] `LUI`   — Load Upper Immediate  
- [ ] `AUIPC` — Add Upper Immediate to PC  

---

## 🛑 System Instructions (Unprivileged Subset)
- [ ] `ECALL`  — Environment Call  
- [ ] `EBREAK` — Breakpoint  

---

## 🧾 Optional Tracking (Nice-to-Have)

### 🔍 Instruction Decode
- [ ] Opcode decoding  
- [ ] funct3 decoding  
- [ ] funct7 decoding  

### ⚙️ CPU Features
- [ ] Register file  
- [ ] ALU operations  
- [ ] Immediate generator  
- [ ] Branch comparator  
- [ ] Memory interface  
- [ ] Control unit / FSM or pipeline control  

---

## 📊 Progress Summary
Total Instructions: 47  
Completed: 13  
In Progress: 0  
Remaining: 47  

---

## 🧪 Notes
- This checklist covers only the **RV32I base ISA** (no extensions like M, A, F, D, or C).
