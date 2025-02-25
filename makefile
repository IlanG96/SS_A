CL=ar -rcs
AR=ar
FLAGS=-Wall -g
CC=gcc
OBJECTS_MAIN=main.o

all:libclassloops.so libclassrec.so libclassrec.a libclassloops.a maindrec maindloop mains

mains:main.o libclassrec.a
		$(CC) $(FLAGS) -o mains $(OBJECTS_MAIN) libclassrec.a -lm
#dinamic lib need ./ so the lib start without ./ error cannot open shared object file: No such file or directory.
maindloop:main.o libclassloops.so
		$(CC) $(FLAGS) -o maindloop $(OBJECTS_MAIN) ./libclassloops.so -lm 
maindrec:main.o libclassrec.so
		$(CC) $(FLAGS) -o maindrec $(OBJECTS_MAIN) ./libclassrec.so -lm 
main.o:main.c NumClass.h
	$(CC) $(FLAGS) -c main.c -lm





advancedClassificationRecursion.o: advancedClassificationRecursion.c NumClass.h
	$(CC) $(FLAGS)  -c advancedClassificationRecursion.c 
advancedClassificationLoop.o: advancedClassificationLoop.c NumClass.h
	$(CC) $(FLAGS) -c advancedClassificationLoop.c -lm
basicClassification.o: basicClassification.c NumClass.h
	$(CC) $(FLAGS) -c basicClassification.c -lm 
#create the static folder of the finctions with loops
loops: libclassloops.a
libclassloops.a: main.o advancedClassificationLoop.o basicClassification.o 
	$(CL) libclassloops.a advancedClassificationLoop.o basicClassification.o
#create the static folder of the function with recursion and basic
recursives: libclassrec.a 
libclassrec.a: main.o advancedClassificationRecursion.o basicClassification.o 
	 $(CL) libclassrec.a advancedClassificationRecursion.o basicClassification.o 
#create a dinamic folder with the recursion functions and basic
recursived: libclassrec.so
libclassrec.so: advancedClassificationRecursion.o basicClassification.o NumClass.h main.o
	$(CC) -shared -o libclassrec.so advancedClassificationRecursion.o basicClassification.o 
#create a dinamic folder with loops functions and basic
loopd: libclassloops.so 
libclassloops.so:advancedClassificationLoop.o basicClassification.o NumClass.h main.o
	$(CC) -shared -o libclassloops.so advancedClassificationLoop.o basicClassification.o 

.PHONY: clean all

clean:
		rm -f *.o *.a *.so mains maindloop maindrec






