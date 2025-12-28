#include <stdlib.h>
#include <stdio.h>

typedef struct Node {
    int val;
    struct Node* next;
} node_t;

node_t* init_node(int val) {
    node_t* new = malloc(sizeof(int));
    new->next = NULL;
    new->val = val;
    return new;
}

void insert_at_tail(node_t** head, int val) {
    node_t* new_node = init_node(val);
    if (*head == NULL) {
        *head = new_node;
        return;
    } else {
        node_t* temp = *head;
        while (temp->next != NULL) temp = temp->next;
        temp->next = new_node;
    }
}

void insertTail(node_t** head, node_t** tail, int val) {
    node_t* new = init_node(val);
    if (*tail != NULL) (*tail)->next = new;
    *tail = new;
    if (*head == NULL) *head = *tail;
}

// Solution
node_t* mergeKSortedLists(node_t** heads, int k) {
	node_t* ans = NULL;
	for (int i = 0; i < k; i++) {
		node_t* first = ans;
		node_t* second = heads[i];
		node_t* new = NULL;
		node_t* tail = new;
		while (first != NULL && second != NULL) {
			if (first->val <= second->val) {
				insertTail(&new, &tail, first->val);
				first = first->next;
			} else if (second->val < first->val) {
				insertTail(&new, &tail, second->val);
				second = second->next;
			}
		}
		while (first != NULL) {
			insertTail(&new, &tail, first->val);
			first = first->next;
		}
		while (second != NULL) {
			insertTail(&new, &tail, second->val);
			second = second->next;
		}
        ans = new;
	}
	return ans;
}

int main(void) {
    node_t* head1 = init_node(1);
    insert_at_tail(&head1, 4);
    insert_at_tail(&head1, 5);
    node_t* head2 = init_node(1);
    insert_at_tail(&head2, 3);
    insert_at_tail(&head2, 4);
    node_t* head3 = init_node(2);
    insert_at_tail(&head3, 6);
    
    int n = 3;
    printf("Enter the no. of lists: ");
    scanf("%d", &n);

    node_t** arr = calloc(n,  sizeof(node_t*));
    for (int i = 0; i < n; i++) arr[i] = NULL;

    for (int i = 0; i < n; i++) {
        int x = 0;
        printf("Enter the length of list %d: ", i + 1);
        scanf("%d", &x);
        printf("Enter list %d: ", i + 1);
        for (int j = 0; j < x; j++) {
            int val;
            scanf(" %d", &val);
            insert_at_tail(&arr[i], val);
        }
    }
    
    
    // arr[0] = head1;
    // arr[1] = head2;
    // arr[2] = head3;
    
    node_t* merged = mergeKSortedLists(arr, n);
    node_t* temp = merged;
    while (temp != NULL) {
        printf("%d ", temp->val);
        temp = temp->next;
    }
    free(arr);
}