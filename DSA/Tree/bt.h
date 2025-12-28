#ifndef BT_H
#define BT_H

typedef struct TreeNode {
    int value;
    struct TreeNode* left;
    struct TreeNode* right;
} treenode;

treenode* tree_node_init(int value);
int height(treenode* root, int level);
void printtree(treenode* root);
int count_nodes(treenode* root);
void destroytree(treenode* root);

#endif
