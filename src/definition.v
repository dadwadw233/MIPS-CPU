`define ADD 6'b100000
`define ADDU 6'b100001
`define AND 6'b100100
`define DIV 6'b011010
`define DIVU 6'b011011
`define MULT 6'b011000
`define MULTU 6'b011001
`define NOR 6'b100111
`define OR 6'b100101
`define SLL 6'b000000
`define SLLV 6'b000100
`define SLT 6'b101010
`define SLTU 6'b101011
`define SRA 6'b000011
`define SRAV 6'b000111
`define SRL 6'b000010
`define SRLV 6'b000110
`define SUB 6'b100010
`define SUBU 6'b100011
`define XOR 6'b100110
/*********R TYPE CALCULATE*********/


`define ADDI 6'b001000
`define ADDIU 6'b001001
`define ANDI 6'b001100
`define ORI 6'b001101
`define SLTI 6'b001010
`define SLTIU 6'b001011
`define XORI 6'b001110

/********** Imm CALCULATE **********/

`define BEQ 6'b000100
`define BGEZ 5'b00001//funcode: 000 001
`define BGTZ 6'b000111
`define BLEZ 6'b000110
`define BLTZ 5'b00000//funcode: 000 001
`define BNE 6'b000101

`define J 6'b000010
`define JAL 6'b000011
`define JALR 6'b001001//R TYPE
`define JR 6'b001000

/********BRANCH AND JUMP*********/

`define LB 6'b100000
`define LBU 6'b100100
`define LH 6'b100001
`define LHU 6'b100101
`define LUI 6'b001111
`define LW 6'b100011

/********* LOAD ***********/

`define SB 6'b101000
`define SH 6'b101001
`define SW 6'b101011

/******* SAVE ********/

/*
	omit MFCO MFHI MFLO MTCO MTHI MTLO 
*/
`define BREAK 6'b001101
`define ERET 6'b011000
`define SYSCALL 6'b001100
