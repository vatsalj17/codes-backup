global main
extern printf

section .data
    num db "%d", 0x0a, 0x0

section .text
main:
    mov eax, 0
loop:
    cmp eax, 20
    jz exit
    mov ebx, eax
    push eax 
    push num
    call printf
    mov eax, ebx
    inc eax
    jmp loop

exit:
    mov eax, 1
    xor ebx, ebx
    int 0x80
