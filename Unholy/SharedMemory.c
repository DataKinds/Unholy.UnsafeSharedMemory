#include <stdlib.h>
#include "SharedMemory.h"

char* sharedMemory;
unsigned int sharedMemorySize;

int initSharedMemory(unsigned int size) {
    sharedMemory = (char*)malloc(size);
    if (sharedMemory == NULL) {
        return 0;
    } else {
        sharedMemorySize = size;
        return 1;
    }
}

int resizeSharedMemory(unsigned int size) {
    sharedMemory = (char*)realloc(sharedMemory, size);
    if (sharedMemory == NULL) {
        return 0;
    } else {
        sharedMemorySize = size;
        return 1;
    }
}

unsigned int getSharedMemorySize() {
    return sharedMemorySize;
}

int writeSharedMemory(char byte, unsigned int byteIndex) {
    if (byteIndex >= sharedMemorySize) {
        return 0;
    } else {
        sharedMemory[byteIndex] = byte;
        return 1;
    }
}

int readSharedMemory(char *byteOut, unsigned int byteIndex) {
    if (byteIndex >= sharedMemorySize) {
        return 0;
    } else {
        *byteOut = sharedMemory[byteIndex];
        return 1;
    }
}

void freeSharedMemory() {
    free(sharedMemory);
}
