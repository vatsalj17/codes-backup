#!/bin/bash

if [ -z "$1" ]; then
	exit 1
fi

file=$1
name=$(basename "$file" .asm)
obj="$name.o"

nasm -f elf32 "$file" -o "$obj" || { echo "nasm failed"; exit 1; }
gcc -m32 "$obj" || { echo "gcc failed"; exit 1; }

rm $obj
