#define _GNU_SOURCE
#include <sys/ptrace.h>
#include <sys/types.h>
#include <sys/wait.h>
#include <sys/user.h>
#include <sys/uio.h>
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <unistd.h>

// This struct defines the layout of the remote memory we want to write
struct iovec local[1];
struct iovec remote[1];

int main(int argc, char *argv[]) {
    if (argc != 3) {
        printf("Usage: %s <PID> <memory_address_of_str>\n", argv[0]);
        return 1;
    }

    pid_t target_pid = atoi(argv[1]);
    
    // We need the address of 'str' in the target process. 
    // In a real scenario, we'd find this by parsing /proc/PID/maps, 
    // but for now, we will print it in the target program to make it easy.
    unsigned long addr = strtoul(argv[2], NULL, 16);

    // 1. Attach to the process (Stops it)
    if (ptrace(PTRACE_ATTACH, target_pid, NULL, NULL) < 0) {
        perror("ptrace attach");
        return 1;
    }
    wait(NULL); // Wait for it to actually stop

    printf("Attached to process %d. Injecting data to %lx...\n", target_pid, addr);

    // 2. The payload we want to write into their memory
    char *payload = "HACKED";
    
    local[0].iov_base = payload;
    local[0].iov_len = strlen(payload) + 1;
    remote[0].iov_base = (void *)addr;
    remote[0].iov_len = strlen(payload) + 1;

    // 3. Write directly to the target's memory
    // process_vm_writev is a faster, modern alternative to PTRACE_POKETEXT
    ssize_t n = process_vm_writev(target_pid, local, 1, remote, 1, 0);
    if (n < 0) {
        perror("vm_writev");
    } else {
        printf("Successfully wrote %ld bytes to target memory.\n", n);
    }

    // 4. Detach and let it resume
    ptrace(PTRACE_DETACH, target_pid, NULL, NULL);
    printf("Detached. Check the target!\n");

    return 0;
}
