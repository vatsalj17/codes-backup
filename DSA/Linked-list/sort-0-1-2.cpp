class Node {
   public:
	int data;
	Node* next;
	Node() {
		this->data = 0;
		next = nullptr;
	}
	Node(int data) {
		this->data = data;
		this->next = nullptr;
	}
	Node(int data, Node* next) {
		this->data = data;
		this->next = next;
	}
};

Node* sortList(Node* head) {
    Node* zero = nullptr;
    Node* zero_t = zero;
    Node* one = nullptr;
    Node* one_t = one;
    Node* two = nullptr;
    Node* two_t = two;
    Node* temp = head;
    while (temp != nullptr) {
        if (temp->data == 0) {
            if (zero == nullptr) {
                zero = temp;
            } else if (zero_t != nullptr) {
                zero_t->next = temp;
            }
            zero_t = temp;
        }
        if (temp->data == 1) {
            if (one == nullptr) {
                one = temp;
            } else if (one_t != nullptr) {
                one_t->next = temp;
            }
            one_t = temp;
        }
        if (temp->data == 2) {
            if (two == nullptr) {
                two = temp;
            } else if (two_t != nullptr) {
                two_t->next = temp;
            }
            two_t = temp;
        }
        temp = temp->next;
    }
    zero_t->next = one;
    one_t->next = two;
    two_t->next = nullptr;
    return zero;
}
