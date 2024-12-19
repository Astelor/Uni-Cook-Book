# include "buffer.h"
# include <stdio.h>
# include <stdlib.h>
# include <pthread.h>
# include <semaphore.h>
# include <unistd.h>

sem_t full_sem, empty_sem;
pthread_mutex_t mutex;
int thread_exit = 1;
struct thread_info {
    pthread_t thread_id;
    int thread_num;
};

void *producer(void *param){
    buffer_item item;
    struct thread_info *tinfo = param;
    while(thread_exit){
        sleep(rand()%4+1 );

        sem_wait(&empty_sem);
        pthread_mutex_lock(&mutex);
        item = rand()%999+1;
        if(insert_item(item) == -1){
            perror("buffer is full\n");
        }
        else{
            printf("[+] <producer %2d> produced %5d\n", tinfo->thread_num, item);
        }

        pthread_mutex_unlock(&mutex); 
        sem_post(&full_sem);
    }
    pthread_exit(NULL);
}

void *consumer(void *param){
    buffer_item item;
    struct thread_info *tinfo = param;
    while(thread_exit){
        sleep(rand()%4+1);

        sem_wait(&full_sem);
        pthread_mutex_lock(&mutex);
        if(remove_item(&item) == -1){
            perror("buffer is empty\n");
        }
        else{
            printf("[-] <consumer %2d> consumed %5d\n", tinfo->thread_num, item);
        }

        pthread_mutex_unlock(&mutex);
        sem_post(&empty_sem);
    }
    pthread_exit(NULL);
}

int main(int argc, char *argv[]){
    buffer_item item;
    int i, stop_time, producer_num, consumer_num;
    struct thread_info* producer_tinfo;
    struct thread_info* consumer_tinfo;
    if(argc!=4){
        printf("parameter: stop time, producer number, consumer number");
        return -1;
    }
    else{
        stop_time = atoi(argv[1]);
        producer_num = atoi(argv[2]);
        consumer_num = atoi(argv[3]);
    }

    srand(time(NULL));
    printf("stop time: %d\n", stop_time);
    printf("producer number: %d\n", producer_num);
    printf("consumer number: %d\n", consumer_num);

    producer_tinfo = calloc(producer_num, sizeof(*producer_tinfo));
    consumer_tinfo = calloc(consumer_num, sizeof(*consumer_tinfo));

    sem_init(&full_sem, 0, 0);
    sem_init(&empty_sem, 0, BUFFER_SIZE);
    pthread_mutex_init(&mutex, NULL);
    
    for(i = 0 ; i < producer_num ; i++){
        producer_tinfo[i].thread_num = i+1;
        int res = pthread_create(&producer_tinfo[i].thread_id, NULL, producer, &producer_tinfo[i]);
        if(res != 0) 
            perror("error when creating producer thread\n");
    }
    for(i = 0 ; i < consumer_num ; i++){
        consumer_tinfo[i].thread_num = i+1;
        int res = pthread_create(&consumer_tinfo[i].thread_id, NULL, consumer, &consumer_tinfo[i]);
        if(res != 0) 
            perror("error when creating consumer thread\n");
    }
    sleep(stop_time);
    thread_exit = 0;
    for(i = 0 ; i < producer_num ; i++)
        pthread_join(producer_tinfo[i].thread_id, NULL);
    for(i = 0 ; i < consumer_num ; i++)
        pthread_join(consumer_tinfo[i].thread_id, NULL);

    while(sem_destroy(&full_sem)!=0){}
    while(sem_destroy(&empty_sem)!=0){} 
    while(pthread_mutex_destroy(&mutex)!=0){}
    printf("exit program\n");
    return 0;
}