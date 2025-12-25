#include <stdbool.h>
#include <stdio.h>
#include <stdlib.h>
#include <string.h>

// char* removeDuplicateLetters(char* s) {
// 	int n = strlen(s);
// 	char* str = calloc(n, sizeof(char));
// 	int letters[26] = {0};
// 	for (int i = 0; i < 26; i++) letters[i] = -1;
// 	for (int i = 0; s[i] != '\0'; i++) {
// 		int l = s[i] - 'a';
// 		if (letters[l] == -1) {
// 			letters[s[i] - 'a'] = i;
// 		} else {
// 			str[letters[l]] = '-';
// 			letters[l] = i;
// 		}
// 		str[i] = s[i];
// 	}
// 	for (int i = 0; i < n; i++) {
// 		if (str[i] == '-') {
// 			memmove(str + i, str + i + 1, n - i);
// 			i--;
// 		}
// 	}
// 	return str;
// }

char* removeDuplicateLetters(char* s) {
	int n = strlen(s);
	char* st = calloc(n + 1, sizeof(char));
	char freq[26] = {0};
	for (int i = 0; i < n; i++) freq[s[i] - 'a']++;
	bool seen[26] = {false};
	int top = -1;
	for (int i = 0; i < n; i++) {
		int l = s[i] - 'a';
        if (seen[l]) {
            freq[l]--;
            continue;
        }
		while (top >= 0 && st[top] > s[i] && freq [st[top] - 'a'] > 0) {
            seen[st[top] - 'a'] = false;
			top--; // pop
		}
		st[++top] = s[i];  // push
		freq[l]--;
		seen[l] = true;
	}
	st[top + 1] = '\0';
	return st;
}

int main(void) {
	char s[67];
	printf("Enter the string: ");
	scanf("%s", s);
	printf("ans: %s", removeDuplicateLetters(s));
}
