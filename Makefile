all: play.S
	gcc -v play.S -o play.out
vector.out: vector.S
	gcc vector.S -o vector.out
clean:
	rm -f *.out *.o *.s
