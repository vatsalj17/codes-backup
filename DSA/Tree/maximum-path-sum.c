#include <stdlib.h>

struct TreeNode {
    int val;
    struct TreeNode *left;
    struct TreeNode *right;
};

int maximum(int a, int b, int c, int d) {
    int max = a;
    if (b > max) max = b;
    if (c > max) max = c;
    if (d > max) max = d;
    return max;
}

int diameter(struct TreeNode* root, int* max) {
    if (root == NULL) return 0;
    int left = diameter(root->left, max);
    int right = diameter(root->right, max);
    int m = maximum(root->val, root->val + left, root->val + right, root->val + left + right);
    if (m >= *max) *max = m;
    return m;
}

int maxPathSum(struct TreeNode* root) {
    int max = 0;
    diameter(root, &max);
    return max;
}
