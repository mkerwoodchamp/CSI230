#! /bin/bash

for i in {1..20}
do
curl 192.168.3.30/helloWorld.html >nul 2>nul
done

echo "The ip was pinged ${i} time(s)"
