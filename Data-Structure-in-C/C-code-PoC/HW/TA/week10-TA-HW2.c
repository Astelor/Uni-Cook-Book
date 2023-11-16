#include <stdio.h>
#include <stdlib.h>

int main(){
    int n;
    scanf("%d",&n);
    int array=n;
    int (*pt)[array] = malloc( sizeof (int [n+1][n+1] ) ); //this one's cleaner tbh
    int line,i; n;
    for (line = 2; line <= n+2; line++) {
        int coef = 1; 
        for (i = 1; i <= line-1; i++) { 
            pt[line-2][i-1]=coef;
            coef = coef * (line - i) / i;
        }
    }
    for(line=n;line>=0;line--){
        for(i=0;i<=line;i++){
            printf("%4d",pt[line][i]);
        }
        printf("\n");
    }
    free(pt);
    return 0;
}