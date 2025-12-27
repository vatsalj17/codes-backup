#include <limits.h>
#include <stdlib.h>

struct TreeNode {
	int val;
	struct TreeNode* left;
	struct TreeNode* right;
};

int maximum(int a, int b, int c, int d) {
	int max = a;
	if (b > max) max = b;
	if (c > max) max = c;
    if (d > max) max = d;
	return max;
}

// failed
int find(struct TreeNode* root, int* max) {
	if (root == NULL) return 0;
	int left = find(root->left, max);
	int right = find(root->right, max);
	int m = (left > right) ? left : right;
	int val = maximum(root->val, root->val + left, root->val + right, root->val + left + right); 
	if (val >= *max) *max = val;
	return root->val + m;
}

// correct
int findpath(struct TreeNode* root, int* max) {
	if (root == NULL) return 0;
	int left = findpath(root->left, max);
	int right = findpath(root->right, max);
    left = (left > 0)? left : 0;
    right = (right > 0)? right : 0;
	int m = (left > right) ? left : right;
	int val = root->val + right + left;
	if (val >= *max) *max = val;
	return root->val + m;
}

int maxPathSum(struct TreeNode* root) {
	int max = INT_MIN;
	findpath(root, &max);
	return max;
}
