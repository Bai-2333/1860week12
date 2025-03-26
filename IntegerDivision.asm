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
M=D

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
M=D

// Loop: Subtract y from x until x < y
(LOOP)
@R6
D=M
@R8
D=D-M
@AFTER_LOOP
D;LT
@R6
M=M-M     // R6 = R6 - R8
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

// Determine sign of quotient
@R7
D=M
@R10
M=D       // R10 = x < 0
@R9
D=M
D=D^M     // If x and y signs differ, result is negative
@R11
M=D       // R11 = quotient should be negated?
@R11
D=M
@SKIP_Q_NEGATE
D;JEQ
@R2
M=-M
(SKIP_Q_NEGATE)

// Remainder should have same sign as x
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
M=1       // Set error flag
@R2
M=0       // Zero out result
@R3
M=0
(END)
@END
0;JMP
