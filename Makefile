.PHONY: all build test clean

all: build

build:
	hbmk2 lib.hbp

test:
	hbmk2 -run tests.hbp

clean:
	rm libhbunit.*