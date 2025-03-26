// IntegerDivision.asm
// Input: R0 = x (dividend), R1 = y (divisor)
// Output:
//   R2 = quotient m
//   R3 = remainder q
//   R4 = flag (1 if invalid, 0 otherwise)

// Step 1: Check if y == 0 -> invalid
@R1
D=M
@DIV_BY_ZERO
D;JEQ

// Step 2: Copy x to R5, y to R6
@R0
D=M
@R5
M=D      // R5 = x

@R1
D=M
@R6
M=D      // R6 = y

// Step 3: Determine sign of x (R7) and y (R8)
@R5
D=M
@R7
M=0
@X_POS
D;JGE
@R7
M=1      // x < 0
D=-D
(X_POS)
@R9
M=D      // R9 = |x|

@R6
D=M
@R8
M=0
@Y_POS
D;JGE
@R8
M=1      // y < 0
D=-D
(Y_POS)
@R10
M=D     // R10 = |y|

// Step 4: Initialize quotient
@R2
M=0

// Step 5: Loop: while |x| >= |y|, subtract and count
(LOOP)
@R9
D=M
@R10
D=D-M
@AFTER_LOOP
D;LT

@R10
D=M
@R9
M=M-D

@R2
M=M+1
@LOOP
0;JMP

(AFTER_LOOP)
// R9 = remainder
@R9
D=M
@R3
M=D

// Step 6: Adjust quotient sign if x and y have different signs
@R7
D=M
@R8
D=D-M
@SKIP_Q_NEG
D;JEQ
@R2
M=-M
(SKIP_Q_NEG)

// Step 7: Adjust remainder sign to match x
@R7
D=M
@SKIP_R_NEG
D;JEQ
@R3
M=-M
(SKIP_R_NEG)

// Step 8: Valid division
@R4
M=0
@END
0;JMP

// Step 9: Division by zero handler
(DIV_BY_ZERO)
@R2
M=0
@R3
M=0
@R4
M=1

(END)
@END
0;JMP
