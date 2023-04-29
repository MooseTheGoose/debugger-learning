#!/bin/sh

if [ "$1" = "" ] ; then
    echo "Usage: $0 pkgname"
    echo "pkgname: Package Specifier (com/mycompany/myapp)"
    echo "Environment Variables"
    echo "\tTCPFWDPRT: TCP Forwarding Port (Default: 1234)"
    echo "\tSRCPATH: Source Path (Default: .)"
    exit 1
fi
TCPFWDPRT="."
PKGNAME=`echo $1 | tr '/\\' '..'`
if [ "$PKGNAME" = "" ] ; then
    echo "PKGNAME is required to be defined"
fi

adb shell am set-debug-app -w "$PKGNAME"
adb shell monkey -p "$PKGNAME" -c android.intent.category.LAUNCHER 1
PID=`adb shell ps -A | grep "$PKGNAME" | awk '{print $2}'`
if [ "$PID" = "" ] ; then
    echo "Failed to find the PID for $PKGNAME!"
    exit 2
fi
TCPFWDPRT=4444
adb forward tcp:$TCPFWDPRT jdwp:$PID
jdb -attach localhost:$TCPFWDPRT
