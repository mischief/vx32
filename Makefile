NCPU := $(shell grep "^processor" /proc/cpuinfo | wc -l)
UID := $(shell id -u)
GID := $(shell id -g)

all: bin/9vx

bin/9vx: builder
	docker run -u ${UID}:${GID} --rm -e NCPU=${NCPU} -v ${PWD}:/opt mischief/9vx-builder:latest /bin/bash -c "\
		cd /opt/src; \
		make clean && make -j ${NCPU}; \
		cp 9vx/9vx /opt/bin/9vx; \
	"

image: bin/9vx
	docker build -t mischief/9vx:latest -f docker/image/Dockerfile .

builder:
	docker build -t mischief/9vx-builder:latest docker/build

clean:
	rm -f bin/9vx
	docker rmi -f mischief/9vx-builder:latest || true
	docker rmi -f mischief/9vx:latest || true

.PHONY: all clean

