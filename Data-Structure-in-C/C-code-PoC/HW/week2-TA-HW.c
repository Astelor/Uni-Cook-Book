//[REDACTED]
#include <stdio.h>
#define maxlen 100

int main(void){
    int arr[maxlen]={},n=0;
    char c;
    while((c = getchar()) !=EOF && c!='\n'){
        if(c>='0'&&c<='9'){
            arr[n++]=c-'0';
        }
    }
    for(int i=n-1;i>=0;i--){
        printf("%d",arr[i]);
    }
    printf("\n");
    return 0;
}
