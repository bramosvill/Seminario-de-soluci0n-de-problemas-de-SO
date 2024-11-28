#include <stdio.h>
#include <unistd.h>

int main() {
    pid_t pid = getpid();

    char filename[32];
    snprintf(filename, sizeof(filename), "/proc/%d/maps", pid);

    FILE *fp = fopen(filename, "r");
    if (fp == NULL) {
        perror("Error al abrir imagen del proceso");
        return 1;
    }
    char line[256];
    while (fgets(line, sizeof(line), fp)) {
   
        printf("%s", line);
    }

    fclose(fp);
    return 0;
}

