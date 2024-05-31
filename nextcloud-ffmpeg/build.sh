#!/bin/bash

function build_version {
	local MAJOR_VERSION="${VERSION%%.*}"

	sed -i '1s/.*/FROM nextcloud:'"${VERSION}"'/' Dockerfile
	docker build -t kilrah/nextcloud-ffmpeg:"${VERSION}" .
	docker build -t kilrah/nextcloud-ffmpeg:"${MAJOR_VERSION}" .
	docker push kilrah/nextcloud-ffmpeg:"${VERSION}"
	docker push kilrah/nextcloud-ffmpeg:"${MAJOR_VERSION}"

	VERSION="${VERSION}"-fpm
	MAJOR_VERSION="${MAJOR_VERSION}"-fpm

	sed -i '1s/.*/FROM nextcloud:'"${VERSION}"'/' Dockerfile
	docker build -t kilrah/nextcloud-ffmpeg:"${VERSION}" .
	docker build -t kilrah/nextcloud-ffmpeg:"${MAJOR_VERSION}" .
	docker push kilrah/nextcloud-ffmpeg:"${VERSION}"
	docker push kilrah/nextcloud-ffmpeg:"${MAJOR_VERSION}"
}

function build_default {
	sed -i '1s/.*/FROM nextcloud:'"${VERSION}"'/' Dockerfile
	docker build -t kilrah/nextcloud-ffmpeg .
	docker push kilrah/nextcloud-ffmpeg

	VERSION="${VERSION}"-fpm

	sed -i '1s/.*/FROM nextcloud:'"${VERSION}"'/' Dockerfile
	docker build -t kilrah/nextcloud-ffmpeg:fpm .
	docker push kilrah/nextcloud-ffmpeg:fpm
}

#VERSION=26.0.13
#build_version
#VERSION=27.1.9
#build_version
#VERSION=28.0.5
#build_version
VERSION=29.0.0
build_version

#VERSION=28.0.5
#build_default
