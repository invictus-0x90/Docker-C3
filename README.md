# DockerC3

Dockerised version of the C3 project. 

Uses dotnet-runtime and wine on linux to run the C3 web app, downloads the first gateway and runs it with wine.
# Usage

* Download and compile/grab a compiled version of the C3 project.

* Store it in the root directory of this repo as "C3" (eg `unzip ~/C3-0.1.19861a4c.zip  && mv C3-0.1.19861a4c C3`)
* build the image


`docker build -t c3 .`

* Run `./build_server.sh <id>`

* Once completed:

1. A C3 server will be accessible on http://localhost:500$id

2. A folder will be created for that C3 instance in ./data/c3\_server\_$id

3. To view Gateway logs execute `tail -f ./data/c3\_server\_$id/gateway/gateway.log`

4. To upload customised relay executables for new relays simply move them to ./data/c3_server_$id/Bin

* If the Gateway errors for some reason, you can run `docker restart c3_server_$id`, the network will not be deleted.
