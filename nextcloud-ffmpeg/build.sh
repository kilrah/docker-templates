#!/bin/bash

function build_version {
	local MAJOR_VERSION="${VERSION%%.*}"

	docker build --build-arg VERSION=${VERSION} --build-arg BUILDERVERSION=${BUILDERVERSION} -t kilrah/nextcloud-ffmpeg:"${VERSION}" .
	docker build --build-arg VERSION=${VERSION} --build-arg BUILDERVERSION=${BUILDERVERSION} -t kilrah/nextcloud-ffmpeg:"${MAJOR_VERSION}" .
	docker push kilrah/nextcloud-ffmpeg:"${VERSION}"
	docker push kilrah/nextcloud-ffmpeg:"${MAJOR_VERSION}"

	VERSION="${VERSION}"-fpm
	MAJOR_VERSION="${MAJOR_VERSION}"-fpm

	docker build --build-arg VERSION=${VERSION} --build-arg BUILDERVERSION=${BUILDERVERSION} -t kilrah/nextcloud-ffmpeg:"${VERSION}" .
	docker build --build-arg VERSION=${VERSION} --build-arg BUILDERVERSION=${BUILDERVERSION} -t kilrah/nextcloud-ffmpeg:"${MAJOR_VERSION}" .
	docker push kilrah/nextcloud-ffmpeg:"${VERSION}"
	docker push kilrah/nextcloud-ffmpeg:"${MAJOR_VERSION}"
}

function build_version_31 {
	local MAJOR_VERSION="${VERSION%%.*}"

	docker build --build-arg VERSION=${VERSION} --build-arg BUILDERVERSION=${BUILDERVERSION} -t kilrah/nextcloud-ffmpeg:"${VERSION}" . -f Dockerfile-31
	docker build --build-arg VERSION=${VERSION} --build-arg BUILDERVERSION=${BUILDERVERSION} -t kilrah/nextcloud-ffmpeg:"${MAJOR_VERSION}" .  -f Dockerfile-31
	docker push kilrah/nextcloud-ffmpeg:"${VERSION}"
	docker push kilrah/nextcloud-ffmpeg:"${MAJOR_VERSION}"

	VERSION="${VERSION}"-fpm
	MAJOR_VERSION="${MAJOR_VERSION}"-fpm

	docker build --build-arg VERSION=${VERSION} --build-arg BUILDERVERSION=${BUILDERVERSION} -t kilrah/nextcloud-ffmpeg:"${VERSION}" .  -f Dockerfile-31
	docker build --build-arg VERSION=${VERSION} --build-arg BUILDERVERSION=${BUILDERVERSION} -t kilrah/nextcloud-ffmpeg:"${MAJOR_VERSION}" .  -f Dockerfile-31
	docker push kilrah/nextcloud-ffmpeg:"${VERSION}"
	docker push kilrah/nextcloud-ffmpeg:"${MAJOR_VERSION}"
}

function build_default {
	docker tag kilrah/nextcloud-ffmpeg:${VERSION} kilrah/nextcloud-ffmpeg
	docker push kilrah/nextcloud-ffmpeg

	VERSION="${VERSION}"-fpm

	docker tag kilrah/nextcloud-ffmpeg:${VERSION} kilrah/nextcloud-ffmpeg:fpm
	docker push kilrah/nextcloud-ffmpeg:fpm
}

BUILDERVERSION=30
#VERSION=26.0.13
#build_version
#VERSION=27.1.11
#build_version
#VERSION=28.0.14
#build_version
VERSION=29.0.14
build_version
VERSION=30.0.8
build_version

BUILDERVERSION=31
VERSION=31.0.2
build_version_31

VERSION=31.0.2
build_default
