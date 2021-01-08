FROM ubuntu:20.04

# Set the working directory to /app
WORKDIR /app

COPY . /app

# Install packages for C3 to run
RUN apt update && apt install -y wget software-properties-common apt-transport-https curl screen unzip smbclient cifs-utils samba winbind

#install winehq (v5.0) and winetricks
RUN dpkg --add-architecture i386 && apt update
RUN wget -O - https://dl.winehq.org/wine-builds/winehq.key | apt-key add -
RUN add-apt-repository 'deb https://dl.winehq.org/wine-builds/ubuntu/ focal main' && apt update && apt install --install-recommends -y winehq-stable wine-stable

# Install dotnet sdk
RUN wget -q https://packages.microsoft.com/config/ubuntu/20.04/packages-microsoft-prod.deb -O packages-microsoft-prod.deb && dpkg -i packages-microsoft-prod.deb
RUN add-apt-repository universe
RUN apt install -y apt-transport-https
RUN apt update
RUN apt install -y aspnetcore-runtime-5.0 aspnetcore-runtime-2.1 dotnet-sdk-5.0

# Run the web app, wait for it to come alive and then start a gateway using Wine
CMD ["/bin/bash", "run.sh"]
