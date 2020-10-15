clean:
	rm -rf dist/

build-docker:
	bash rcp-scripts/build-docker.sh

build: clean build-docker

