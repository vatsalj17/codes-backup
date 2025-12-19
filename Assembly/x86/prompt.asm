global _start

section .bss
    name resb 10

section .data
    prompt db "Enter your name: "
    len_p equ $ - prompt
    response db "Your name is: "
    len_r equ $ - response

section .text
_start:
    mov eax, 4
    mov ebx, 1
    mov ecx, prompt 
    mov edx, len_p
    int 0x80

    mov eax, 3
    mov ebx, 0
    mov ecx, name
    mov edx, 10
    int 0x80

    mov eax, 4
    mov ebx, 1
    mov ecx, response 
    mov edx, len_r
    int 0x80

    mov eax, 4
    mov ebx, 1
    mov ecx, name 
    mov edx, 10
    int 0x80

    mov eax, 1
    mov ebx, 0
    int 0x80
