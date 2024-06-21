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

function build_default {
	docker build -build-arg VERSION=${VERSION} --build-arg BUILDERVERSION=${BUILDERVERSION} -t kilrah/nextcloud-ffmpeg .
	docker push kilrah/nextcloud-ffmpeg

	VERSION="${VERSION}"-fpm

	docker build -build-arg VERSION=${VERSION} --build-arg BUILDERVERSION=${BUILDERVERSION} -t kilrah/nextcloud-ffmpeg:fpm .
	docker push kilrah/nextcloud-ffmpeg:fpm
}

BUILDERVERSION=29
#VERSION=26.0.13
#build_version
VERSION=27.1.10
build_version
VERSION=28.0.6
build_version
VERSION=29.0.2
build_version

VERSION=29.0.2
build_default
