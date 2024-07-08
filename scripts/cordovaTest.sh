###################################
# init project
###################################
npm i -g cordova
cordova create myApp com.myCompany.myApp myApp --no-telemetry
cd myApp

cordova platform add android
cordova requirements android
cordova build android --verbose