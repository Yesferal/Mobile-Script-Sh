## ENVIRONMENT VAR
APK_NAME="app-debug.apk"
APK_FOLDER="app/build/outputs/apk/debug"


## ANDROID FUNCTIONS
android() {
  COMMAND=$1

  if [[ $COMMAND == "run" ]]
  then
    android_build_and_install
  else
    logger "No parameter found."
  fi
}

android_build_and_install() {
  logger "Build & Install"
  
  android_backup_old_apk

  android_build_apk

  if [[ $gradlew_return_code != "0" ]] 
  then
    logger "Failed. Exit code: $gradlew_return_code. Could not install the APK"
  else
    android_install_apk
  fi
}

android_backup_old_apk() {
  logger "Backing up old APK"
  
  if cd $APK_FOLDER;
  then
    android_stat_apk "$APK_NAME"
    logger "Renaming APK"
    mv "$APK_NAME" "old-version-$APK_NAME"
    comeBackToProjectRoot
  else
    logger "Failed. Could not find $APK_FOLDER"
  fi
}

android_build_apk() {
  logger "Building the new APK"
  ./gradlew assembleDebug;gradlew_return_code=$?
}

android_install_apk() {
  logger "Installing new APK"
 
  if cd $APK_FOLDER
  then
    android_stat_apk "$APK_NAME"
    adb install $APK_NAME
    comeBackToProjectRoot
  else
    logger "Failed. Could not find $APK_FOLDER"
  fi
}

android_stat_apk() {
  COMMAND=$1

  if [[ $COMMAND == "" ]]
  then
    stat -x "$APK_FOLDER/$APK_NAME"
  else
    stat -x $COMMAND
  fi
}

comeBackToProjectRoot() {
  cd "../../../../../"
}
