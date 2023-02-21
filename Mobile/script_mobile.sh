## INCLUDES
source ~/Development/Script/Mobile-Script-zsh/Mobile/zsh_android.sh


## FONT STYLES
BOLD=$(tput bold)
NORMAL=$(tput sgr0)


## ENVIRONMENT VAR
PLATFORM_ANDROID_SHORT="-a"
PLATFORM_ANDROID="--android"


## MOBILE FUNCTIONS
mobile() {
  PLATFORM=$1;
  COMMAND=$2;

  if [[ $PLATFORM == $PLATFORM_ANDROID_SHORT || $PLATFORM == $PLATFORM_ANDROID ]]
  then
    logger "Android was selected ($PLATFORM)"
    android $COMMAND
  else
    logger "No platform found ($PLATFORM)"
  fi
}

logger() {
  MESSAGE=$1
  echo "  "
  echo "${BOLD}>> MOBILE LOGGER: $MESSAGE${NORMAL}"
  echo "  "
}
