#include <stdio.h>
#include <stdlib.h>

int main(){
    int n;
    while(1){
        scanf("%d",&n);
        int line,i;
        int **array =malloc((n+1)*(n+1)* sizeof(int));
        for(i = 0; i <= n+2; i++) *(array+i) = malloc((i+1) * sizeof(int));
        for (line = 1; line <= n+2; line++) {
            int coef = 1; 
            for (i = 1; i <= line; i++) { 
                array[line-1][i-1]=coef;
                coef = coef * (line - i) / i;
            }
        }
        for(line=n+1;line>=0;line--){
            for(i=0;i<=line;i++){
                printf("%4d",array[line][i]);
            }
            printf("\n");
        }
        free(array);
    }
    return 0;
}