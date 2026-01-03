#include "bst.h"
#include <stdlib.h>

struct TreeNode* bstFromPreorder(int* preorder, int preorderSize) {
    struct TreeNode* root = NULL;
    for (int i = 0; i < preorderSize; i++) bst_insert_node(&root, preorder[i]);
    return root;
}
