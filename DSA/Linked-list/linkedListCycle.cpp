#include <unordered_map>

#include "list.hpp"

ListNode* detectCycle(ListNode* head) {
	struct ListNode* temp = head;
	std::unordered_map<ListNode*, bool> hi;
	while (temp != NULL) {
		auto d = hi.find(temp);
		if (d == hi.end()) {
			hi[temp] = true;
		} else {
			break;
		}
		temp = temp->next;
	}
	return temp;
}
