# MIPS Assembly - Optimized Recursive Merge Sort
# Registers:
# $a0 = array pointer, $a1 = left index, $a2 = right index
# $t0-$t9 = temporary registers, $s0-$s7 = saved registers

.data
    temp_array: .space 1024    # Temporary array for merging (256 integers max)
    newline: .asciiz "\n"
    space: .asciiz " "

.text
.globl main

main:
    # Example usage - sort array of 8 integers
    la $a0, test_array
    li $a1, 0              # left = 0
    li $a2, 7              # right = 7 (8 elements - 1)
    jal merge_sort
    
    # Print sorted array
    la $a0, test_array
    li $a1, 8
    jal print_array
    
    # Exit
    li $v0, 10
    syscall

# Recursive merge sort function
# $a0 = array, $a1 = left, $a2 = right
merge_sort:
    # Save registers
    addi $sp, $sp, -20
    sw $ra, 16($sp)
    sw $s0, 12($sp)        # array
    sw $s1, 8($sp)         # left
    sw $s2, 4($sp)         # right
    sw $s3, 0($sp)         # mid
    
    move $s0, $a0
    move $s1, $a1
    move $s2, $a2
    
    # Base case: if left >= right, return
    bge $s1, $s2, merge_sort_end
    
    # Calculate mid = left + (right - left) / 2
    sub $t0, $s2, $s1      # right - left
    srl $t0, $t0, 1        # divide by 2
    add $s3, $s1, $t0      # left + (right - left) / 2
    
    # Recursive call: merge_sort(array, left, mid)
    move $a0, $s0
    move $a1, $s1
    move $a2, $s3
    jal merge_sort
    
    # Recursive call: merge_sort(array, mid + 1, right)
    move $a0, $s0
    addi $a1, $s3, 1       # mid + 1
    move $a2, $s2
    jal merge_sort
    
    # Merge the two sorted halves
    move $a0, $s0
    move $a1, $s1
    move $a2, $s3
    move $a3, $s2
    jal merge

merge_sort_end:
    # Restore registers
    lw $ra, 16($sp)
    lw $s0, 12($sp)
    lw $s1, 8($sp)
    lw $s2, 4($sp)
    lw $s3, 0($sp)
    addi $sp, $sp, 20
    jr $ra

# Merge function
# $a0 = array, $a1 = left, $a2 = mid, $a3 = right
merge:
    # Save registers
    addi $sp, $sp, -32
    sw $ra, 28($sp)
    sw $s0, 24($sp)        # array
    sw $s1, 20($sp)        # left
    sw $s2, 16($sp)        # mid
    sw $s3, 12($sp)        # right
    sw $s4, 8($sp)         # i (left pointer)
    sw $s5, 4($sp)         # j (right pointer)
    sw $s6, 0($sp)         # k (merge pointer)
    
    move $s0, $a0
    move $s1, $a1
    move $s2, $a2
    move $s3, $a3
    
    # Copy elements to temporary array
    move $t0, $s1          # i = left
    la $t1, temp_array
    
copy_loop:
    bgt $t0, $s3, copy_done
    sll $t2, $t0, 2        # i * 4
    add $t3, $s0, $t2      # array + i * 4
    lw $t4, 0($t3)         # array[i]
    
    sub $t5, $t0, $s1      # i - left
    sll $t5, $t5, 2        # (i - left) * 4
    add $t6, $t1, $t5      # temp_array + (i - left) * 4
    sw $t4, 0($t6)         # temp_array[i - left] = array[i]
    
    addi $t0, $t0, 1
    j copy_loop

copy_done:
    # Initialize pointers
    li $s4, 0              # i = 0 (left half of temp)
    sub $s5, $s2, $s1      # j = mid - left + 1
    addi $s5, $s5, 1
    move $s6, $s1          # k = left
    
merge_loop:
    # Check bounds
    sub $t0, $s2, $s1      # mid - left
    bgt $s4, $t0, merge_right_only    # if i > mid - left
    sub $t1, $s3, $s1      # right - left
    bgt $s5, $t1, merge_left_only     # if j > right - left
    
    # Compare temp_array[i] and temp_array[j]
    la $t2, temp_array
    sll $t3, $s4, 2        # i * 4
    add $t4, $t2, $t3      # temp_array + i * 4
    lw $t5, 0($t4)         # temp_array[i]
    
    sll $t6, $s5, 2        # j * 4
    add $t7, $t2, $t6      # temp_array + j * 4
    lw $t8, 0($t7)         # temp_array[j]
    
    ble $t5, $t8, take_left
    
take_right:
    # array[k] = temp_array[j]
    sll $t9, $s6, 2        # k * 4
    add $t9, $s0, $t9      # array + k * 4
    sw $t8, 0($t9)
    addi $s5, $s5, 1       # j++
    j merge_continue
    
take_left:
    # array[k] = temp_array[i]
    sll $t9, $s6, 2        # k * 4
    add $t9, $s0, $t9      # array + k * 4
    sw $t5, 0($t9)
    addi $s4, $s4, 1       # i++
    
merge_continue:
    addi $s6, $s6, 1       # k++
    ble $s6, $s3, merge_loop

    j merge_end

merge_left_only:
    # Copy remaining elements from left half
    sub $t0, $s2, $s1      # mid - left
    bgt $s4, $t0, merge_end
    
    la $t1, temp_array
    sll $t2, $s4, 2        # i * 4
    add $t3, $t1, $t2      # temp_array + i * 4
    lw $t4, 0($t3)         # temp_array[i]
    
    sll $t5, $s6, 2        # k * 4
    add $t6, $s0, $t5      # array + k * 4
    sw $t4, 0($t6)         # array[k] = temp_array[i]
    
    addi $s4, $s4, 1       # i++
    addi $s6, $s6, 1       # k++
    j merge_left_only

merge_right_only:
    # Copy remaining elements from right half
    sub $t0, $s3, $s1      # right - left
    bgt $s5, $t0, merge_end
    
    la $t1, temp_array
    sll $t2, $s5, 2        # j * 4
    add $t3, $t1, $t2      # temp_array + j * 4
    lw $t4, 0($t3)         # temp_array[j]
    
    sll $t5, $s6, 2        # k * 4
    add $t6, $s0, $t5      # array + k * 4
    sw $t4, 0($t6)         # array[k] = temp_array[j]
    
    addi $s5, $s5, 1       # j++
    addi $s6, $s6, 1       # k++
    j merge_right_only

merge_end:
    # Restore registers
    lw $ra, 28($sp)
    lw $s0, 24($sp)
    lw $s1, 20($sp)
    lw $s2, 16($sp)
    lw $s3, 12($sp)
    lw $s4, 8($sp)
    lw $s5, 4($sp)
    lw $s6, 0($sp)
    addi $sp, $sp, 32
    jr $ra

# Print array function
# $a0 = array, $a1 = size
print_array:
    addi $sp, $sp, -16
    sw $ra, 12($sp)
    sw $s0, 8($sp)
    sw $s1, 4($sp)
    sw $s2, 0($sp)
    
    move $s0, $a0
    move $s1, $a1
    li $s2, 0
    
print_loop:
    beq $s2, $s1, print_done
    
    sll $t0, $s2, 2
    add $t1, $s0, $t0
    lw $a0, 0($t1)
    li $v0, 1
    syscall
    
    la $a0, space
    li $v0, 4
    syscall
    
    addi $s2, $s2, 1
    j print_loop
    
print_done:
    la $a0, newline
    li $v0, 4
    syscall
    
    lw $ra, 12($sp)
    lw $s0, 8($sp)
    lw $s1, 4($sp)
    lw $s2, 0($sp)
    addi $sp, $sp, 16
    jr $ra

# Test data
.data
test_array: .word 64, 34, 25, 12, 22, 11, 90, 5
