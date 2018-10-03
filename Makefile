.PHONY: help build run destroy dynatracedocker
.PHONY: license

EASY_TRAVEL_APP ?= easyTravel-Docker/docker-compose-withDtAppMon.yml
EASY_TRAVEL_PORT ?= 32772
APPMON_PORT ?= 9911
DK_STAT ?= docker ps; docker ps -a; docker network ls
LICENSE_PID ?= lsof -iTCP -sTCP:LISTEN -n -P | grep 1337 | grep LISTEN | awk '{print$2}'

license:
	nohup nc -l 1337 < trial-license/appmon_license_201808071015.lic &
	lsof -iTCP -sTCP:LISTEN -n -P | grep 1337 | grep LISTEN

run_appmon: license
	docker-compose -f docker-compose.yml up -d

sampleapp: run_appmon
		docker-compose -f $(EASY_TRAVEL_APP) up

stop:
		docker-compose -f $(EASY_TRAVEL_APP) down
		docker-compose down
		$(DK_STAT)

clean: stop
		kill -9  `$(LICENSE_PID)`
		docker-compose down -v --rmi all --remove-orphans
		docker system prune
		$(DK_STAT)
