#include <unordered_set>
#include <iostream>

#include "list.hpp"

/* class Node {
   public:
	int val;
	Node* next;
	Node() : val(0), next(nullptr) {}
	Node(int x) : val(x), next(nullptr) {}
	Node(int x, Node* next) : val(x), next(next) {}
}; */

Node* removeDuplicates(Node* head) {
	Node* temp = head;
	Node* prev = NULL;
	std::unordered_set<int> v;
	while (temp != NULL) {
		auto d = v.count(temp->val);
		if (!d) {
            v.insert(temp->val);
			prev = temp;
		} else {
			prev->next = temp->next;
		}
		temp = temp->next;
	}
	return head;
}

int main(void) {
    Node* head = new Node;
    Node n1(1);
    Node n2(2, &n1);
    Node n3(2, &n2);
    head = &n3;
    Node *temp = head;
    while (temp != NULL) {
        std::cout << temp->val << ", ";
        temp = temp->next;
    }
    std::cout << std::endl;
    Node* ans = removeDuplicates(head);
    temp = ans;
    while (temp != NULL) {
        std::cout << temp->val << ", ";
        temp = temp->next;
    }
    std::cout << std::endl;
}
