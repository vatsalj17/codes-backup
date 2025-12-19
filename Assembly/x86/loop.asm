global _start

section .text

_start:
	mov ebx, 1
	mov ecx, 5; no of iterations

label:
	add ebx, ebx
	dec ecx
	cmp ecx, 0
	jg  label; jump if greater
    
    mov eax, 1
    int 0x80
