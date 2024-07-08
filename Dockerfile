FROM ubuntu:latest

ENV INSTALL_JDK_VERSION=17 \
    INSTALL_ANDROID_SDK_VERSION=34.0.0 \
    INSTALL_ANDROID_TOOLS_VERSION=11076708 \
    INSTALL_NODE_VERSION=20 \
    WORKSPACE=/workspace \
	JAVA_HOME=/usr/lib/jvm/java-${INSTALL_JDK_VERSION}-openjdk-amd64 \
    ANDROID_HOME=${WORKSPACE}/android-sdk \
    ANDROID_SDK_ROOT=${ANDROID_HOME} \
    ANDROID_TOOLS=${ANDROID_HOME}/cmdline-tools/bin \
    CORDOVA_PATH=${WORKSPACE}/node_modules/cordova/bin \
	PATH="${PATH}:${ANDROID_TOOLS}:${CORDOVA_PATH}"



# All setup takes place in the envSetup.sh script in order to only add a single 
# layer to the image, whilst maintaining readability.
RUN apt-get update && apt-get install -y wget && \
	wget "https://raw.githubusercontent.com/RhinoLance/docker-cordova-android/main/scripts/envSetup.sh" && \
	chmod +x ./envSetup.sh && \
	. ./envSetup.sh varsAreSet