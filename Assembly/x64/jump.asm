    cmp rax, 50
    jb below_fifty ; rax < 50 (CF = 1)
    ja above_fifty ; rax > 50 (CF = 0, ZF = 0)
    ; if we reached here it means rax is equal to 50
equals_fifty:
    ; handle equal 50 case
    jmp continue
below_fifty:
    ; handle less than 50 case
    jmp continue
above_fifty:
    ; handle greater than 50 case
    jmp continue
continue:
    ; rest of the program



; Other jump instructions in x64 with their respective explaination:- 
; jg (Jump if Greater) - Jumps if the destination operand is greater than the source operand. This instruction is used after a comparison instruction (like CMP). It checks the sign flag (SF) and the zero flag (ZF). The jump occurs if SF = OF and ZF = 0.

; jge (Jump if Greater or Equal) - Jumps if the destination operand is greater than or equal to the source operand. This instruction is used after a comparison instruction (like CMP). It checks the sign flag (SF) and the overflow flag (OF). The jump occurs if SF = OF.

; jl (Jump if Less) - Jumps if the destination operand is less than the source operand. This instruction is used after a comparison instruction (like CMP). It checks the sign flag (SF) and the overflow flag (OF). The jump occurs if SF != OF.

; jle (Jump if Less or Equal) - Jumps if the destination operand is less than or equal to the source operand. This instruction is used after a comparison instruction (like CMP). It checks the zero flag (ZF). The jump occurs if ZF = 1 or SF != OF.

; jne (Jump if Not Equal) - Jumps if the destination operand is not equal to the source operand. This instruction is used after a comparison instruction (like CMP). The jump occurs if ZF = 0.

; je (Jump if Equal) - Jumps if the destination operand is equal to the source operand. This instruction is used after a comparison instruction (like CMP). The jump occurs if ZF = 1.

; jz (Jump if Zero) - Same as JE. Jumps if the result of the previous operation was zero.

; jnz (Jump if Not Zero) - Same as JNE. Jumps if the result of the previous operation was not zero.

; jc (Jump if Carry) - Jumps if the carry flag (CF) is set (CF = 1).

; jnc (Jump if Not Carry) - Jumps if the carry flag (CF) is clear (CF = 0).

; jo (Jump if Overflow) - Jumps if the overflow flag (OF) is set (OF = 1).

; jno (Jump if No Overflow) - Jumps if the overflow flag (OF) is clear (OF = 0).

; js (Jump if Sign) - Jumps if the sign flag (SF) is set (SF = 1).

; jns (Jump if No Sign) - Jumps if the sign flag (SF) is clear (SF = 0).

; ja (Jump if Above) - Jumps if the destination operand is above the source operand. This instruction is used after a comparison instruction (like CMP). It checks the carry flag (CF) and the zero flag (ZF). The jump occurs if CF = 0 and ZF = 0.)

; jb (Jump if Below) - Jumps if the destination operand is below the source operand. This instruction is used after a comparison instruction (like CMP). It checks the carry flag (CF). The jump occurs if CF = 1.

; jna (Jump if Not Above) - Jumps if the destination operand is not above the source operand. This instruction is used after a comparison instruction (like CMP). It checks the carry flag (CF) and the zero flag (ZF). The jump occurs if CF = 1 or ZF = 1.

; jnb (Jump if Not Below) - Jumps if the destination operand is not below the source operand. This instruction is used after a comparison instruction (like CMP). It checks the carry flag (CF). The jump occurs if CF = 0.

; jnl (Jump if Not Less) - Jumps if the destination operand is not less than the source operand. This instruction is used after a comparison instruction (like CMP). It checks the sign flag (SF) and the overflow flag (OF). The jump occurs if SF = OF.

; jng (Jump if Not Greater) - Jumps if the destination operand is not greater than the source operand. This instruction is used after a comparison instruction (like CMP). It checks the sign flag (SF) and the zero flag (ZF). The jump occurs if SF = OF or ZF = 1.

; jnge (Jump if Not Greater or Equal) - Jumps if the destination operand is not greater than or equal to the source operand. This instruction is used after a comparison instruction (like CMP). It checks the sign flag (SF) and the overflow flag (OF). The jump occurs if SF != OF.

; jle (Jump if Less or Equal) - Jumps if the destination operand is less than or equal to the source operand. This instruction is used after a comparison instruction (like CMP). It checks the zero flag (ZF). The jump occurs if ZF = 1 or SF != OF.

; jbe (Jump if Below or Equal) - Jumps if the destination operand is below or equal to the source operand. This instruction is used after a comparison instruction (like CMP). It checks the carry flag (CF) and the zero flag (ZF). The jump occurs if CF = 1 or ZF = 1.

; jcxz (Jump if CX register is zero) - Jumps if the CX register is zero. This instruction is used for loop control.

; jecxz (Jump if ECX register is zero) - Jumps if the ECX register is zero. This instruction is used for loop control.

; jrcx (Jump if RCX register is zero) - Jumps if the RCX register is zero. This instruction is used for loop control.

; loop (Loop while ECX is not zero) - Decrements the ECX register and jumps to the specified label if ECX is not zero.

; loope (Loop while ECX is not zero and ZF=1) - Decrements the ECX register and jumps to the specified label if ECX is not zero and the Zero Flag is set.

; loopne (Loop while ECX is not zero and ZF=0) - Decrements the ECX register and jumps to the specified label if ECX is not zero and the Zero Flag is clear.



; THE FLAGS REGISTER 
; The flags register is a special register in the CPU that stores the status of the last arithmetic or logical operation. It's composed of several individual bits, each representing a specific condition. Here are some of the most important flags:
; Zero Flag (ZF): Set to 1 if the result of an operation is zero, otherwise cleared to 0.
; Sign Flag (SF): Set to 1 if the most significant bit (MSB) of the result is 1 (indicating a negative number in two's complement representation), otherwise cleared to 0.
; Carry Flag (CF): Set to 1 if an arithmetic operation results in a carry-out or a borrow-out. This is often used for unsigned arithmetic.
; Overflow Flag (OF): Set to 1 if a signed arithmetic operation results in a value that cannot be represented in the destination operand's size (e.g., adding two large positive numbers and getting a negative result).
; Parity Flag (PF): Set to 1 if the number of set bits (1s) in the least significant byte of the result is even, otherwise cleared to 0.
; Auxiliary Carry Flag (AF): Set to 1 if there was a carry from bit 3 to bit 4 during an arithmetic operation. This is primarily used for BCD (Binary Coded Decimal) arithmetic.
; Interrupt Enable Flag (IF): Controls whether the CPU responds to maskable interrupts.
; Direction Flag (DF): Controls the direction of string operations (incrementing or decrementing addresses).
