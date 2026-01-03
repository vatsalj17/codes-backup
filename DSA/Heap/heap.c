#include <stdbool.h>
#include <stdlib.h>

#include "../utils/mystd.h"

typedef struct MaxHeap {
	int* arr;
	size_t size;
	size_t capacity;
} max_heap;

max_heap* max_heap_init(size_t capacity) {
	max_heap* heap = malloc(sizeof(max_heap));
	if (!heap) return NULL;
	heap->size = 0;
	heap->capacity = capacity + 1;
	heap->arr = calloc(capacity + 1, sizeof(int));
	return heap;
}

bool max_heap_insert(max_heap* heap, int value) {
	if (heap->size >= heap->capacity) return false;
	size_t index = ++heap->size;
	heap->arr[index] = value;
	while (index > 1) {
		size_t parent = index / 2;
		if (heap->arr[parent] < heap->arr[index]) {
			swap(&heap->arr[parent], &heap->arr[index]);
		} else {
			break;
		}
	}
	return true;
}

static void print_heap_tree(int* heap, int n, int i, int depth) {
	if (i > n) return;
	print_heap_tree(heap, n, 2 * i + 1, depth + 1);
	for (int j = 0; j < depth; j++)
		printf("    ");
	printf("%d\n", heap[i]);
	print_heap_tree(heap, n, 2 * i, depth + 1);
}

void print_heap(max_heap* heap) {
	print_heap_tree(heap->arr, heap->size, 1, 0);
}

int main(void) {
	max_heap* h = max_heap_init(5);
	int arr[5] = {50, 55, 53, 52, 54};
	for (size_t i = 0; i < sizeof(arr) / sizeof(arr[0]); i++) {
		max_heap_insert(h, arr[i]);
	}
	print_heap(h);
}
