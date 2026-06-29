#!/bin/bash

function build_images {
	local MAJOR_VERSION="${VERSION%%.*}"
	local VERSION_FPM="${VERSION}"-fpm
	local MAJOR_VERSION_FPM="${MAJOR_VERSION}"-fpm

	docker build --build-arg VERSION=${VERSION} --build-arg BUILDERVERSION=${BUILDERVERSION} --pull -t kilrah/nextcloud-ffmpeg:"${VERSION}" . -f Dockerfile-"${MAJOR_VERSION}"
	docker image tag kilrah/nextcloud-ffmpeg:"${VERSION}" kilrah/nextcloud-ffmpeg:"${MAJOR_VERSION}"
	
	docker build --build-arg VERSION=${VERSION_FPM} --build-arg BUILDERVERSION=${BUILDERVERSION} --pull -t kilrah/nextcloud-ffmpeg:"${VERSION_FPM}" . -f Dockerfile-"${MAJOR_VERSION}"
	docker image tag kilrah/nextcloud-ffmpeg:"${VERSION_FPM}" kilrah/nextcloud-ffmpeg:"${MAJOR_VERSION_FPM}"
}

function push_images {
	local MAJOR_VERSION="${VERSION%%.*}"
	local VERSION_FPM="${VERSION}"-fpm
	local MAJOR_VERSION_FPM="${MAJOR_VERSION}"-fpm

	docker push kilrah/nextcloud-ffmpeg:"${VERSION}"
	docker push kilrah/nextcloud-ffmpeg:"${MAJOR_VERSION}"
	docker push kilrah/nextcloud-ffmpeg:"${VERSION_FPM}"
	docker push kilrah/nextcloud-ffmpeg:"${MAJOR_VERSION_FPM}"
}

function set_default {
	docker image tag kilrah/nextcloud-ffmpeg:${VERSION} kilrah/nextcloud-ffmpeg
	docker push kilrah/nextcloud-ffmpeg

	VERSION="${VERSION}"-fpm

	docker image tag kilrah/nextcloud-ffmpeg:${VERSION} kilrah/nextcloud-ffmpeg:fpm
	docker push kilrah/nextcloud-ffmpeg:fpm
}

BUILDERVERSION=32.0.11

VERSION=32.0.11
build_images
push_images

BUILDERVERSION=33.0.5

VERSION=33.0.5
build_images
push_images

VERSION=34.0.0
build_images
push_images

VERSION=33.0.5
set_default
