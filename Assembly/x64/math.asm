; signed
; lower register multiplication
mov al, 25
mov bl, 10
mul bl ; ax = 250 , CF = 0, OF = 0, AH = 0
; AX(AH(8 bits) << 8 | AL(8 bits)) - 16 bits wide

; overflow the lower half 
mov al, 200
mov bl, 200
mul bl ; ax = 4000, CF = 1, OF = 1
; AH = 0x0F, AL = 0xA0

; signed multiplication
mov rax, -5
mov rbx, 3
imul rbx ; rax = -15

; overflow in signed mul in lower registers
mov al, 100
mov bl, 100
imul bl ; ax = 10000, CF = 1, OF = 1
; AH = 0x27, AL = 0x10

; two operands multiplication
mov rax, 5
mov rbx, 10
imul rbx, rax ; rbx = 50, rax = 5 
; The second operand (rbx) is multiplied by the third operand (rax). The result is stored in the second operand (rbx). The first operand (rax) is unchanged.


; DIVISION
; unsigned
mov ax, 15
mov bl, 3
div bl ; al = 5 (quotient), ah = 0 (remainder)

; signed
mov ax, -15
mov bl, 3
idiv bl ; al = -5 (quotient), ah = 0 (remainder)

mov rax, 1000000000
xor rdx, rdx
mov rbx, 3
idiv rbx ; rax = 3333333333, rdx = 1 (modulus/remainder)

; overflow in signed division
mov ax, 0x8000
mov bl, -1
idiv bl ; This will cause an overflow exception because the result (0x8000) is too large to fit in a 16-bit signed integer.
; The quotient would be -32768, which is the minimum value for a 16-bit signed integer.
; However, the sign flag (SF) will be set, and the overflow flag (OF) will be set.
; The value in AX will be 0x8000 (-32768).
; The value in DX will be 0.
