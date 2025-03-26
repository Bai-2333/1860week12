// Hack assembly program for integer division
// Registers usage:
// R0 - Dividend (x)
// R1 - Divisor (y)
// R2 - Quotient (m)
// R3 - Remainder (q)
// R4 - Division valid flag (1 if invalid, 0 otherwise)
@R1 // Load divisor (y)
D=M // D = y
@DIV_BY_ZERO
D;JEQ // If y == 0, jump to error handling
// Initialize quotient and remainder
@R2
M=0 // R2 (m) = 0
@R0
D=M // D = x
@R3
M=D // R3 (q) = x
// Set flag to valid (0)
@R4
M=0
// Determine sign of quotient
@R0
D=M // D = x
@POSITIVE_X
D;JGE // If x >= 0, jump to POSITIVE_X
@R1
D=M // D = y
@NEGATIVE_DIV
D;JGE // If y >= 0, jump to NEGATIVE_DIV
@POSITIVE_X
// While remainder >= divisor, subtract divisor and increment quotient
@R3
D=M
@DONE
D-M;JLT // If remainder < divisor, done
@R3
M=M-D // remainder -= divisor
@R2
M=M+1 // quotient++
@POSITIVE_X
0;JMP // Loop
@NEGATIVE_DIV
@R3
D=M
@DONE
D+M;JGT // If remainder > divisor (negative case), done
@R3
M=M+D // remainder += divisor
@R2
M=M-1 // quotient--
@NEGATIVE_DIV
0;JMP // Loop
// Error handling: Set flag to 1 and exit (y==0)
@DIV_BY_ZERO
@R4
M=1
@END
0;JMP
// Done: Store final results
@DONE
@R2
M=M // Store quotient
@R3
M=M // Store remainder
@END
0;JMP // End program
