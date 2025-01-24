IMAGE_TAG=polonaiz/xpla-lcd-cache:20250122
IMAGE_TAG_LATEST=polonaiz/xpla-lcd-cache:latest
CONTAINER__LOCAL=xpla-lcd-cache--local
ARCHIVE_CACHE__VOLUME__LOCAL=xpla-lcd-cache--archive-cache--volume--local
ARCHIVE_CACHE__MOUNT_POINT=/data/lib/nginx/archive-cache

build-image:
	docker image build ./src --tag ${IMAGE_TAG}
	docker image build ./src --tag ${IMAGE_TAG_LATEST}
	docker image ls ${IMAGE_TAG}
	docker image ls ${IMAGE_TAG_LATEST}

create--archive-cache--volume--local:
	docker volume create ${ARCHIVE_CACHE__VOLUME__LOCAL}

run--xpla-lcd-cache--container--local: stop--xpla-lcd-cache--container--local
	docker run --rm \
		--volume ${ARCHIVE_CACHE__VOLUME__LOCAL}:${ARCHIVE_CACHE__MOUNT_POINT} \
		--publish 10080:80 \
		--name ${CONTAINER__LOCAL} \
		${IMAGE_TAG_LATEST}

stop--xpla-lcd-cache--container--local:
	docker rm -f ${CONTAINER__LOCAL}

shell--xpla-lcd-cache--container--local:
	docker exec -it ${CONTAINER__LOCAL} bash

# while true; do make tail-nginx-access-log; echo; sleep 1; done
tail-nginx-access-log:
	docker logs ${CONTAINER__LOCAL} -f


purge-cache:
	docker exec -it ${CONTAINER__LOCAL} bash -c 'rm -rf ${ARCHIVE_CACHE__MOUNT_POINT}/*'

test-normal-query-origin:
	curl -i https://dimension-lcd.xpla.dev/cosmos/bank/v1beta1/balances/xpla10ksn9528f82uwnmz3sgr4n42l0nucmzntjrg00

test-normal-query:
	curl -i http://localhost:10080/cosmos/bank/v1beta1/balances/xpla10ksn9528f82uwnmz3sgr4n42l0nucmzntjrg00

# 2025-01-18 14:59:53.799284 UTC
test-historic-query-origin:
	time curl -i https://dimension-lcd.xpla.dev/cosmos/bank/v1beta1/balances/xpla10ksn9528f82uwnmz3sgr4n42l0nucmzntjrg00 \
		-H "x-cosmos-block-height: 12572335"

# 2025-01-18 14:59:53.799284 UTC
test-historic-query:
	time curl -i http://localhost:10080/cosmos/bank/v1beta1/balances/xpla10ksn9528f82uwnmz3sgr4n42l0nucmzntjrg00 \
		-H "x-cosmos-block-height: 12572335"

# 2025-01-15 14:59:58.392498 UTC
test-historic-query-other-height:
	time curl -i http://localhost:10080//cosmos/bank/v1beta1/balances/xpla10ksn9528f82uwnmz3sgr4n42l0nucmzntjrg00 \
		-H "x-cosmos-block-height: 12529817"
