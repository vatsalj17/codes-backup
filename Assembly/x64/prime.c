#include <stdio.h>

int main(void) {
	int n;
	printf("Enter a number: ");
	scanf("%d", &n);
	printf("All prime number from 2 to  %d are:-\n", n);
	for (int i = 2; i <= n; i++) {
		int is_prime = 1;
		for (int j = 2; j <= i / 2; j++) {
			if (i % j == 0) {
				is_prime = 0;
				break;
			}
		}
		if (is_prime) printf("%d\n", i);
	}
	return 0;
}
