#include <stdio.h>
#include <sys/ioctl.h>
#include <fcntl.h>
#include <unistd.h>
#include <string.h>

int main(int argc, char *argv[]) {
    if (argc != 3) {
        printf("Usage: %s <PID> <string>\n", argv[0]);
        return 1;
    }

    char path[256];
    snprintf(path, sizeof(path), "/proc/%s/fd/0", argv[1]);

    int fd = open(path, O_WRONLY);
    if (fd < 0) {
        perror("Could not open target fd");
        return 1;
    }

    char *input = argv[2];
    for (int i = 0; i < strlen(input); i++) {
        if (ioctl(fd, TIOCSTI, &input[i]) < 0) {
            perror("ioctl TIOCSTI failed");
            close(fd);
            return 1;
        }
    }

    char newline = '\n';
    ioctl(fd, TIOCSTI, &newline);

    printf("Injected '%s' into PID %s\n", input, argv[1]);
    close(fd);
    return 0;
}
