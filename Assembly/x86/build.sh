#!/bin/bash

if [ -z "$1" ]; then
	exit 1
fi

file=$1
name=$(basename "$file" .asm)
obj="$name.o"

nasm -f elf32 $file -o $obj
ld -m elf_i386 $obj
# ld -m elf_i386 -o $name $obj

rm $obj
