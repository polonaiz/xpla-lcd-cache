IMAGE_TAG=polonaiz/xpla-lcd-cache:20250122
IMAGE_TAG_LATEST=polonaiz/xpla-lcd-cache:latest
CONTAINER_NAME__LOCAL=xpla-lcd-cache--local

build-image:
	docker image build ./src --tag ${IMAGE_TAG}
	docker image build ./src --tag ${IMAGE_TAG_LATEST}
	docker image ls ${IMAGE_TAG}
	docker image ls ${IMAGE_TAG_LATEST}

create--xpla-lcd-cache--volume--local:
	docker volume create xpla-lcd-cache--volume--local

run--xpla-lcd-cache--container--local: stop--xpla-lcd-cache--container--local
	docker run --rm --detach \
		--volume xpla-lcd-cache--volume--local:/data/lib/xpla-lcd-cache \
		--publish 10080:80 \
		--name ${CONTAINER_NAME__LOCAL} \
		${IMAGE_TAG_LATEST}

stop--xpla-lcd-cache--container--local:
	docker rm -f ${CONTAINER_NAME__LOCAL}

shell--xpla-lcd-cache--container--local:
	docker exec -it ${CONTAINER_NAME__LOCAL} bash

tail-nginx-access-log:
	docker logs xpla-lcd-cache--local -f

test-origin:
	curl -i https://dimension-lcd.xpla.dev/ethermint/evm/v1/base_fee

test-proxy-work:
	curl -i http://localhost:10080/ethermint/evm/v1/base_fee
