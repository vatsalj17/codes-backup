#include <stdio.h>
#include "bt.h"

int inorder(treenode* root, int* i, int k) {
	if (root == NULL) {
		return -1;
	}
	int left = inorder(root->left, i, k);
    if (left != -1) return left;
    if (*i == k - 1) return root->val;
    (*i)++;
	return inorder(root->right, i, k);
}

int kthSmallest(struct TreeNode* root, int k) {
	int i = 0;
	int ans = inorder(root, &i, k);
    return ans;
}
