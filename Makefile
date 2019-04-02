.PHONY: help build run destroy dynatracedocker
.PHONY: license

EASY_TRAVEL_APP ?= dt_easy_docker/docker-compose-withDtAppMon.yml
DT_PREFIX ?= dynatrace
EASY_TRAVEL_PORT ?= 32772
APPMON_PORT ?= 9911
DK_STAT ?= docker ps; docker ps -a; docker network ls

license:
	./license.sh

build:
	docker-compose -f docker-compose.yml --build
	docker-compose -f $(EASY_TRAVEL_APP) --build

appmon: license
	docker-compose -f docker-compose.yml up -d

run: appmon
	docker-compose -f $(EASY_TRAVEL_APP) up

stop:
	docker-compose -f $(EASY_TRAVEL_APP) down
	docker-compose down
	$(DK_STAT)

clean: stop
	kill -9  `$(LICENSE_PID)`
	docker rm `docker ps -a | grep $(DT_PREFIX) | awk '{print$1}'`
	docker-compose down -v --rmi all --remove-orphans
	docker system prune
	$(DK_STAT)
