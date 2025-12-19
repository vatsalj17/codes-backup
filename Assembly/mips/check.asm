.data
msg: .asciiz "Hello, MIPS!\n"

.text
.globl main

main:
    # print string
    li $v0, 4
    la $a0, msg
    syscall

    # print number 42
    li $v0, 1
    li $a0, 42
    syscall

    # exit
    li $v0, 10
    syscall
