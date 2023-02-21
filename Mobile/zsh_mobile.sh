## INCLUDES
source ~/Development/Script/Mobile-Script-zsh/Mobile/zsh_android.sh


## ENVIRONMENT VAR
APK_NAME="app-debug.apk";
APK_FOLDER="app/build/outputs/apk/debug";
RETURN_FROM_APK_FOLDER="../../../../../";


## MOBILE FUNCTIONS
mobile() {
  PLATFORM=$1;
  echo "PLATFORM: $1"
  COMMAND=$2;
  echo "COMMAND: $2"

  if [[ $PLATFORM == "a" ]]
  then
    echo "Platform selected Android";
    android $COMMAND;
  else
    echo "No platform found.";
  fi
}
