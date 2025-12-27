#include <stdlib.h>

#include "list.h"

// 83.
struct ListNode* deleteDuplicates_(struct ListNode* head) {
	if (head == NULL) return NULL;
	typedef struct ListNode node_t;
	node_t* temp = head;
	while (temp->next != NULL) {
		if (temp->val == temp->next->val)
			temp->next = temp->next->next;
		else
			temp = temp->next;
	}
	return head;
}

struct ListNode* deleteDuplicates(struct ListNode* head) {
	if (head == NULL) return NULL;
	typedef struct ListNode node_t;
	node_t* temp = head;
	node_t* prev = NULL;
	while (temp != NULL && temp->next != NULL) {
		if (temp->val == temp->next->val) {
            int eq = temp->val;
            while (temp != NULL && temp->val == eq) {
                temp = temp->next;
            }
            if (prev == NULL && temp == NULL) return NULL;
            else if (prev == NULL) head = temp;
            else if (temp == NULL) prev->next = temp = NULL;
            else prev->next = temp;
		} else {
            prev = temp;
			temp = temp->next;
		}
	}
	return head;
}
