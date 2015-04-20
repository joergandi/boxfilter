#APP_STL := stlport_static  #NDK BUG, replace by static module in android.mk!
NDK_TOOLCHAIN_VERSION := 4.6
#4.6 for cuda65 target k1
#4.9 only in cuda7
APP_ABI := armeabi-v7a
APP_PLATFORM := android-21
APP_CPPFLAGS += -fexceptions
APP_CPPFLAGS += -frtti 
APP_CPPFLAGS += -DANDROID


#compilation and build steps:
## in /cuda:  make all
## in /jni: ndk-build (NDK_DEBUG=1)
## in root: ant (debug)
## in root: adb install -r bin/NativeActivity-debug.apk
## (if no debug build, might have to sign apk: keytool, jarsigner, zipalign)
