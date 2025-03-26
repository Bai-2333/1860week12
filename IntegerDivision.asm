// Integer Division: R0 / R1 = Quotient in R2, Remainder in R3
// If R1 == 0, set R4 = 1 (invalid), else R4 = 0

// Check if divisor is zero
@R1
D=M
@DIV_BY_ZERO
D;JEQ

// Initialize
@R2
M=0        // Quotient = 0
@R3
M=0        // Remainder = 0
@R4
M=0        // Valid flag = 0

// Store absolute value of R0 (x) in R6, and x < 0 flag in R7
@R0
D=M
@R7
M=0
@X_POSITIVE
D;JGE
@R7
M=1
D=-D
(X_POSITIVE)
@R6
M=D        // R6 = |x|

// Store absolute value of R1 (y) in R8, and y < 0 flag in R9
@R1
D=M
@R9
M=0
@Y_POSITIVE
D;JGE
@R9
M=1
D=-D
(Y_POSITIVE)
@R8
M=D        // R8 = |y|

// Loop: Subtract y from x until x < y
(LOOP)
@R6
D=M
@R8
D=D-M
@AFTER_LOOP
D;LT
@R8
D=M
@R6
M=M-D
@R2
M=M+1
@LOOP
0;JMP

(AFTER_LOOP)
// R6 now holds remainder, R2 holds abs(quotient)

// Check if signs of x and y are different: R11 = 1 if different, 0 if same
@R7
D=M
@R10
M=D        // R10 = x negative?
@R9
D=M
@R11
M=0
D=D-M
@SKIP_SIGN
D;JEQ      // If R7 == R9, skip
@R11
M=1        // If different signs, R11 = 1
(SKIP_SIGN)

// Apply sign to quotient if needed
@R11
D=M
@SKIP_Q_NEGATE
D;JEQ
@R2
M=-M
(SKIP_Q_NEGATE)

// Apply sign to remainder to match sign of x
@R7
D=M
@SKIP_R_NEGATE
D;JEQ
@R6
M=-M
(SKIP_R_NEGATE)

// Save results
@R2
D=M
@R2
M=D

@R6
D=M
@R3
M=D

@END
0;JMP

(DIV_BY_ZERO)
@R4
M=1       // Set invalid flag
@R2
M=0
@R3
M=0
(END)
@END
0;JMP
(END)
@END
0;JMP
