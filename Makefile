#versionMaj := 1
#versionMin := 2
#versionPatch := 3
#version := $(versionMaj).$(versionMin).$(versionPatch).$(TRAVIS_BUILD_NUMBER)
version := $(TRAVIS_TAG).$(TRAVIS_BUILD_NUMBER)

packageNameNix := "gossamer-linux-amd64-$(version).tar.gz"
packageNameNixLatest := "gossamer-linux-amd64-latest.tar.gz"
packageNameMac := "gossamer-darwin-amd64-$(version).tar.gz"
packageNameMacLatest := "gossamer-darwin-amd64-latest.tar.gz"
packageNameWindows := "gossamer-windows-amd64-$(version).tar.gz"
packageNameWindowsLatest := "gossamer-windows-amd64-latest.tar.gz"

build: build-linux build-mac build-windows

build-linux:
	mkdir build
	export GOOS="linux"
	export GOARCH="amd64"
	go build -o ./build/gossamer -ldflags "-X main.version=$(version)"
	cd ./build && tar zcfv ../$(packageNameNix) . && cd ..

build-mac:
	mkdir build
	export GOOS="darwin"
	export GOARCH="amd64"
	go build -o ./build/gossamer -ldflags "-X main.version=$(version)"
	cd ./build && tar zcfv ../$(packageNameMac) . && cd ..

build-windows:
	mkdir build
	export GOOS="windows"
	export GOARCH="amd64"
	go build -o ./build/gossamer.exe -ldflags "-X main.version=$(version)"
	cd ./build && tar zcfv ../$(packageNameWindows) . && cd ..
