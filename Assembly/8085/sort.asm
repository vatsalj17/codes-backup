; Sort 10 numbers from memory location 2200H in the ascending order
; Bubble sort inefficient logic

    MVI B, 09H ; Setup the counter 1
START:
    LXI H, 2200H ; Initialize the memory pointer
    MVI C, 09H ; Initialize the counter 2
BACK:
    MOV A, M ; Get the number
    INX H ; Increment the memory pointer
    CMP M ; Comparte number with the next number
    JC SKIP ; If less don't interchange
    JZ SKIP ; If equal don't interchange
    MOV D, M
    MOV M, A
    DCX H
    MOV M, D
    INX H ; Swap two numbers
SKIP:
    DCR C
    JNZ BACK ; If not zero then repeat
    DCR B
    JNZ START ; If not zero then repeat
    HLT ; Halt the processor

