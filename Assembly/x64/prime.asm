global _start

section .bss
buffer resb 32
num resb 8

section .data
prompt db "Enter a number: ", 0x0
prompt_len equ $ - prompt

section .text
_start:
    mov rax, 1 ; write
    mov rdi, 1
    mov rsi, prompt
    mov rdx, prompt_len
    syscall

    mov rax, 0 ; read
    mov rdi, 0
    mov rsi, num
    mov rdx, 2
    syscall

    mov rax, 1
    mov rdi, 1
    mov rsi, num
    mov byte [rsi + 1], 0xa
    mov rdx, 2
    syscall

    ; convert string -> integer(r8)
    xor r8, r8
    mov rbx, 0
    mov rdx, num
.convert_i:
    mul r8, 10
    mov rax, [rdx]
    sub rax, '0'
    add r8, rax
    ;inc rdx
    add rdx, 4
    inc rbx
    cmp rbx, 2
    jnz .convert_i

    ; exit
    mov rax, 60
    mov rdi, r8
    syscall

    mov rbx, 1

loop:
    cmp rbx, 4
    jg exit

    ; Convert RBX to string (decimal)
    mov rax, rbx
    mov rdi, buffer + 31 ; write backward from end
    mov byte [rdi], 0xa ; newline
    dec rdi

.convert:
    xor rdx, rdx ; 0
    mov rcx, 10
    div rcx ; rax /= 10, rdx = remainder
    add dl, '0' ; low byte of rdx
    mov [rdi], dl
    dec rdi
    cmp rax, 0
    jne .convert

    inc rdi

    mov r12, rdi
    ; write(1, rdi, buffer+32 - rdi)
    mov rax, 1
    mov rdi, 1
    mov rsi, r12
    mov rdx, buffer + 32
    sub rdx, rsi
    syscall

    inc rbx
    jmp loop

exit:
    mov rax, 60
    xor rdi, rdi
    syscall
