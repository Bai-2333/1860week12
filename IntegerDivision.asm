// Inputs: R0 = x (dividend), R1 = y (divisor)
// Outputs: R2 = quotient, R3 = remainder, R4 = flag (1 if invalid)

@R1
D=M
@DIV_BY_ZERO
D;JEQ       // if y == 0 -> invalid

// Save signs
@R0
D=M
@XNEG
D;JLT
@XNEG
M=0        // x is positive
@XABS
D;JMP
(XNEG)
@XNEG
M=1
D=-D
(XABS)
@XABSVAL
M=D        // |x| -> XABSVAL

@R1
D=M
@YNEG
D;JLT
@YNEG
M=0        // y is positive
@YABS
D;JMP
(YNEG)
@YNEG
M=1
D=-D
(YABS)
@YABSVAL
M=D        // |y| -> YABSVAL

// Clear quotient
@R2
M=0

// Division loop: while |x| >= |y|
(LOOP)
@XABSVAL
D=M
@YABSVAL
D=D-M
@ENDLOOP
D;LT

@XABSVAL
M=M
@YABSVAL
D=M
@XABSVAL
M=M-D

@R2
M=M+1
@LOOP
0;JMP

(ENDLOOP)
// Save remainder
@XABSVAL
D=M
@R3
M=D

// Apply sign to quotient if needed (if x and y have different signs)
@XNEG
D=M
@YNEG
D=D+M
@TWO
@Q_SIGN_DONE
D;JEQ      // if signs same, skip negation

@R2
M=-M
(Q_SIGN_DONE)

// Remainder has same sign as x
@XNEG
D=M
@R3
D=M
@POS_REMAINDER
D;JEQ
@R3
M=-M
(POS_REMAINDER)

// Set valid flag
@R4
M=0

@END
0;JMP

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

// Temp registers
// XABSVAL = R5, YABSVAL = R6, XNEG = R7, YNEG = R8
