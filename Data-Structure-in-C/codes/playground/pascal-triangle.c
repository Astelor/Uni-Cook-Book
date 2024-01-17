#include <stdio.h>

void printPascal(int n) {
    n+=2;
    for (int line = 2; line <= n; line++) {
        int coef = 1; 
        for (int i = 1; i <= line-1; i++) { 
            printf("%4d", coef); 
            coef = coef * (line - i) / i;
        } 
        printf("\n"); 
    } 
} 

int main(){
    int n = 6; 
    printPascal(n); 
    return 0; 
}