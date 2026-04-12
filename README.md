# RISC-V RV32I CPU Implementation Checklist

This document tracks the implementation status of all **RV32I base integer instruction set (unprivileged)** instructions in this CPU.


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
- [x] `ADDI`  — Add Immediate  
- [x] `SLTI`  — Set Less Than Immediate  
- [x] `SLTIU` — Set Less Than Immediate Unsigned  
- [x] `XORI`  — XOR Immediate  
- [x] `ORI`   — OR Immediate  
- [x] `ANDI`  — AND Immediate  
- [x] `SLLI`  — Shift Left Logical Immediate  
- [x] `SRLI`  — Shift Right Logical Immediate  
- [x] `SRAI`  — Shift Right Arithmetic Immediate  

---

## ➕ Register Arithmetic Instructions
- [x] `ADD`  — Add  
- [x] `SUB`  — Subtract  
- [x] `SLL`  — Shift Left Logical  
- [x] `SLT`  — Set Less Than  
- [x] `SLTU` — Set Less Than Unsigned  
- [x] `XOR`  — XOR  
- [x] `SRL`  — Shift Right Logical  
- [x] `SRA`  — Shift Right Arithmetic  
- [x] `OR`   — OR  
- [x] `AND`  — AND  

---

## 🔀 Branch Instructions
- [x] `BEQ`  — Branch if Equal  
- [x] `BNE`  — Branch if Not Equal  
- [x] `BLT`  — Branch if Less Than  
- [x] `BGE`  — Branch if Greater or Equal  
- [x] `BLTU` — Branch if Less Than Unsigned  
- [x] `BGEU` — Branch if Greater or Equal Unsigned  

---

## 🚀 Jump Instructions
- [x] `JAL`  — Jump and Link  
- [x] `JALR` — Jump and Link Register  

---

## 🧱 Upper Immediate Instructions
- [ ] `LUI`   — Load Upper Immediate  
- [ ] `AUIPC` — Add Upper Immediate to PC  

---

## 🛑 System Instructions (Unprivileged Subset)
- [ ] `ECALL`  — Environment Call  
- [ ] `EBREAK` — Breakpoint  
- [ ] `FENCE`
- [ ] `FENCE.TSO`

---

## 📊 Progress Summary
Total Instructions: 42  
Completed: 36  
In Progress: 0  
Remaining: 6  

---

## 🧪 Notes
- This checklist covers only the **RV32I base ISA** (no extensions like M, A, F, D, or C).
