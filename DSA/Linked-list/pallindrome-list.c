#include <stdbool.h>
#include <math.h>
#include <sys/types.h>
#include "list.h"
#include <stdio.h>

// shitty logic, could have used array but what about space
bool isPalindrome_old(struct ListNode* head) {
    uint o = 0;
    uint r = 0;
    int i = 0;
    struct ListNode* temp = head;
    while (temp != NULL) {
        o = 10 * o + temp->val;
        r += pow(10, i) * temp->val;
        temp = temp->next;
    }
    if (o == r) return true;
    return false;
}

struct ListNode* rev(struct ListNode* head) {
    typedef struct ListNode list;
    list* prev = NULL;
    list* curr = head;
    list* next = NULL;
    while (curr != NULL) {
        next = curr->next;
        curr->next = prev;
        prev = curr;
        curr = next;
    }
    return prev;
}

bool isPalindrome(struct ListNode* head) {
    int count = 0;
    struct ListNode* temp = head;
    while (temp != NULL) {
        temp = temp->next;
        count++;
    }
    if (count <= 1) return true;
    int mid = count / 2;
    temp = head;
    struct ListNode* other_head;
    struct ListNode* prev = NULL;
    int i = 0;
    while (i <= mid) {
        i++;
        prev = temp;
        temp = temp->next;
    }
    if (temp == NULL) {
        printf("nah");
        return false;
    }
    if (count & 1) other_head = temp->next;
    else other_head = temp;
    prev->next = NULL;
    struct ListNode* new = rev(other_head);
    temp = head;
    struct ListNode* temp2 = new;
    while (temp != NULL && temp2 != NULL) {
        if (temp->val != temp2->val) return false;
        temp = temp->next;
        temp2 = temp2->next;
    }

    return true;
}
