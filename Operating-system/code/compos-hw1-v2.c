#include <stdio.h>      // standard library
#include <stdlib.h>     // standard library
#include <termios.h>    // for key stroke detection
#include <unistd.h>
#include <string.h>
#include <errno.h>
#include <fcntl.h>

#define MAX_INPUT 100
#define BUF_SIZE 100

struct termios tty; 
void tty_enable(){    
    tcgetattr(STDIN_FILENO, &tty);
    tty.c_lflag |= (ICANON | ECHO); // enable canonical mode and echo
    tcsetattr(STDIN_FILENO, TCSANOW, &tty);
    return;
}

void tty_disable(){
    tcgetattr(STDIN_FILENO, &tty);
    tty.c_lflag &= ~(ICANON | ECHO); // disable canonical mode
    tcsetattr(STDIN_FILENO, TCSANOW, &tty);
    return;
}

// the debugging cat out the file, off when testing
int debug_on = 0;
void input_val(char *input, const char *message){
    // runs until getting a valid input
    while(1){
        printf("%s", message);
        fgets(input, MAX_INPUT , stdin);

        if(debug_on){
            printf("[@] %s\n", input); // it works!??
            printf("[@] length: %ld\n", strlen(input));
        }

        // buffer overflow check
        if(input[strlen(input)-1] != '\n'){
            // input is too long if newline wasn't encountered
            scanf("%*[^\n]"); scanf("%*c"); // clear the buffer
            printf("[-] Not a valid input, please try again.\n");
        }
        else if(input[0]=='\n'){
            continue;
        }
        else{
            // drop the newline
            if(input[strlen(input) - 1] == '\n')
                input[strlen(input) - 1] = 0;
            break;
        }
    }
    return;
}

// new copy util that does the job
void copy_util(char *i_file, char *n_file){
    char buf[BUF_SIZE];
    int fd = open(i_file, O_RDONLY);
    int fw = open(n_file, O_CREAT|O_WRONLY,0644);
    int debug_on = 0;
    if(fd && fw){
        int n;
        while(1){
            if(n = read(fd, buf, BUF_SIZE)){
                // read n bytes, write n bytes to target
                if(write(fw, buf, n)!=n) printf("[-] File write error\n");
            }else{
                close(fd);
                close(fw);
                break;
            }
        }  
        printf("[+] File copied\n"); sleep(1);      
    }else{
        printf("[-] ERROR in copy_util\n");
    }
}

// [@] -> debug
int main(){
    tty_enable();
    int flag = 7; // {3'b111}
    while(flag & 4){
        printf("\n[+] Welcome to the File Copying Interactive Script\n");
        if(debug_on){
            fflush(stdout);
            system("pwd");
        }
        char s_file[MAX_INPUT + 1];
        while(flag & 1){
            input_val(s_file, "[+] Enter source file name: ");
            
            //printf("[=] Your source file is: %s\n", s_file);
            printf("[+] Checking file validity...\n");
            
            // check if the file exist
            if(access(s_file, (F_OK|R_OK)) != 0){
                // file doesn't exist and is not readable
                printf("[-] File doesn't exist.\n"); sleep(1);
                
                // fancy choosing menu
                printf("[?] Press (1) to try again, press (2) to leave the program.\n");
                tty_disable();

                char choice;
                while(choice = getchar()){
                    if(choice =='1'){
                        // try again
                        tty_enable();
                        break;
                    }
                    else if(choice == '2'){
                        // exit program
                        tty_enable();
                        printf("[+] Exit program\n");
                        return 0;
                    }
                    else{
                        // not in the option
                        continue;
                    }
                }
            }
            else{
                // the file exist and readable
                if(debug_on){
                    char cmd[100] = "cat ";
                    strcat(cmd, s_file);
                    //puts("[@] ",);puts(cmd);puts("\n");
                    printf("[@] %s\n", cmd);
                    fflush(stdout);
                    system(cmd);
                }
                printf("[+] File exists!\n"); sleep(1);
                break;
            }
        }

        char d_file[MAX_INPUT+1];
        while(flag & 2){
            input_val(d_file, "[+] Enter destination file name: ");

            //printf("[=] Your d_file name is: %s\n", d_file);
            printf("[+] Checking name validity...\n");

            // check if the file exist
            if(access(d_file, F_OK) == 0){
                // the file name exist
                printf("[-] The file name exist\n"); sleep(1);
                printf("[?] Press (1) to try again, press (2) to overwrite, press (3) to leave the program.\n");
                tty_disable();
                char choice;
                while(choice = getchar()){
                    if(choice == '1'){
                        // try again
                        tty_enable();
                        break;
                    }
                    else if(choice == '2'){
                        // overwrite
                        tty_enable();
                        printf("[+] Overwriting the file...\n"); sleep(1);
                        if(debug_on){
                            printf("[@] s_file: %s, %ld\n", s_file, strlen(s_file));
                            printf("[@] d_file: %s, %ld\n", d_file, strlen(d_file));
                        }
                        // check if s_file and d_file are the same
                        if(strcmp(s_file, d_file ) == 0){
                            printf("[-] Source file and destination file name are the same, nothing changed\n");
                        }
                        else copy_util(s_file, d_file);
                        
                        // unset while-loop flag to leave the loop fully
                        flag &= ~2;
                        printf("[+] File overwritten\n"); sleep(1);
                        break;
                    }
                    else if(choice == '3'){
                        // exit program
                        tty_enable();
                        printf("[+] Exit program\n");
                        return 0;
                    }
                    else{
                        // not in the option
                        continue;
                    }
                }
            }
            else{
                // the file doesn't exist = file name usable
                printf("[+] File name valid!\n"); sleep(1);
                printf("[+] Copying source file to destination file name...\n");
                copy_util(s_file, d_file);
                break;
            }
        }
        printf("[+] Script complete\n"); sleep(1);
        printf("[?] Press (1) to run script again, press (2) to leave the program\n");
        tty_disable();
        char choice;
        while(choice = getchar()){
            if(choice == '1'){
                // run again
                flag = 7;
                tty_enable();
                break;
            }
            else if(choice == '2'){
                // exit program
                tty_enable();
                printf("[+] Exit program\n");
                return 0;
                break;
            }
            else
                // not in the option
                continue;
        }
    }
    return 0;
}