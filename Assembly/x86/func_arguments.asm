global _start

_start:
    push 21
    call times2
    mov ebx, eax
    mov eax, 1
    int 0x80

times2:
    push ebp
    mov ebp, esp
    mov eax, [ebp + 8] ; go down in stack and pick the number
    ; adding 8 because the pushed return address is at ebp + 4, and the argument is at ebp + 8
    add eax, eax ; double it
    mov esp, ebp
    pop ebp
    ret
