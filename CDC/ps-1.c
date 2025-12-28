#include <stdbool.h>
#include <stdio.h>
#include <stdlib.h>
#include <ctype.h>

bool wordExsists(char** mat, int matSize, char* word) {
    return true;
}

int main(void) {
    int n;
    printf("Enter the size of matrix: ");
    scanf("%d", &n);
    char** mat = malloc(n * sizeof(char*));
    for (int i = 0; i < n; i++) mat[i] = malloc(n * sizeof(char));
    printf("Enter the matrix: \n");
    for (int i = 0; i < n; i++) {
        for (int j = 0; j < n; j++) {
            int c;
            scanf("%c", &c);
            if (isalpha(c)) mat[i][j] = c;
            else j--;
        }
    }
    // for (int i = 0; i < n; i++) {
    //     for (int j = 0; j < n; j++) {
    //         printf("%c ", mat[i][j]);
    //     }
    //     printf("\n");
    // }
    char word[100];
    printf("Enter the word: ");
    scanf("%s", word);
    if (wordExsists(mat, n, word)) {
        printf("Word Exsists\n");
    } else {
        printf("Word doesn't Exsists\n");
    }
}