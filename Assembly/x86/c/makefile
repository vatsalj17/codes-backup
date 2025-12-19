all: a.out

a.out: add42.o main.c
	gcc -m32 add42.o main.c -o a.out

add42.o:
	nasm -f elf32 add42.asm -o add42.o

run: a.out
	./a.out

clean:
	rm a.out add42.o
