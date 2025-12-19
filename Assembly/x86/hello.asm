global _start

section .data
    msg db "Hello! World", 0x0a ; 0x0a is code for newline
    len equ $ - msg ; the current address ($) minus the address of the start of the message (msg)

section .text
_start:
    mov eax, 4 ; the write syscall
    mov ebx, 1 ; stdout fd
    mov ecx, msg 
    mov edx, len
    int 0x80 ; perform syscall

    mov eax, 1
    mov ebx, 0
    int 0x80
