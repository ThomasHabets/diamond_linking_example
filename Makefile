CFLAGS=-fPIC -Wall -pedantic
LD=gcc
LDFLAGS=-Wl,-rpath=.

all: libd1.so libd2.so p

%.png: %.dot
	dot -Tpng -o $@ $^

# Base library version 1
libbase.so.1.0: base1.o
	$(LD) -shared \
		-Wl,--default-symver \
		-Wl,-soname,libbase.so.1 \
		-o $@ $<

# Base library version 2
libbase.so.2.0: base2.o
	$(LD) -shared \
		-Wl,--default-symver \
		-Wl,-soname,libbase.so.2 \
		-o $@ $<

# libd1.so:
# * Uses libbase. Compiled against libbase.so.1
# * provides versioned symbols
libd1.so: d1.o libbase.so.1.0
	ldconfig -N -f ld.so.conf
	ln -fs libbase.so.1 libbase.so  # library to link with
	$(LD) $(LDFLAGS) -L. \
		-Wl,--default-symver \
		-Wl,-soname,libd1.so \
		-shared -o $@ $< -lbase
	rm libbase.so

# libd2.so:
# * Uses libbase. Compiled against libbase.so.2
# * provides unversioned symbols
libd2.so: d2.o libbase.so.2.0
	ldconfig -N -f ld.so.conf
	ln -fs libbase.so.2 libbase.so  # library to link with
	$(LD) $(LDFLAGS) -L. \
		-Wl,-soname,libd2.so \
		-shared -o $@ $< -lbase
	rm libbase.so

# p: Test program that depends on both libd1 and libd2.
p: p.o
	$(CC) $(LDFLAGS) -o p p.o -L. -Wl,-rpath=. -ld1 -ld2

clean:
	rm -f *.o *.so *.[012] *~ p *.png
