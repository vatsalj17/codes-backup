#include <stdlib.h>
#include "list.h"

void insertTail(node_t** head, node_t** tail, int value) {
    node_t* new = createNode(value);
    if (*tail != NULL) (*tail)->next = new;
    *tail = new;
    if (*head == NULL) *head = *tail;
}

struct ListNode* mergeTwoLists(struct ListNode* list1, struct ListNode* list2) {
    typedef struct ListNode node_t;
    node_t* first = list1;
    node_t* second = list2;
    node_t* ans = NULL;
    node_t* tail = ans;
    while (first != NULL && second != NULL) {
        if (first->val <= second->val) {
            insertTail(&ans, &tail, first->val);
            first = first->next;
        }
        else if (second->val < first->val) {
            insertTail(&ans, &tail, second->val);
            second = second->next;
        }
    }
    while(first != NULL) {
        insertTail(&ans, &tail, first->val);
        first = first->next;
    }
    while(second != NULL) {
        insertTail(&ans, &tail, second->val);
        second = second->next;
    }
    return ans;
}
