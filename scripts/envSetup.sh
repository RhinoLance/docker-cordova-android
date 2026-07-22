# if an varsAreSet arg is not passed, then set the vars
if [ -z "$varsAreSet" ]
then
        source ./build.env
fi

# echo all of the environment variables
echo "INSTALL_JDK_VERSION: ${INSTALL_JDK_VERSION}"
echo "INSTALL_ANDROID_SDK_VERSION: ${INSTALL_ANDROID_SDK_VERSION}"
echo "INSTALL_ANDROID_TOOLS_VERSION: ${INSTALL_ANDROID_TOOLS_VERSION}"
echo "INSTALL_NODE_VERSION: ${INSTALL_NODE_VERSION}"
echo "WORKSPACE: ${WORKSPACE}"
echo "JAVA_HOME: ${JAVA_HOME}"
echo "ANDROID_HOME: ${ANDROID_HOME}"
echo "ANDROID_SDK_ROOT: ${ANDROID_SDK_ROOT}"
echo "ANDROID_TOOLS: ${ANDROID_TOOLS}"
echo "CORDOVA_PATH: ${CORDOVA_PATH}"
echo "PATH: ${PATH}"

export ANDROID_SDK_MAJOR_VERSION=$(echo $INSTALL_ANDROID_SDK_VERSION | sed 's/\..*//')
export DEBIAN_FRONTEND=noninteractive #stop apt-get from asking questions

mkdir -p $WORKSPACE

apt-get update

###################################
# install JDK
###################################
# echo "https://dl-cdn.alpinelinux.org/alpine/edge/testing" >> /etc/apk/repositories

apt-get install -y openjdk-${INSTALL_JDK_VERSION}-jdk-headless
java -version

###################################
# install Android SDK
###################################
apt-get install -y wget curl maven gradle

# install Android SDK tools if necessary
if [ ! -d "${ANDROID_HOME}" ]
then
        mkdir "${ANDROID_HOME}"
        cd "${ANDROID_HOME}"
        wget https://dl.google.com/android/repository/commandlinetools-linux-${INSTALL_ANDROID_TOOLS_VERSION}_latest.zip
        unzip commandlinetools-linux-${INSTALL_ANDROID_TOOLS_VERSION}_latest.zip
        cd "${WORKSPACE}"
fi

# install the Android CLI
# curl -fsSL https://dl.google.com/android/cli/latest/linux_x86_64/install_root.sh | bash
# android update

# accept all SDK licenses, otherwise later processes will hang waiting for input
yes | $ANDROID_TOOLS/sdkmanager --sdk_root=${ANDROID_HOME} --licenses

# install the supporting packages
yes | $ANDROID_TOOLS/sdkmanager --sdk_root=${ANDROID_HOME} "platform-tools" "build-tools;${INSTALL_ANDROID_SDK_VERSION}"  # required so cordova can build app
yes | $ANDROID_TOOLS/sdkmanager --sdk_root=${ANDROID_HOME} "platforms;android-${ANDROID_SDK_MAJOR_VERSION}"

###################################
# install Node.js
###################################
apt-get install -y nodejs npm
node -v && npm -v

###################################
# install additional tools
###################################
apt-get install -y vim
