#include <stdio.h>
#include <stdlib.h>
#include <unistd.h>

int main(void) {
    char* str = malloc(100);
    printf("%p\n", str);
    write(STDOUT_FILENO, "Enter a string: ", 16);
    read(STDIN_FILENO, str, 99);
    printf("The string entered: %s\n", str);
    free(str);
}
