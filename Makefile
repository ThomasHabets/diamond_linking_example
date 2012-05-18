CFLAGS=-fPIC -Wall -pedantic
LD=gcc
LDFLAGS=-Wl,-rpath=.

all: libd1.so libd2.so p

libbase.so.1.0: base1.o
	$(LD) -shared \
		-Wl,--default-symver \
		-Wl,-soname,libbase.so.1 \
		-o $@ $<

libbase.so.2.0: base2.o
	$(LD) -shared \
		-Wl,--default-symver \
		-Wl,-soname,libbase.so.2 \
		-o $@ $<

libd1.so: d1.o libbase.so.1.0
	ln -fs libbase.so.1.0 libbase.so.1
	ln -fs libbase.so.1 libbase.so
	$(LD) $(LDFLAGS) -L. -shared -o $@ $< -lbase

libd2.so: d2.o libbase.so.2.0
	ln -fs libbase.so.2.0 libbase.so.2
	ln -fs libbase.so.2 libbase.so
	$(LD) $(LDFLAGS) -L. -shared -o $@ $< -lbase

p: p.o
	ln -fs libbase.so.1.0 libbase.so
	$(CC) $(LDFLAGS) -o p p.o -L. -Wl,-rpath=. -ld1 -ld2

clean:
	rm -f *.o *.so *.1 *.2 *~ *.0 p
