test:
	dart test.dart

all: aotre.png aotre.o aotre

clean:
	rm -f aotre.png aotre.s aotre.ll aotre.o aotredriver.o aotre

aotre.dot: aotre.dart
	dart aotre.dart -d -e 'a.{2}z$$' > aotre.dot

aotre.png: aotre.dot
	dot -Gdpi=150 -T png -o aotre.png aotre.dot
	#open aotre.png

aotre.ll: aotre.dart
	dart aotre.dart -l -e 'a.{2}z$$' -o aotre.ll

aotre.s: aotre.ll
	clang -O3 -S aotre.ll

aotre.o: aotre.s
	clang -O3 -c aotre.s

aotredriver.o: aotre.cc
	clang++ -O3 -c -o aotredriver.o aotre.cc

aotre: aotre.o aotredriver.o
	clang++ -O3 -o aotre aotre.o aotredriver.o
