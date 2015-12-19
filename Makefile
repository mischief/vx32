NCPU := $(shell grep "^processor" /proc/cpuinfo | wc -l)
UID := $(shell id -u)
GID := $(shell id -g)

all: 9vx

9vx: bin/9vx

bin/9vx:
	@if ! docker inspect mischief/9vx-builder:latest >/dev/null; then \
		echo "run make builder to create the 9vx docker build image"; \
		exit 1; \
	fi
	@docker run --rm -e NCPU=${NCPU} -e UID=${UID} -e GID=${GID} -v ${PWD}:/tmp/vx32 mischief/9vx-builder:latest /bin/sh -xc "\
		cd /tmp/vx32/src && \
		make clean && make -j ${NCPU} && \
		cp 9vx/9vx /tmp/vx32/bin/9vx && \
		chown -R ${UID}:${GID} /tmp/vx32; \
	"

image: bin/9vx
	docker build -t mischief/9vx:latest -f docker/image/Dockerfile .

builder:
	docker build -t mischief/9vx-builder:latest docker/build

clean:
	rm -f bin/9vx

nuke:
	docker rmi -f mischief/9vx-builder:latest || true
	docker rmi -f mischief/9vx:latest || true

.PHONY: all clean nuke

