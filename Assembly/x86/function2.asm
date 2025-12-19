global _start

_start:
    call func
    mov eax, 1
    mov ebx, 0
    int 0x80

func:
    push ebp ; this instruction is required to save the current stack frame
    mov ebp, esp ; doing this to store the base pointer so that we can restore it later
    sub esp, 2
    mov [esp], byte 'H'
    mov [esp + 1], byte 'i'
    mov eax, 4
    mov ebx, 1
    mov ecx, esp
    mov edx, 2
    int 0x80
    mov esp, ebp ; now we are restoring the stack pointer
    pop ebp ; even after having the mov instruction, this is required to restore the original stack frame
    ; the push pop is diffrent from mov store as, the mov here is used to restore the stack pointer to its original value, and the pop instruction is used to restore the original base pointer
    ; this is useful when we have nested functions and we want to restore the stack frame of the caller function
    ret
