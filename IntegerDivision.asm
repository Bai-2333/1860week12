// IntegerDivision.asm
// Inputs: R0 = x, R1 = y
// Outputs: R2 = quotient, R3 = remainder, R4 = error flag (1 if y == 0)

//// Check if divisor is zero
@R1
D=M
@DIV_ZERO
D;JEQ

// R4 = 0 (valid)
@R4
M=0

// Store x in R5, y in R6
@R0
D=M
@R5
M=D

@R1
D=M
@R6
M=D

// Get |x| into R7 and x<0 flag in R8
@R5
D=M
@R8
M=0
@XPOS
D;JGE
@R8
M=1
D=-D
(XPOS)
@R7
M=D

// Get |y| into R9 and y<0 flag in R10
@R6
D=M
@R10
M=0
@YPOS
D;JGE
@R10
M=1
D=-D
(YPOS)
@R9
M=D

// Initialize quotient R2 = 0
@R2
M=0

// Loop: while |x| >= |y|, do |x| -= |y| and quotient++
(LOOP)
@R7
D=M
@R9
D=D-M
@AFTER_LOOP
D;LT
@R9
D=M
@R7
M=M-D
@R2
M=M+1
@LOOP
0;JMP

(AFTER_LOOP)
// R7 now holds |remainder| -> store in R3
@R7
D=M
@R3
M=D

// Set sign of quotient if x and y have different signs
@R8
D=M
@R10
D=D-M
@SKIP_Q_NEG
D;JEQ
@R2
M=-M
(SKIP_Q_NEG)

// Set sign of remainder to match x
@R8
D=M
@SKIP_R_NEG
D;JEQ
@R3
M=-M
(SKIP_R_NEG)

@END
0;JMP

// If y == 0: set R4 = 1 and zero outputs
(DIV_ZERO)
@R4
M=1
@R2
M=0
@R3
M=0

(END)
@END
0;JMP
