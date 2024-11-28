#include <pthread.h>
#include <stdio.h>
#include <stdlib.h>
#include <unistd.h>


void* funcion_hilo(void* arg) {
    int id = *((int*)arg);  
    printf("Hilo %d está en ejecución\n", id);
    sleep(5);  
    printf("Hilo %d ha terminado\n", id);
    return NULL;
}

int main() {
    pthread_t hilos[5];  
    int ids[5] = {1, 2, 3,4,5};  

    for (int i = 0; i < 5; i++) {
        if (pthread_create(&hilos[i], NULL, funcion_hilo, (void*)&ids[i]) != 0) {
            perror("Error al crear el hilo");
            return 1;
        }
    }

    for (int i = 0; i < 5; i++) {
        pthread_join(hilos[i], NULL);  
    }

    printf("Todos los hilos han terminado su ejecución.\n");
    return 0;
}
