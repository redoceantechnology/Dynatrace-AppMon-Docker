# Licence!
Get a trial license from Dynatrace
host it with: ```sudo nc -l 80 < dtlicense.key```

Makefile does the rest. Just replace the license path.

```make -B sampleapp``` will deploy everything which includes AppMon server and collectors as well as easyTravel sample app.

AppMon launches on port 9911: https://localhost:9911/
easyTravel launches on port 32772: http://localhost:32772/ 
