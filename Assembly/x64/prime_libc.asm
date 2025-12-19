bits 64
default rel

global main
extern printf
extern scanf

section .bss

section .data
prompt db "Enter a number: ", 0x0
prompt_len equ $ - prompt
input_fmt db "%d", 0x0
output_fmt db "%ld", 0xa, 0x0
num dq 0

section .text
main:
    push rbp
    mov rbp, rsp
    mov rax, 1
    mov rdi, 1
    mov rsi, prompt
    mov rdx, prompt_len
    syscall

    mov rdi, input_fmt
    mov rsi, num
    xor eax, eax
    call scanf

    ; intialization
    mov rbx, 0
    mov r8, [num]

loop:
    ; condition
    inc rbx
    cmp rbx, r8
    jg exit

    mov r9, 2 ;i
    mov r12, rbx
    sub r12, 1
    mov r10, r12
    ;mov r11, 2
    ;div r11
    ;mov r10, rax ; n/2

.sub_loop:
    cmp r9, r10
    jg loop

    mov r12, rbx
    mov r11, r9
    div r11
    cmp rdx, 0
    jnz loop

    mov r12, r8
    mov rdi, output_fmt
    mov rsi, rbx
    xor eax, eax
    call printf
    mov r8, r12

    jmp loop

exit:
    add rsp, 8
    mov eax, 0
    ret
