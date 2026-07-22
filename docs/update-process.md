# Update process

## Set the environment variables.

Edit `/scripts/build.env`, and update the following package versions:

- **INSTALL_JDK_VERSION**: The only needs to be updated if there are build 
issues.  If so, review version compatibility for OpenJDK.

- **INSTALL_ANDROID_SDK_VERSION**: Version lifecycle may be reviewed at 
https://apilevels.com/

- **INSTALL_ANDROID_TOOLS_VERSION**: Set the latest version number from 
https://developer.android.com/studio#command-line-tools-only

- **INSTALL_NODE**: Set the the current stable version of node, as per 
https://nodejs.org/en/about/previous-releases


## Update Version History
Update README.md file's **Version history** section.

# Build the new image

Run `scripts/docker-build.ps1`

This will build a docker image called cordova-android:dev

# Testing

See [testing.md](testing.md)

# Publishing

The following powershell snippet will tag and publish.  Update cordova-android version (`$caVersion`) as required.
``` pwsh
#set version (update as required)
$caVersion="15.0.0"

# authenticate with Docker directory
docker login

# Re-tag for prod
docker tag cordova-android:dev rhinolance/cordova-android:latest
docker tag cordova-android:dev rhinolance/cordova-android:$caVersion

# push
docker push rhinolance/cordova-android:latest
docker push rhinolance/cordova-android:$caVersion
```
