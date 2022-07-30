FROM ubuntu
ARG NGROK_TOKEN
ARG REGION=jp
ENV DEBIAN_FRONTEND=noninteractive
RUN apt update && apt install -y \
    ssh wget unzip vim curl 
RUN wget -q https://bin.equinox.io/c/4VmDzA7iaHb/ngrok-stable-linux-amd64.zip -O /ngrok-stable-linux-amd64.zip\
    && cd / && unzip ngrok-stable-linux-amd64.zip \
    && chmod +x ngrok
RUN mkdir /mc
    wget -q https://minecraft.azureedge.net/bin-linux/bedrock-server-1.19.11.01.zip -O /mc/bedrock-server-1.19.11.01.zip\
    && cd /mc && unzip bedrock-server-1.19.11.01.zip \
    && echo "LD_LIBRARY_PATH=. ./bedrock_server" >> /mc.sh \
    && echo "sleep 5" >> /mc.sh \
    && echo "/ngrok tcp --authtoken ${NGROK_TOKEN} --region ${REGION} 19132 &" >>/mc.sh \
    && chmod 755 /mc.sh
EXPOSE 80 443 19132 19133
CMD /mc.sh