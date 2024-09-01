# Docker file to run Hawakening game server
FROM ubuntu:22.04

# Install dependencies
RUN apt-get update && apt-get install -y wget curl p7zip-full wine software-properties-common gnupg2 xvfb cabextract && apt-get clean

# Add 32-bit architecture & 32-bit wine
RUN dpkg --add-architecture i386 && apt-get update && apt-get install -y wine32 && apt-get clean

# Install Winetricks
RUN wget https://raw.githubusercontent.com/Winetricks/winetricks/master/src/winetricks
RUN chmod +x winetricks
RUN cp winetricks /usr/local/bin

# Setup a Wine prefix
ENV WINEDEBUG=fixme-all
ENV WINEPREFIX=/root/.wine 
ENV WINEARCH=win32

# Install vcrun2015
RUN set -xe && \
	xvfb-run wine wineboot -u && \
	xvfb-run wineserver -w && \
	xvfb-run winetricks -q --force vcrun2015

