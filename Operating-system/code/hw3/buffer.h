# ifndef BUFFER_H_ 
# define BUFFER_H_

# define BUFFER_SIZE 5
typedef int buffer_item;

int insert_item(buffer_item);
int remove_item(buffer_item *);

#endif