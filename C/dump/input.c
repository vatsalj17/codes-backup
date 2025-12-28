#include <stdio.h>
#include <stdlib.h>

int main(void) {
    char* str = malloc(100);
    printf("%p\n", str);
    printf("Enter a string: ");
    scanf("%99s", str);
    printf("The string entered: %s\n", str);
    free(str);
}
