#!/bin/bash

# Set variables
# -----------------------------------
GUNBOT_GITHUB_FOLDER_NAME="v3.3.4"
GUNBOT_GITHUB_FILE_NAME="Gunbot_v3.3.4_allOs"
TIMESTAMP="$(date +"%s")"
LATEST_PATCH="v3.3.4 allOs"

# Set functions
# -----------------------------------
logMessage () {
  echo " $1"
  echo " ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~"
}


echo ""
echo " ============================================================"
echo "                    GUNBOT 3.3.4 UPDATE started"
echo ""
echo "                        Patch ${LATEST_PATCH}"
echo ""
echo " ============================================================"
echo ""

logMessage "(1/4) Stop all bots"
#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
pm2 stop all > /dev/null 2>&1


logMessage "(2/4) Backup current version"
#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
cp /opt/gunbot/ /opt/gunbot-backup-${TIMESTAMP}/ -r > /dev/null 2>&1


logMessage "(3/4) Update tools"
#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
npm install -g generator-gunbot > /dev/null 2>&1


logMessage "(4/4) Update GUNBOT"
#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
# Install latest release as patch
wget -q https://github.com/GuntharDeNiro/BTCT/releases/download/${GUNBOT_GITHUB_FOLDER_NAME}/${GUNBOT_GITHUB_FILE_NAME}.zip -P /opt/
unzip -o -qq /opt/${GUNBOT_GITHUB_FILE_NAME}.zip -d /opt/unzip-tmp

# Remove all executables.
rm -f /opt/gunbot/gunthy-*

# Copy only the executables.
cp /opt/unzip-tmp/gunthy-* /opt/gunbot

# Cleanup
rm /opt/${GUNBOT_GITHUB_FILE_NAME}.zip
rm -Rf /opt/unzip-tmp

# Set rights
chmod +x /opt/gunbot/gunthy-*


echo ""
echo " ============================================================"
echo "                   GUNBOT UPDATE complete!"
echo ""
echo "          Please run this command to restart the GUNBOT:"
echo "                           gcd"
echo "                           ginit"
echo ""
echo "                 (allow overwrite of ALLPAIRS)"
echo ""
echo " ============================================================"
echo ""
