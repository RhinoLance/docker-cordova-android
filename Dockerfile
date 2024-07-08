FROM ubuntu:latest

ENV INSTALL_JDK_VERSION=17 \
    INSTALL_ANDROID_SDK_VERSION=34.0.0 \
    INSTALL_ANDROID_TOOLS_VERSION=11076708 \
    INSTALL_NODE_VERSION=20 \
    WORKSPACE=/workspace \
	JAVA_HOME=/usr/lib/jvm/java-17-openjdk-amd64 \
    ANDROID_HOME=/workspace/android-sdk \
    ANDROID_SDK_ROOT=/workspace/android-sdk \
    ANDROID_TOOLS=/workspace/android-sdk/cmdline-tools/bin \
    CORDOVA_PATH=/workspace/node_modules/cordova/bin

COPY scripts/envSetup.sh /

# All setup takes place in the envSetup.sh script in order to only add a single 
# layer to the image, whilst maintaining readability.
RUN chmod +x ./envSetup.sh && \
	. ./envSetup.sh varsAreSet