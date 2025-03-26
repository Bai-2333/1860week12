// Hack Assembly: SumArrayEntries.asm
// Computes the sum of all entries in an array
// R0 - Base address of array
// R1 - Number of elements in array
// R2 - Output sum
// R3 - Current address pointer
// R4 - Counter (tracks elements processed)
// R5 - Accumulator (sum)
// Check if R1 (number of elements) is <= 0
@R1
D=M
@SET_ZERO
D;JLE // If R1 <= 0, go to SET_ZERO
// Initialize sum, counter, and array pointer
@R5
M=0 // Sum = 0
@R4
M=0 // Counter = 0
@R0
D=M
@R3
M=D // R3 = Base address (array pointer)
// Loop: Process each element
(LOOP)
 @R4
 D=M
 @R1
 D=D-M
 @END
 D;JEQ // If counter == number of elements, end
 // Load current element and add to sum
 @R3
 A=M // Get address of current element
 D=M // D = *R3 (current element)
 @R5
 M=M+D // Sum += current element
 // Move to next element
 @R3
 M=M+1 // R3 += 1 (next element address)
 @R4
 M=M+1 // Counter += 1
 @LOOP
 0;JMP // Repeat loop
// Store the sum in R2
(END)
@R5
D=M
@R2
M=D // Store final sum in R2
@HALT
0;JMP // End program
// If R1 <= 0, set R2 = 0 and exit
(SET_ZERO)
@R2
M=0
@HALT
0;JMP
