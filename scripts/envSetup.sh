###################################
# Set install versions
###################################
export INSTALL_JDK_VERSION=17
export INSTALL_ANDROID_SDK_VERSION=34.0.0
export INSTALL_ANDROID_TOOLS_VERSION=11076708 # from https://developer.android.com/studio#command-line-tools-only
export INSTALL_NODE_VERSION=20

###################################
# Set environment variables
###################################
export WORKSPACE=/workspace

export JAVA_HOME=/usr/lib/jvm/java-${INSTALL_JDK_VERSION}-openjdk-amd64
export ANDROID_HOME="${WORKSPACE}/android-sdk" >> /etc/profile
export ANDROID_SDK_MAJOR_VERSION=$(echo $INSTALL_ANDROID_SDK_VERSION | sed 's/\..*//')
export ANDROID_SDK_ROOT="${ANDROID_HOME}"
export ANDROID_TOOLS="${ANDROID_HOME}/cmdline-tools/bin"
export CORDOVA_PATH="${WORKSPACE}/node_modules/cordova/bin"
export PATH="${PATH}:${ANDROID_TOOLS}:${CORDOVA_PATH}"

export DEBIAN_FRONTEND=noninteractive

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
        wget https://dl.google.com/android/repository/commandlinetools-linux-11076708_latest.zip
        unzip commandlinetools-linux-11076708_latest.zip
        cd "${WORKSPACE}"
fi

# accept all SDK licenses, otherwise later processes will hang waiting for input
yes | sdkmanager --sdk_root=${ANDROID_HOME} --licenses

# install the supporting packages
yes | sdkmanager --sdk_root=${ANDROID_HOME} "platform-tools" "build-tools;${INSTALL_ANDROID_SDK_VERSION}"  # required so cordova can build app
yes | sdkmanager --sdk_root=${ANDROID_HOME} "platforms;android-${ANDROID_SDK_MAJOR_VERSION}"

###################################
# install Node.js
###################################
apt-get install -y nodejs npm
node -v && npm -v


