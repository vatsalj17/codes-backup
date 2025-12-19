; unpack the packed BCD number

    LDA 3000H ; get packed bcd number from the memory
    MOV B, A
    MVI C, 04H
    ANI F0H ; make the lower byte 0
L1: 
    RRC ; rotate it 4 times right
    DCR C
    JNZ L1
    STA 3001H
    MOV A, B
    ANI 0FH ; make the upper byte 0
    STA 3002H
    HLT
