## ANDROID FUNCTIONS
android() {
  COMMAND=$1
  echo "COMMAND: $1"

  if [[ $COMMAND == "run" ]]
  then
    echo "Running -> android run";
    android_build_and_install;
  else
    echo "No parameter found.";
  fi
}


android_build_and_install() {
  echo "Backing up Old APK"
  android_backup_apk;

  echo "Building the new APK"
  ./gradlew assembleDebug;gradlew_return_code=$?

  if [[ $gradlew_return_code != "0" ]] 
  then
    echo "Build failed with exit code: $gradlew_return_code"
    echo "Could not install the APK"
  else
    echo "Installing new APK"
    android_install_apk;
  fi
}

android_backup_apk() {
  android_stat_apk;

  if cd $APK_FOLDER;
  then
    echo "Renaming APK";
    mv $APK_NAME "old-$APK_NAME"; 
    cd $RETURN_FROM_APK_FOLDER; 
  else
    echo "Could not find $APK_FOLDER";
  fi
}

android_stat_apk() {
  stat -x "$APK_FOLDER/app-debug.apk";
}

android_install_apk() {
  cd $APK_FOLDER; 
  adb install app-debug.apk; 
  cd $RETURN_FROM_APK_FOLDER;
}
