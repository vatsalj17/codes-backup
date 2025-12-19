.data
A: .word 34, 12, 5, 67, 23, 89, 1, 45, 0, 31  # Sample array of 10 elements
n: .word 10
msg_before: .asciiz "Before sorting: "
msg_after: .asciiz "\nAfter sorting: "
space: .asciiz " "
newline: .asciiz "\n"

.text
.globl main

main:
    # Print "Before sorting:"
    li $v0, 4
    la $a0, msg_before
    syscall
    
    # Print original array
    la $a0, A
    lw $a1, n
    jal print_array
    
    # Sort the array
    la $a0, A
    lw $a1, n
    jal selection_sort
    
    # Print "After sorting:"
    li $v0, 4
    la $a0, msg_after
    syscall
    
    # Print sorted array
    la $a0, A
    lw $a1, n
    jal print_array
    
    # Print newline and exit
    li $v0, 4
    la $a0, newline
    syscall
    
    li $v0, 10
    syscall

# ------------------------------------------
# selection_sort function:
# $a0 = base address of array
# $a1 = number of elements
# Registers used: $t0-$t7, $s0-$s1
# ------------------------------------------
selection_sort:
    # Save registers
    addi $sp, $sp, -12
    sw $ra, 8($sp)
    sw $s0, 4($sp)
    sw $s1, 0($sp)
    
    move $s0, $a0           # $s0 = base address
    move $s1, $a1           # $s1 = array size
    
    # Early exit for arrays of size <= 1
    ble $s1, 1, sort_done
    
    li $t0, 0               # i = 0 (outer loop counter)
    
outer_loop:
    addi $t1, $s1, -1       # n - 1
    bge $t0, $t1, sort_done # if i >= n-1, done
    
    # Calculate address of A[i]
    sll $t2, $t0, 2         # i * 4
    add $t2, $s0, $t2       # address of A[i]
    
    move $t3, $t0           # min_idx = i
    move $t4, $t2           # min_addr = &A[i]
    lw $t5, 0($t2)          # min_val = A[i]
    
    addi $t6, $t0, 1        # j = i + 1
    
inner_loop:
    bge $t6, $s1, end_inner # if j >= n, end inner loop
    
    # Calculate address of A[j]
    sll $t7, $t6, 2         # j * 4
    add $t7, $s0, $t7       # address of A[j]
    lw $t8, 0($t7)          # A[j]
    
    # Compare A[j] with current minimum
    bge $t8, $t5, skip_update
    
    # Found new minimum
    move $t3, $t6           # min_idx = j
    move $t4, $t7           # min_addr = &A[j]
    move $t5, $t8           # min_val = A[j]
    
skip_update:
    addi $t6, $t6, 1        # j++
    j inner_loop
    
end_inner:
    # Swap A[i] with A[min_idx] if needed
    beq $t3, $t0, no_swap   # if min_idx == i, no swap needed
    
    lw $t7, 0($t2)          # temp = A[i]
    sw $t5, 0($t2)          # A[i] = min_val
    sw $t7, 0($t4)          # A[min_idx] = temp
    
no_swap:
    addi $t0, $t0, 1        # i++
    j outer_loop
    
sort_done:
    # Restore registers
    lw $s1, 0($sp)
    lw $s0, 4($sp)
    lw $ra, 8($sp)
    addi $sp, $sp, 12
    jr $ra

# ------------------------------------------
# print_array function:
# $a0 = base address of array
# $a1 = number of elements
# ------------------------------------------
print_array:
    # Save registers
    addi $sp, $sp, -16
    sw $ra, 12($sp)
    sw $s0, 8($sp)
    sw $s1, 4($sp)
    sw $s2, 0($sp)
    
    move $s0, $a0           # base address
    move $s1, $a1           # count
    li $s2, 0               # index = 0
    
    # Handle empty array
    ble $s1, 0, print_done
    
print_loop:
    bge $s2, $s1, print_done
    
    # Print current element
    lw $a0, 0($s0)
    li $v0, 1
    syscall
    
    # Print space (except after last element)
    addi $t0, $s2, 1
    bge $t0, $s1, skip_space
    li $v0, 4
    la $a0, space
    syscall
    
skip_space:
    addi $s0, $s0, 4        # next element
    addi $s2, $s2, 1        # index++
    j print_loop
    
print_done:
    # Restore registers
    lw $s2, 0($sp)
    lw $s1, 4($sp)
    lw $s0, 8($sp)
    lw $ra, 12($sp)
    addi $sp, $sp, 16
    jr $ra
