; Calculate the sum of series of even numbers from the list of numbers. The length of the list is in memory location 2200H and the series itself begins from memory location 2201H. Assume the sum to be 8 bit number so you can ignore carries and store the sum at memory location 2210H.

    LDA 2200H
    MOV C, A
    MVI B, 00H
    LXI H, 2201H
BACK:
    MOV A, M ; Get the number
    ANI 01H ; Mask bit 1 to bit 7
    JNZ SKIP ; Don't add if number is odd
    MOV A, B ; get the sum
    ADD M
    MOV B, A
SKIP:
    INX H
    DCR C
    JNZ BACK
    STA 2210H ; store the sum
    HLT ;halt
