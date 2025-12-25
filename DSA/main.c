#include <stdio.h>

typedef struct {
	unsigned long long a;
	char* b;
} hrs;

int main(void) {
	hrs h[10];
	int arr[10];
	for (int i = 0; i < 10; i++) arr[i] = i;
	// printf("%c\n", 2 ["hello"]);
	arr[1] = *(arr + 1);
	1[arr] = *(1 + arr);
	h[1].b = "hi";
	2[h].b = "no";
	printf("%s\n", 2[h].b);
}
