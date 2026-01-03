#include "bst.h"
#include <limits.h>
#include <stdlib.h>

bool is_valid(struct TreeNode* root, long long min, long long max) {
    if (root == NULL) return true;
    if (root->val >= max || root->val <= min) return false;
    return is_valid(root->left, min, root->val) && is_valid(root->right, root->val, max);
}

bool isValidBST(struct TreeNode* root) {
    return is_valid(root, LLONG_MIN, LLONG_MAX);
}
