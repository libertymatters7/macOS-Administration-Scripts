#!/bin/bash
#
# Copyright (c) 2026 libertymatters7 (https://github.com/libertymatters7)
# SPDX-License-Identifier: MIT
#
# configure-mau-autoupdate.sh
#
# Sets Microsoft AutoUpdate to automatically download and install
# Microsoft 365 updates for the currently logged-in user.
# Intended to run from a Jamf policy (as root).

user="$(stat -f '%Su' /dev/console)"

if [[ -z "$user" || "$user" == "root" || "$user" == "loginwindow" ]]; then
    echo "No user logged in. Exiting."
    exit 0
fi

uid="$(id -u "$user")"

launchctl asuser "$uid" sudo -u "$user" \
    defaults write com.microsoft.autoupdate2 HowToCheck -string "AutomaticDownload"

echo "Set HowToCheck to AutomaticDownload for $user."
