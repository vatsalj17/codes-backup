; REGISTER NAMING CONVENTION:
; You'll see a pattern in register names. For the main GPRs:
; - R_X: 64-bit (e.g., RAX) - 'R' for "Register"
; - E_X: 32-bit (e.g., EAX) - 'E' for "Extended"
; -  _X: 16-bit (e.g., AX)
; -  _H: High 8-bits of the 16-bit register (e.g., AH)
; -  _L: Low 8-bits of the 16-bit register (e.g., AL)
;
; For newer registers (R8-R15), the suffixes are different:
; - R_ : 64-bit (e.g., R8)
; - R_d: 32-bit (e.g., R8D)
; - R_w: 16-bit (e.g., R8W)
; - R_b: 8-bit  (e.g., R8B)

; --- General-Purpose Registers (GPRs) ---
; These are the workhorse registers used for most arithmetic, logic, and data movement.

; RAX: Accumulator Register
; Naming: AL (low 8-bit), AH (high 8-bit), AX (16-bit), EAX (32-bit), RAX (64-bit)
; Purpose: Its name "accumulator" comes from its historical use in accumulating the results of
; arithmetic operations. It's still favored for multiplication and division.
; Special Role: Holds the return value of a function and the syscall number for system calls.

; RBX: Base Register
; Naming: BL, BH, BX, EBX, RBX
; Purpose: Historically used as a "base" pointer for memory addressing. In modern code, it's a
; general-purpose register, but it has a special status as a "callee-saved" register (see function calls).

; RCX: Counter Register
; Naming: CL, CH, CX, ECX, RCX
; Purpose: Used as a loop counter. Instructions like `loop` automatically use ECX/RCX.
; Also used in string operations to count the number of repetitions.

; RDX: Data Register
; Naming: DL, DH, DX, EDX, RDX
; Purpose: A general-purpose register, but it has a special role alongside RAX for multiplication
; and division. For a 64-bit multiplication (e.g., `mul rbx`), the 128-bit result is stored in RDX:RAX.
; Also used in I/O operations to specify port numbers.

; --- Index and Pointer Registers ---
; These are also GPRs but have special roles related to memory addressing and stack management.

; RSI: Source Index
; Naming: SIL, SI, ESI, RSI
; Purpose: Used as the "source" pointer in string and memory operations. For example, when
; copying a block of memory, RSI would point to the beginning of the source data.
; Special Role: Holds the 2nd argument in function calls and syscalls.

; RDI: Destination Index
; Naming: DIL, DI, EDI, RDI
; Purpose: Used as the "destination" pointer in string and memory operations. When copying
; memory, RDI would point to the destination location.
; Special Role: Holds the 1st argument in function calls and syscalls.

; RBP: Base Pointer
; Naming: BPL, BP, EBP, RBP
; Purpose: Used to establish a "stack frame" for a function. It points to a fixed location
; within the function's stack area, making it easy to access local variables and arguments,
; even as the stack pointer (RSP) moves.

; RSP: Stack Pointer
; Naming: SPL, SP, ESP, RSP
; Purpose: Always points to the "top" of the stack. The stack is a region of memory that
; grows downwards. RSP is modified automatically by instructions like PUSH, POP, CALL, and RET.
; You should not use it for general arithmetic.

; --- Additional General-Purpose Registers (x64 only) ---
; R8, R9, R10, R11, R12, R13, R14, R15
; These are 8 additional GPRs available only in 64-bit mode, which is a major advantage of x64.
; Naming: R8/R8D/R8W/R8B, R9/R9D/R9W/R9B, etc.
; Special Role: R8, R9, and R10 are used for passing function/syscall arguments.

; --- Stack Operations ---
; The stack is a LIFO (Last-In, First-Out) data structure in memory.
; It's essential for managing function calls, local variables, and temporary data.
; RSP (Stack Pointer) always points to the last item pushed onto the stack.
;
; PUSH: Decrements RSP by the operand size and copies the operand to the location [RSP].
; POP:  Copies the data from the location [RSP] to the operand and increments RSP.
;
; Example:
;   mov rax, 111
;   mov rbx, 222
;   ; Stack: [ ... | ??? ] <-- RSP
;   push rax       ; RSP decreases by 8. Stack: [ ... | 111 ] <-- RSP
;   push rbx       ; RSP decreases by 8. Stack: [ ... | 111 | 222 ] <-- RSP
;   pop rdi        ; RDI becomes 222. RSP increases by 8. Stack: [ ... | 111 ] <-- RSP
;   pop rsi        ; RSI becomes 111. RSP increases by 8. Stack: [ ... | ??? ] <-- RSP

; --- Register Usage in Function Calls (System V AMD64 ABI) ---
; This convention defines how functions pass data to each other.
;
; Arguments: The first six integer/pointer arguments are passed in registers.
; 1st arg: RDI
; 2nd arg: RSI
; 3rd arg: RDX
; 4th arg: RCX
; 5th arg: R8
; 6th arg: R9
; (Floating-point arguments are passed in XMM0-XMM7).
;
; Return Value: The return value is placed in RAX.
;
; Caller-saved (Volatile): RAX, RCX, RDX, RSI, RDI, R8, R9, R10, R11.
; A function (the "callee") can freely modify these registers without restoring them.
; If the calling function ("caller") needs to preserve their values, it must save them before the call.
;
; Callee-saved (Non-Volatile): RBX, RBP, RSP, R12, R13, R14, R15.
; A function must save these registers if it uses them and restore them to their original values before returning.

; --- Special-Purpose Registers ---

; RIP: Instruction Pointer
; Think of this as the CPU's bookmark. It holds the memory address of the *next* instruction
; to be executed. You cannot modify it directly. It is changed by branching instructions
; like JMP (jump), CALL (call function), and RET (return from function).

; RFLAGS: Flags Register
; This is a collection of single-bit flags that store information about the result of the
; last arithmetic or comparison instruction.
; Key Flags:
; - ZF (Zero Flag): Set if the result was zero. Used for `je` (jump if equal) and `jne` (jump if not equal).
; - SF (Sign Flag): Set if the result was negative (i.e., the most significant bit was 1).
; - CF (Carry Flag): Set if an unsigned arithmetic operation overflowed (e.g., `add al, 1` when AL is 255).
; - OF (Overflow Flag): Set if a signed arithmetic operation overflowed.
; - DF (Direction Flag): Controls the direction of string operations (`cld` clears it, `std` sets it).

; --- Other Registers ---

; Segment Registers: CS, DS, SS, ES, FS, GS
; In older 16-bit and 32-bit modes, these were critical for memory segmentation.
; In modern 64-bit mode, segmentation is mostly flat. CS (Code Segment), DS (Data Segment),
; and SS (Stack Segment) are still used but you rarely interact with them.
; FS and GS have found new life and are often used by the OS to point to thread-specific data
; (Thread Local Storage or TLS).

; Floating-Point Registers (FPU): ST(0) to ST(7)
; These are 80-bit registers used by the legacy x87 Floating-Point Unit. They are organized
; as a stack. Modern code typically uses the XMM registers instead.

; Vector Registers (SIMD):
; SIMD stands for "Single Instruction, Multiple Data". These registers allow you to perform
; a single operation on multiple pieces of data at once.
;
; - XMM0-XMM15 (128-bit): Used for SSE (Streaming SIMD Extensions). Can hold four 32-bit floats,
;   two 64-bit doubles, or various integer sizes. Used for passing floating-point arguments.
;
; - YMM0-YMM15 (256-bit): Used for AVX (Advanced Vector Extensions). The lower 128 bits are
;   the same as the XMM registers. They double the throughput of SIMD operations.
;
; - ZMM0-ZMM31 (512-bit): Used for AVX-512. Provides 32 registers, each 512 bits wide.

section .text
    global _start

_start:
    ; Example of moving values into the main GPRs
    mov rax, 12345
    mov rbx, 67890
    mov rcx, 0
    mov rdx, 100
    mov rsi, 200
    mov rdi, 300

    ; Example of moving values into the new x64 GPRs
    mov r8, 400
    mov r9, 500
    mov r10, 600
    mov r11, 700
    mov r12, 800
    mov r13, 900
    mov r14, 1000
    mov r15, 1100

    ; --- Accessing Smaller Parts of Registers ---

    mov rax, 0x1122334455667788

    ; Now, let's modify only the lower 8 bits (AL).
    ; The rest of the register is UNCHANGED.
    mov al, 0x99
    ; RAX is now: 0x1122334455667799

    ; Now, let's modify the lower 16 bits (AX).
    ; The rest of the register is UNCHANGED.
    mov ax, 0xAABB
    ; RAX is now: 0x112233445566AABB

    ; IMPORTANT: When you write to a 32-bit register (like EAX),
    ; the upper 32 bits of the 64-bit register are automatically ZEROED.
    mov eax, 0xDEADBEEF
    ; RAX is now: 0x00000000DEADBEEF

    ; --- Exit Syscall ---
    ; This is an example of making a system call to exit the program.
    mov rax, 60 ; Syscall number for `exit`
    mov rdi, 0  ; Exit code 0 (success)
    syscall
