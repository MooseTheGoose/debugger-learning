# Android Debugging 

Debugging is usually abstracted by an IDE like Android Studio.
This works for most people but it's annoying for people who
either want to use gdb from the command line or another
frontend of gdb that they prefer.

Android does provide ndk-gdb.py, but I've found this script
a bit finnicky and hard to work with for some reason.
I recommend reading the script then adapting it to your
use case rather than just using it blindly.

# Helpful ADB commands

List packages
```sh
pm list packages
```

Set Activity Manager's debug app
```sh
adb shell am set-debug-app -w <package>
```

Start application
```sh
monkey -p <package> -c android.intent.category.LAUNCHER 1
```

Get an application's PID
```sh
ps -A | grep '<package>' | awk '{print $2}'
```

Get PID of android app being debugged
```sh
adb jdwp
```

