test: Foreign/UnsafeSharedMemory.o Foreign/SharedMemory.o
	ghc -c -o Test.o Test.hs
	ghc -o Test Foreign/UnsafeSharedMemory.o Foreign/SharedMemory.o Test.o

libs: Foreign/UnsafeSharedMemory.o Foreign/SharedMemory.o

Foreign/SharedMemory.o:
	ghc -c Foreign/SharedMemory.c

Foreign/UnsafeSharedMemory.o:
	ghc -c Foreign/UnsafeSharedMemory.hs

clean:
	-rm *.hi
	-rm *.o
	-rm Foreign/*.hi
	-rm Foreign/*.o
	-rm Test
