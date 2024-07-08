FROM ubuntu:latest

# All setup takes place in the envSetup.sh script in order to only add a single 
# layer to the image, whilst maintaining readability.
RUN apt-get update && apt-get install -y wget && \
	wget "https://raw.githubusercontent.com/RhinoLance/docker-cordova-android/main/scripts/envSetup.sh" && \
	chmod +x ./envSetup.sh && \
	. ./envSetup.sh