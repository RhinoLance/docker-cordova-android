# rhinolance/cordova-android
This docker image is intented as a CI container for building Cordova Android projects.

## Versioning
These images are versioned with the major and minor versions to correspond with [cordova-android](https://github.com/apache/cordova-android) releases.  The patch version is independent
i.e. 
- Docker cordova-android:**13.0**.8 => cordova-android@**13.0**.0
- Docker cordova-android:**13.1**.0 => cordova-android@**13.1**.7

## Updates
I welcome pull requests where core changes are required.  Please ensure that 
scripts/cordovaTest.sh runs cleanly before submitting anything.

## Version history
### 13.0.*

- JDK: 17
- Android SDK: 34
- Android command line tools: 12.0
- NodeJs: 18.19.1
- npm: 9.2.0

# F.A.Q.
- **Can you pre-install Cordova as part of the image?**  No.  It is updated too
often to be practical, and is quick enough to install as part of your build 
process.  As most CI pipelines will cache your node_modules folder, just install 
it locally (not -g), and call it with `ngx cordova ...`.