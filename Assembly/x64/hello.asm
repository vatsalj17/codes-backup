BITS 64 ; it tells to assemble in 64-bit mode
default rel ; this instruction is used to tell the assembler to use relative addressing for all labels and symbols.

section .data
    msg db 'Hello, world', 0x0A
    len equ $ - msg

section .text
    global _start

_start:
    mov rax, 1 ; write
    mov rdi, 1 ; arg1
    lea rsi, [rel msg] ; arg2
    mov rdx, len ; arg3
    syscall

    mov rax, 60 ; exit
    mov rdi, 0
    syscall
