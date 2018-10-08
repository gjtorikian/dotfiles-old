#!/usr/bin/env bash

# Quinn Comendant <quinn@strangecode.com>
# https://gist.github.com/quinncomendant/3be731567e529415d5ee
# Since 25 Jan 2015
# Version 1.1

CMD=$1;

if [[ `id -u` = 0 ]]; then
    echo "You mustn't be root when executing this script";
    exit;
fi

function umbrella-usage {
    echo "Usage: $(basename $0) COMMAND
  COMMANDS:
    stop    Run sudo launchctl unload /Library/LaunchDaemons/com.opendns.osx.RoamingClientConfigUpdater.plist
    start   Run sudo launchctl load /Library/LaunchDaemons/com.opendns.osx.RoamingClientConfigUpdater.plist
    restart Stop umbrella, then start again.
    status  Is umbrella running?
";
}
function umbrella-start () {
    sudo launchctl load /Library/LaunchDaemons/com.opendns.osx.RoamingClientConfigUpdater.plist;
    launchctl load /Library/LaunchAgents/com.opendns.osx.RoamingClientMenubar.plist;
    sleep 1;
    umbrella-status;
}
function umbrella-stop () {
    sudo launchctl remove com.opendns.osx.RoamingClientConfigUpdater;
    launchctl remove com.opendns.osx.RoamingClientMenubar;
    sudo killall OpenDNSDiagnostic &>/dev/null;
    sleep 1;
    umbrella-status;
}
function umbrella-status () {
    ps auwwx | egrep "dnscrypt|RoamingClientMenubar|dns-updater" | grep -vq egrep;
    if [[ 0 == $? ]]; then
        echo "Umbrella is running. Checking debug.opendns.com DNS…";
        dig debug.opendns.com txt +time=2 +tries=1 +short | sed 's/^"/  "/' | grep '"';
        [[ 1 == $? ]] && echo "Umbrella is not functioning correctly!"
    else
        echo "Umbrella is stopped";
        grep -q 127.0.0.1 /etc/resolv.conf && echo "Without umbrella running, you'll need to remove 127.0.0.1 from your DNS servers before you can resolve domains.";
    fi
    echo "Currently using name servers: $(cat /etc/resolv.conf | grep nameserver | sed 's/nameserver //' | tr '\n' ' ')"
}
