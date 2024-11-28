#include <stdio.h>
#include <unistd.h>

int main() {
    pid_t pid = getpid();
    pid_t ppid = getppid();

    printf("PID del proceso actual: %d\n", pid);
    printf("PID del proceso padre: %d\n", ppid);

    return 0;
}