global _start

section .bss
    buffer resb 16

section .data
    num db "%d", 0x0a, 0x0

section .text
_start:
    mov ecx, 0

.loop:
    cmp ecx, 20
    jge .exit
    
    ; convert ecx to string
    mov eax, ecx
    mov edi, buffer + 15 ; write digit backwards ; di -> destination index register
    mov byte [edi], 0xa ; newline
    dec edi

.convert:
    xor edx, edx ; 0
    mov ebx, 10
    div ebx ; eax = eax / ebx(10) , edx = remainder (eax % 10)
    add dl, '0'
    mov [edi], dl
    dec edi
    cmp eax, 0
    jne .convert

    inc edi

    ; write
    mov eax, 4
    mov ebx, 1
    mov ecx, edi
    mov edx, buffer + 16
    sub edx, esi
    int 0x80

    inc ecx
    jmp .loop

.exit:
    mov eax, 1
    xor ebx, ebx
    int 0x80
