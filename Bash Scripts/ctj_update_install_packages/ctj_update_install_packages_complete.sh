#!/bin/bash
# ******************************************************************************************************
# ******************************************************************************************************
# ******************************************************************************************************
#   ____        _                   _____            _           _                                    _ 
#  / ___|_   _ | |__    ___  _ __  |_   _|___   ___ | |__       | |  ___   _   _  _ __  _ __    __ _ | |
# | |   | | | || '_ \  / _ \| '__|   | | / _ \ / __|| '_ \   _  | | / _ \ | | | || '__|| '_ \  / _` || |
# | |___| |_| || |_) ||  __/| |      | ||  __/| (__ | | | | | |_| || (_) || |_| || |   | | | || (_| || |
#  \____|\__, ||_.__/  \___||_|      |_| \___| \___||_| |_|  \___/  \___/  \__,_||_|   |_| |_| \__,_||_|
#        |___/                                                                                          
#                                                                       
# Script Name: ctj_update_install_packages.sh
#
# Script Version: 1.0
#
# Date: 2023/03/04
#
# Author: William D. Friend Jr. (Bill)
#
# License: MIT
#
# Description:
# This script can be used to automate multiple package installations and updating installed packages.
#
# Usage:
# 1. Download the "ctj_update_install_packages.sh" script and the "packages.txt" text file.
# 2. Place both files in the same folder on your Linux system.
# 3. Open the "packages.txt" file with your preferred text editor.
# 4. Add the names of the packages you want to install or upgrade, with each package name on a separate line.
# 5. Save the changes to the "packages.txt" file.
# 6. Open a terminal window and navigate to the folder containing the script and text file.
# 7. Run the script using the command "sudo bash ctj_update_install_packages.sh" in the terminal.
# 8. Follow the on-screen prompts to choose between a full upgrade, regular upgrade, or to skip the upgrade entirely.
# 9. Wait for the script to complete the package installation or upgrade process.
# 10. Review the lists of successful and failed packages and take any necessary actions.
#
# Version History:
# V1.0 - Initial Release
#
# ******************************************************************************************************
# ******************************************************************************************************
# ******************************************************************************************************


# Read the list of packages from the external file
PACKAGES=($(<packages.txt))

# Define empty arrays to store successful and failed package names
SUCCESS_PACKAGES=() FAILED_PACKAGES=()

# Run apt-get update and pause script for 5 seconds
echo "Updating package lists"; sudo apt-get update; sleep 5

# Prompt the user to choose between regular or full package upgrade
while true; do
    clear; echo -e "\nWould you like to perform a full upgrade or a regular upgrade?\n\n1. Full upgrade (apt-get full-upgrade)\n2. Regular upgrade (apt-get upgrade)\n3. Do not upgrade\n"
    read -p "Enter your choice [1-3]: " choice

    case $choice in
        1) echo -e "\nPerforming full upgrade...\n"; sudo apt-get full-upgrade -y; break;;
        2) echo -e "\nPerforming regular upgrade...\n"; sudo apt-get upgrade -y; break;;
        3) echo -e "\nSkipping existing package upgrades...\n"; break;;
        *) echo -e "\nInvalid choice.\n"; sleep 1;;
    esac
done

# Pause script until user interaction
read -n 1 -s -r -p $'\nPress any key to continue.\n'

# Clear Screen
clear

# Display a list of all packages to be installed
echo "Preparing to install the following packages"
for PACKAGE in "${PACKAGES[@]}"; do
    echo " - $PACKAGE"
done

# Pause script for 3 seconds
sleep 3

# Loop through each package and install it
for PACKAGE in "${PACKAGES[@]}"; do
    echo -e "\n\nInstalling $PACKAGE...\n"; sudo apt-get install -y $PACKAGE
    # Check if there was an error during installation
    if [ $? -ne 0 ]; then
        echo -e "\nError installing $PACKAGE, removing it from the list ...\n"
        # Add package to failed packages array and remove it from packages list
        FAILED_PACKAGES+=("$PACKAGE"); PACKAGES=("${PACKAGES[@]/$PACKAGE}")
    else
        # Add package to successful packages array
        SUCCESS_PACKAGES+=("$PACKAGE")
    fi
done

# Remove unnecessary packages
echo -e "\nPreparing to remove unnecessary packages ...\n"; sudo apt auto-remove -y

# Pause script until user interaction
read -n 1 -s -r -p $'\nPress any key to continue.\n'

# Clear Screen
clear

# Informing the user that the installation process is complete
echo -e "\nThe installation process is complete!\n"

# Display list of successfully installed packages
if [ ${#SUCCESS_PACKAGES[@]} -ne 0 ]; then
    echo -e "\nThe following packages were successfully installed or upgraded:\n"
    printf " - %s\n" "${SUCCESS_PACKAGES[@]}"; echo ""
fi

# Display list of failed packages
if [ ${#FAILED_PACKAGES[@]} -ne 0 ]; then
    echo -e "\nThe following packages were not installed or upgraded:\nYou may want to verify that the package name was entered correctly.\n"
    printf " - %s\n" "${FAILED_PACKAGES[@]}"; echo ""
fi

# Exit the script with success status
exit 0
