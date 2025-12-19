#!/bin/bash

if [ -z "$1" ]; then
	exit 1
fi

file=$1
name=$(basename "$file" .asm)
obj="$name.o"

nasm -f elf64 -g -F dwarf $file -o $obj
# ld $obj
gcc -no-pie $obj

rm $obj
