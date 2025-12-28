#include <stdlib.h>

typedef struct TreeNode {
    int val;
    struct TreeNode* left;
    struct TreeNode* right;
} treenode_t;

treenode_t* node_init(int val) {
    treenode_t* new = malloc(sizeof(treenode_t));
    new->val = val;
    new->left = NULL;
    new->right = NULL;
}

void burnBinaryTree(treenode_t* root, int target) {

}

int main(void) {
    treenode_t* n1 = node_init(12);
    treenode_t* n2 = node_init(13);
    treenode_t* n3 = node_init(10);
    treenode_t* n4 = node_init(14);
    treenode_t* n5 = node_init(15);
    treenode_t* n6 = node_init(21);
    treenode_t* n7 = node_init(24);
    treenode_t* n8 = node_init(22);
    treenode_t* n9 = node_init(23);
    n1->left = n2;
    n1->right = n3;
    n3->left = n4;
    n3->right = n5;
    n4->left = n6;
    n4->right = n7;
    n5->left = n8;
    n5->right = n9;
    
    int target = 14;
    burnBinaryTree(n1, target);
}