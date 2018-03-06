test: Unholy/UnsafeSharedMemory.o Unholy/SharedMemory.o
	ghc -c -o Test.o Test.hs
	ghc -o Test Unholy/UnsafeSharedMemory.o Unholy/SharedMemory.o Test.o

libs: Unholy/UnsafeSharedMemory.o Unholy/SharedMemory.o

Unholy/SharedMemory.o:
	ghc -c Unholy/SharedMemory.c

Unholy/UnsafeSharedMemory.o:
	ghc -c Unholy/UnsafeSharedMemory.hs

clean:
	-rm *.hi
	-rm *.o
	-rm Unholy/*.hi
	-rm Unholy/*.o
	-rm Test
