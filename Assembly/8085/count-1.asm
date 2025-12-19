; Count no. of 1's in the D register and store it in B register

START:
    ; MVI D, <any hex number>
    MVI B, 00H ; To count no. of 1's
    MVI C, 08H ; Setting up the counter
    MOV A, D   ; moving contents of d in accumalator
BACK:
    RAR ; rotate the accumlator right through carry
    JNC SKIP ; if no carry then skip
    INR B
SKIP:
    DCR C
    JNZ BACK ; loop back
    HLT
