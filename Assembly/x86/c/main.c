#include <stdio.h>
#include "add42.h"

int main(void) {
    int n;
    printf("Enter a number: ");
    scanf("%d", &n);
    int result = add42(n);
    printf("Result: %d\n", result);
    return 0;
}
