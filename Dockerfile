FROM debian


EXPOSE 80
EXPOSE 9423

RUN apt-get update && \
    apt-get install -y wget && \
    apt-get install -y git && \
    cd home && \
    wget https://packages.microsoft.com/config/debian/10/packages-microsoft-prod.deb -O packages-microsoft-prod.deb && \
    dpkg -i packages-microsoft-prod.deb && \
    apt-get install -y apt-transport-https && \
    apt-get update && \
    apt-get install -y dotnet-sdk-5.0 &&\
    git clone https://github.com/terranigma-solutions/MLAPI.ServerList.git
    
# build ServerList and copy config file        
RUN cd home/MLAPI.ServerList/MLAPI.ServerList.Server && \
    dotnet build -r linux-x64 && \
    cp config.json bin/Debug/netcoreapp5.0/config.json
    
CMD cd home/MLAPI.ServerList/MLAPI.ServerList.Server && \
    dotnet run . 