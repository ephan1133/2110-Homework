#include "list.h"

#include <stdio.h>

void print_list(LinkedList* list) {
    if(!list) {
        printf("List is NULL\n");
        return;
    }

    printf("List size : %i \n", list -> size);
    Node *curr = list -> head;
    int index = 0;
    while(curr != NULL) {
        printf("Index : %i, Data : %s, NextAddress : %p\n", index, curr -> data, curr -> next);
        index++;
        curr = curr -> next;
    }
}

int main(void) {
    printf("Test\n");
}
