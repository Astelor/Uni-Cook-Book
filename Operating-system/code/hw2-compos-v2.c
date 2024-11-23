/* 
 * Author: Astelor
 * Environment: Linux
 * Comment:
 *  please note that the termios.h library
 *  is linux exclusive, any attempt to run this code
 *  without using gcc or linux will be unsuccessful.
 * 
 *  please include this section of comment if you copy my spaghetti code.
 */

#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <pthread.h>
#include <unistd.h>
#include <termios.h>    // for key stroke detection

#define MAX_INPUT 100
#define BUF_SIZE 100
#define FILE_SIZE 5000

void *runner(void* param);
void *runner4();
void number_crawler(int param);
void sort(int param);
int comp(const void *a, const void *b);

struct thread_info {    /* Used as argument to runner() */
    pthread_t thread_id;        /* ID returned by pthread_create() */
    int       thread_num;       /* Application-defined thread # */
};
int num[FILE_SIZE];
int num_length;
int sum_global[5];
int str[5][FILE_SIZE]; 
int str_length[5];

struct termios tty;
// 1->enable canonical mode and echo, 0->disable canonical mode and echo
void tty_enable(int param);

int main(void)
{
    unsigned int flag=3;
    char file_source[BUF_SIZE];
    while(flag&2)
    {
        printf("Enter source filename: "); // Ast: not bothering with bound check this time :P
        int ret = scanf("%s", &file_source);
        if(ret==EOF) continue; 
        else if( access(file_source, (F_OK|R_OK)) != 0 ) // the file does not exist
        {
            printf("[?] Press (a) to try again, (b) to leave the program.\n");
            tty_enable(0);
            char choice;
            while(choice = getchar())
            {
                if(choice == 'a') // try again, go back to file name input
                {
                    tty_enable(1);
                    break;
                }
                else if(choice == 'b') // exit program
                { 
                    tty_enable(1);
                    printf("(b) Exit program\n");
                    return 0;
                }
                else continue; // not in the option, keep in loop
            }
        }
        else break; // file name exist, all clear 
    }
    FILE* fp;
    fp = fopen(file_source, "r");
    if(fp == NULL) 
    {
        perror("fopen() error");
        return 0;
    }
    int i;
    num_length      = 0; // counter for num_out
    int counter_str = 0; // counter for buf_str
    char buf, buf_str[BUF_SIZE] = {};

    // read the entire input file to num[]
    while(fread(&buf, sizeof buf, 1, fp) == 1)
    {
        if(buf == ',' || buf == '\n')
        { 
            int temp=0;
            for(i = 0 ; i < counter_str ; i++)
            {
                temp*=10;
                temp += buf_str[i]-48;
            }
            num[num_length++] = temp; // convert the string to number
            strcpy(buf_str, ""); // reset the string
            counter_str = 0;
        }
        else
            buf_str[counter_str++] = buf; // append the new character to the string
    }
    fclose(fp);

    // threading here
    int thr_cnt=4;
    struct thread_info *tinfo;
    tinfo = calloc(thr_cnt + 1, sizeof(*tinfo));
    for(i = 0 ; i < thr_cnt ; i++)
    {
        tinfo[i].thread_num = i;
        pthread_create(&tinfo[i].thread_id, NULL, runner, &tinfo[i]);
    }

    char file_des[BUF_SIZE];
    while(flag&1)
    {
        printf("Enter destination filename: "); // Ast: not bothering with bound check this time :P
        int ret = scanf("%s", &file_des);
        if(ret==EOF) continue; 
        else if( access(file_des, F_OK) == 0 ) // the file name exist
        {
            printf("Press (a) to try again, (b) to overwrite, (c) to leave the program.\n");
            tty_enable(0);
            char choice;
            while(choice = getchar())
            {
                if(choice == 'a') // try again, go back to file name input
                {
                    tty_enable(1);
                    break;
                }
                else if(choice == 'b') // overwrite
                {
                    tty_enable(1); printf("(b) Overwrite\n");
                    flag &= ~1; // 2'b_0
                    break;
                }
                else if(choice == 'c'){ // exit program
                    printf("(c) Exit program\n");
                    tty_enable(1);
                    return 0;
                }
                else continue; // not in the option, keep in loop
            }
        }
        else break; // file name does not exist, create a new one.
    }
    
    // write to file here
    FILE* fp2 = fopen(file_des, "wb");
    for(int k = 0 ; k < thr_cnt ; k++)// threads
    {
        pthread_join(tinfo[k].thread_id, NULL);
        fprintf(fp2,"Thread %d: ", k+1);
        for(i = 0 ; i < str_length[k] - 1 ; i++)
        {
            fprintf(fp2, "%d,", str[k][i]);
        }
        fprintf(fp2, "%d\nsum %d: %d\n", str[k][str_length[k]-1], k+1, sum_global[k]);
    }
    fprintf(fp2, "=================================================\n");
    
    // fifth thread
    pthread_create(&tinfo[4].thread_id, NULL, runner4, NULL);
    pthread_join(tinfo[4].thread_id, NULL);
    for(i = 0 ; i < num_length - 1 ; i++) fprintf(fp2, "%d,", str[4][i]); // all
    fprintf(fp2, "%d\n", str[4][num_length-1]);
    fclose(fp2);
    return 0;
}

void *runner(void *param)
{
    struct thread_info *tinfo = param;
    number_crawler(tinfo->thread_num); 
    sort(tinfo->thread_num); 
    pthread_exit; 
}

void *runner4()
{ // merge str[0~3]
    int counter=0;
    for(int k = 0; k < 4 ;k++)
    {
        for(int i = 0 ; i < str_length[k] ; i++)
        {
            str[4][counter++] = str[k][i];
        }
    }
    str_length[4] = counter;
    sort(4);
    pthread_exit;
}

void number_crawler(int param)
{ // crawling number
    int counter=0;
    sum_global[param] = 0;
    for(int i = param ; i < num_length ; i += 4)
    {
        str[param][counter++] = num[i];
        sum_global[param] += num[i];
    }
    str_length[param] = counter;
    return;
}

void sort(int param)
{ // sorting number
    qsort(str[param], str_length[param], sizeof str[0][0], comp);
    return;
}

int comp(const void* a, const void* b){ return (*(int*)a - *(int*)b); }

void tty_enable(int param){
    tcgetattr(STDIN_FILENO, &tty);
    if(param) tty.c_lflag |= (ICANON | ECHO); // enable canonical mode and echo
    else tty.c_lflag &= ~(ICANON | ECHO); // disable canonical mode and echo
    tcsetattr(STDIN_FILENO, TCSANOW, &tty);
    return;
}