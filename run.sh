#!/bin/bash

echo "[+] Publishing the WebController"
cd /app/C3/Src/WebController/Backend && dotnet publish -c Release -v d -r linux-x64

echo "[+] Running the web app"
screen -dmS c3-web /bin/bash -c "cd /app/C3/Src/WebController/Backend && dotnet ../../../Bin/WebController/Release/netcoreapp2.1/linux-x64/C3WebController.dll --urls \"http://0.0.0.0:52935\""

echo "[+] Waiting for Web to come up"

while :
do
	if `curl -s localhost:52935/api/gateway/exe/x64\?name\=gateway --output /app/gateway/gateway.zip >/dev/null` ; then
		echo "[+] Web App is online, downloaded gateway executable"
    		break
	else
	    echo "[x] Web app not yet running, sleeping for 10s before retrying"
	fi
	sleep 10
done

cd /app/gateway

#only download the gateway if it doesn't exist
if [ ! -e "GatewayX64_gateway.exe" ]; then
	unzip gateway.zip
	chmod +xr GatewayX64_gateway.exe
	chmod +r GatewayConfiguration.json
fi

screen -L -Logfile /app/gateway/gateway.log -dmS gateway wine64 GatewayX64_gateway.exe

#run forever
while true; do sleep 1000; done
