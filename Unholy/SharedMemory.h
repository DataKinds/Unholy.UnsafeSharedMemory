int initSharedMemory(unsigned int size);
int resizeSharedMemory(unsigned int size);
unsigned int getSharedMemorySize();
int writeSharedMemory(char byte, unsigned int byteIndex);
int readSharedMemory(char *byteOut, unsigned int byteIndex);
void freeSharedMemory();
