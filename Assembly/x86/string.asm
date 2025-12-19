global _start

section .data
    addr db "string", 0x0a

section .text
_start:
    mov [addr], byte 'L'
    mov [addr + 3], byte 'C'
    mov eax, 4
    mov ebx, 1
    mov ecx, addr 
    mov edx, 7
    int 0x80

    mov eax, 1
    mov ebx, 0
    int 0x80
