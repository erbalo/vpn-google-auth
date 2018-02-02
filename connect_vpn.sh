#!/bin/bash
source ./echo_colors.sh

##### GLOBAL VARIABLES #####
CN_VPN_FILE="client.ovpn"
CN_VPN_PATH="$(pwd)/"
CN_USER="$USER"
CN_PWD="default"
CN_PROP=vpn.properties
GCODE=-1

function resetColor() {
    echo -en ${colors[Color_Off]}
}

function pause() {
    read -p "$*"
}

function printUser() {
    echo -e ">>>>> Login as user[${colors[BIGreen]}$CN_USER]"
    resetColor
}

function promptTextGcode() {
   echo -e "${colors[Color_Off]}Please enter your ${colors[BCyan]}Google Authenticator ${colors[Color_Off]}code: "
}

function connect(){
    BASE_DIR=$(pwd)
    #cd $CN_VPN_DIR
    read -e -n 6 -p "$(promptTextGcode)" GCODE
    printUser
    FULL_PATH=$CN_VPN_PATH$CN_VPN_FILE
    expect ./vpn_fill.exp $CN_USER $CN_PWD $GCODE $FULL_PATH
}

function getProperty() {
    PROP_KEY=$1
    PROP_VALUE=`cat $CN_PROP | grep "$PROP_KEY" | cut -d'=' -f2`
    echo $PROP_VALUE
}

function updateProperty() {
    replaceString=$1
    sed -i "s/\(example\.java\.property=\).*\$/\1${replaceString}/" $CN_PROP
}

function validateRoot() {
    # Make sure only root can run our script
    if [[ $EUID -ne 0 ]]; then
       echo -e "${colors[BIRed]}>>>> This script must be run as sudo" 1>&2
       exit 1
    fi
}

function readProperties() {
    echo -e "${colors[IYellow]}# Reading properties.... Just wait..."
    resetColor
    CN_VPN_PATH=$(getProperty "vpn.path")
    CN_VPN_FILE=$(getProperty "vpn.fileName")
    CN_USER=$(getProperty "vpn.user")
    CN_PWD=$(getProperty "vpn.password")
}

##### INIT #####
validateRoot
readProperties
connect
