#include <stdlib.h>

#include "list.h"

struct ListNode* floydDetectLoop(struct ListNode* head) {
	struct ListNode* slow = head;
	struct ListNode* fast = head;
	while (slow != NULL && fast != NULL) {
		fast = fast->next;
		if (fast != NULL) fast = fast->next;
		slow = slow->next;
		if (fast == slow) return slow;
	}
	return NULL;
}

struct ListNode* detectCycle(struct ListNode* head) {
    if (head == NULL) return head;
    typedef struct ListNode node;
    node* intersection = floydDetectLoop(head);
    if (intersection == NULL) return NULL;
    node* temp = head;
    while (intersection != temp) {
        temp = temp->next;
        intersection = intersection->next;
    }
    return temp;
}
