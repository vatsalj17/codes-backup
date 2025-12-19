; This program finds the maximum of two numbers stored at memory
; locations 2000H and 2001H and stores the result at 2002H.

START:
    LXI H, 2000H    ; Point HL to the first number.
    MOV B, M        ; Load the first number into register B.
    INX H           ; Increment HL to point to the next memory location.
    MOV C, M        ; Load the second number into register C.
    CALL MAX        ; Call the MAX subroutine to find the maximum.
    INX H           ; Increment HL to point to the location for the result.
    MOV M, A        ; Store the result from accumulator A into memory.
    HLT             ; Halt the processor.

MAX:
    MOV A, B        ; Move the content of B to accumulator A.
    CMP C           ; Compare the content of A with C.
    JNC L1          ; If Carry flag is not set (A >= C), jump to NO_CHANGE.
    MOV A, C        ; If Carry is set (A < C), move C to A.

L1:
    RET             ; Return from the subroutine.
