global _start

_start:
    mov eax, 1
    mov ebx, 42
    sub ebx, 30
    int 0x80 ; int->interrupt 0x80->interrupt handler for syscalls
    ; syscall is determined by the eax register
