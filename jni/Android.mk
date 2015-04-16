LOCAL_PATH := $(call my-dir)

TOOLCHAINVERSION := 4.9
#4.6

include $(CLEAR_VARS)
LOCAL_MODULE := libstlport_static
#instead of APP_STL := stlport_static in Application.mk which doesnt work, ndk bug?
LOCAL_SRC_FILES := $(NDK_ROOT)/sources/cxx-stl/stlport/libs/armeabi-v7a/libstlport_static.a
include $(PREBUILT_STATIC_LIBRARY)


#include $(CLEAR_VARS)
#LOCAL_MODULE := libgnustl_static
##instead of APP_STL := gnustl_static in Application.mk
#LOCAL_SRC_FILES := $(NDK_ROOT)/sources/cxx-stl/gnu-libstdc++/$(TOOLCHAINVERSION)/libs/armeabi-v7a/libgnustl_static.a
#LOCAL_EXPORT_C_INCLUDES := $(NDK_ROOT)/sources/cxx-stl/gnu-libstdc++/$(TOOLCHAINVERSION)/include 
#LOCAL_EXPORT_C_INCLUDES += $(NDK_ROOT)/sources/cxx-stl/gnu-libstdc++/$(TOOLCHAINVERSION)/libs/armeabi-v7a/include
#include $(PREBUILT_STATIC_LIBRARY)
#
#include $(CLEAR_VARS)
#LOCAL_MODULE := libsupc++
##instead of APP_STL := gnustl_static in Application.mk
#LOCAL_SRC_FILES := $(NDK_ROOT)/sources/cxx-stl/gnu-libstdc++/$(TOOLCHAINVERSION)/libs/armeabi-v7a/libsupc++.a
#LOCAL_EXPORT_C_INCLUDES := $(NDK_ROOT)/sources/cxx-stl/gnu-libstdc++/$(TOOLCHAINVERSION)/include 
#LOCAL_EXPORT_C_INCLUDES += $(NDK_ROOT)/sources/cxx-stl/gnu-libstdc++/$(TOOLCHAINVERSION)/libs/armeabi-v7a/include
#include $(PREBUILT_STATIC_LIBRARY)
#
#include $(CLEAR_VARS)
#LOCAL_MODULE := libgnustl_shared
##instead of APP_STL := gnustl_static in Application.mk
#LOCAL_SRC_FILES := $(NDK_ROOT)/sources/cxx-stl/gnu-libstdc++/4.6/libs/armeabi-v7a/libgnustl_shared.so
#LOCAL_EXPORT_C_INCLUDES := $(NDK_ROOT)/sources/cxx-stl/gnu-libstdc++/4.6/include 
#LOCAL_EXPORT_C_INCLUDES += $(NDK_ROOT)/sources/cxx-stl/gnu-libstdc++/4.6/libs/armeabi-v7a/include
#include $(PREBUILT_SHARED_LIBRARY)

include $(CLEAR_VARS)
LOCAL_MODULE := libcudart_static
LOCAL_STATIC_LIBRARIES := libstlport_static #libgnustl_static libsupc++
LOCAL_SRC_FILES  := $(CUDA_TOOLKIT_ROOT)/targets/armv7-linux-androideabi/lib/libcudart_static.a 
LOCAL_EXPORT_C_INCLUDES := $(CUDA_TOOLKIT_ROOT)/targets/armv7-linux-androideabi/include
include $(PREBUILT_STATIC_LIBRARY)

include $(CLEAR_VARS)
#dependency of culibos?
LOCAL_MODULE := libcudadevrt
LOCAL_STATIC_LIBRARIES := libcudart_static libstlport_static #libgnustl_static libsupc++
LOCAL_SRC_FILES  := $(CUDA_TOOLKIT_ROOT)/targets/armv7-linux-androideabi/lib/libcudadevrt.a 
LOCAL_EXPORT_C_INCLUDES := $(CUDA_TOOLKIT_ROOT)/targets/armv7-linux-androideabi/include
include $(PREBUILT_STATIC_LIBRARY)

include $(CLEAR_VARS)
#dependency of cufft_static?
LOCAL_MODULE := libculibos
LOCAL_STATIC_LIBRARIES := libcudart_static libcudadevrt libstlport_static #libgnustl_static libsupc++
LOCAL_SRC_FILES  := $(CUDA_TOOLKIT_ROOT)/targets/armv7-linux-androideabi/lib/libculibos.a 
LOCAL_EXPORT_C_INCLUDES := $(CUDA_TOOLKIT_ROOT)/targets/armv7-linux-androideabi/include
include $(PREBUILT_STATIC_LIBRARY)

include $(CLEAR_VARS)
LOCAL_MODULE := libcufft_static
LOCAL_STATIC_LIBRARIES := libcudart_static libcudadevrt libculibos libstlport_static #libgnustl_static libsupc++
LOCAL_SRC_FILES  := $(CUDA_TOOLKIT_ROOT)/targets/armv7-linux-androideabi/lib/libcufft_static.a 
LOCAL_EXPORT_C_INCLUDES := $(CUDA_TOOLKIT_ROOT)/targets/armv7-linux-androideabi/include
include $(PREBUILT_STATIC_LIBRARY)

include $(CLEAR_VARS)
LOCAL_MODULE := lib_boxFilter
LOCAL_STATIC_LIBRARIES := libcudart_static libcudadevrt libculibos libcufft_static libstlport_static #libgnustl_static libsupc++
LOCAL_SRC_FILES := ../cuda/lib_boxFilter.a
LOCAL_EXPORT_C_INCLUDES := ../cuda
include $(PREBUILT_STATIC_LIBRARY)

include $(CLEAR_VARS)
LOCAL_MODULE := boxfilter

NVPACK := $(NDK_ROOT)/..
BOX_FILTER_ROOT := $(LOCAL_PATH)/..

MY_PREFIX       := $(LOCAL_PATH)/
MY_SOURCES      := $(wildcard $(LOCAL_PATH)/*.cpp)
LOCAL_SRC_FILES := $(MY_SOURCES:$(MY_PREFIX)%=%)
 
LOCAL_STATIC_LIBRARIES :=  lib_boxFilter libcudart_static libcudadevrt libculibos libcufft_static libstlport_static #libgnustl_static libsupc++
LOCAL_STATIC_LIBRARIES += nv_and_util nv_egl_util nv_glesutil nv_shader nv_file
#LOCAL_SHARED_LIBRARIES := libgnustl_shared
LOCAL_LDLIBS := -llog -landroid -lGLESv2 -lEGL 
LOCAL_C_INCLUDES += $(BOX_FILTER_ROOT)/cuda
LOCAL_C_INCLUDES += $(CUDA_TOOLKIT_ROOT)/targets/armv7-linux-androideabi/include


include $(BUILD_SHARED_LIBRARY)

$(call import-add-path, $(NVPACK)/Samples/TDK_Samples/libs/jni)

$(call import-module,nv_and_util)
$(call import-module,nv_egl_util)
$(call import-module,nv_shader)
$(call import-module,nv_file)
$(call import-module,nv_glesutil)
