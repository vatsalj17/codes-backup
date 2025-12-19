; .data -> var
; .texxt -> src code
; .bss unintialised

global _start

section .data 
    ; literal strign
    l_str db  "hello world!! in asm", 0xa, 0x0
    len equ $ - l_str 

section .text

_start:
    mov eax, 4 ;  syscall num in eax register , syscall is interupt, syscall is software interupt
    ; passing args ,fds
    mov ebx, 1 ; eax takes args from ebx, ecx , edx , .... 
    mov ecx, l_str
    mov edx, len

    int 0x80                                        ;syscall intrupt (0x80) 

    mov eax, 1
    mov ebx, 200
    
    int 0x80
