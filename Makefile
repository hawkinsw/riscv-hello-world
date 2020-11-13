all: play.S
	gcc -v play.S -o play.out
clean:
	rm -f *.out *.o *.s
