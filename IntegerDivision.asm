// Hack Assembly: SumArrayEntries.asm
// Integer Division: R0 / R1 -> Quotient in R2, Remainder in R3
// If R1 == 0, set R4 = 1 (invalid), else R4 = 0

// Step 1: Check for division by zero
@R1
D=M
@DIV_BY_ZERO
D;JEQ       // If divisor is 0, jump

// Step 2: Set valid flag to 0
@R4
M=0

// Step 3: Store x and y
@R0
D=M
@X
M=D        // X = x
@R1
D=M
@Y
M=D        // Y = y

// Step 4: Take absolute value of x => |x| in R5
@X
D=M
@XSIGN
M=0
@XPOS
D;JGE
@XSIGN
M=1
D=-D
(XPOS)
@R5
M=D

// Step 5: Take absolute value of y => |y| in R6
@Y
D=M
@YSIGN
M=0
@YPOS
D;JGE
@YSIGN
M=1
D=-D
(YPOS)
@R6
M=D

// Step 6: Initialize quotient (R2) = 0
@R2
M=0

// Step 7: Loop: While |x| >= |y|, subtract and count
(DIV_LOOP)
@R5
D=M
@R6
D=D-M
@AFTER_DIV
D;LT       // If |x| < |y|, exit loop

@R6
D=M
@R5
M=M-D      // R5 = R5 - R6
@R2
M=M+1      // Quotient++
@DIV_LOOP
0;JMP

(AFTER_DIV)
// Step 8: R5 is remainder now. Copy to R3
@R5
D=M
@R3
M=D

// Step 9: Fix quotient sign if x and y have opposite signs
@XSIGN
D=M
@YSIGN
D=D-M
@SKIP_NEG_QUOT
D;JEQ
@R2
M=-M
(SKIP_NEG_QUOT)

// Step 10: Fix remainder sign to match x
@XSIGN
D=M
@SKIP_NEG_REM
D;JEQ
@R3
M=-M
(SKIP_NEG_REM)

@END
0;JMP

// Division by zero handler
(DIV_BY_ZERO)
@R4
M=1       // Set invalid flag
@R2
M=0       // Zero quotient
@R3
M=0       // Zero remainder
(END)
@END
0;JMP

// TEMP REGISTERS USED:
(X)     // R13
(Y)     // R14
(XSIGN) // R10 = 1 if x < 0
(YSIGN) // R11 = 1 if y < 0
(R5)    // = |x| (reduced)
(R6)    // = |y|
