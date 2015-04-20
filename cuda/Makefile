HOST_COMPILER ?= $(NDK_ROOT)/toolchains/arm-linux-androideabi-4.6/gen_standalone/linux-x86_64/bin/arm-linux-androideabi-g++

NVCC := $(CUDA_TOOLKIT_ROOT)/bin/nvcc -ccbin $(HOST_COMPILER) -m32 -arch=sm_32
# cufft_static has not all arch profiles for CUDA7 (only sm_53) - have to use cuda65 for sm_32!

CUDALIBS := -L$(CUDA_TOOLKIT_ROOT)/targets/armv7-linux-androideabi/lib -lcudart_static -lcufft_static -lcudadevrt -lculibos

#explicitely add stlport_static dependency
CUDALIBS += -L$(NDK_ROOT)/sources/cxx-stl/stlport/libs/armeabi-v7a/ -lstlport_static

CCFLAGS := -g -G -Xcompiler -std=c++11 -Xcompiler -fpic -I$(CUDA_TOOLKIT_ROOT)/targets/armv7-linux-androideabi/include -Xcompiler -fexceptions -Xcompiler -frtti
# -Xcompiler -fpie  #DO NOT ADD HOST CUDA INCLUDE DIR!
LDFLAGS := 
#-Xlinker -pie

################################################################################
# Target rules
all: build

build: lib_boxFilter.a

boxFilter_kernel.cu.o: boxFilter_kernel.cu
	$(NVCC) $(EXTRA_CFLAGS) $(CCFLAGS) -std=c++11 -o "$@" -dc "$<" 
 #need device compilation, otherwise cufft linkage fails

lib_boxFilter.o: boxFilter_kernel.cu.o
	$(NVCC) $(LDFLAGS) $(CCFLAGS) -std=c++11 -dlink -o "$@" "$<" $(CUDALIBS)	
#need device link, otherwise cufft linkage fails

lib_boxFilter.a: lib_boxFilter.o boxFilter_kernel.cu.o
	#$(NVCC) $(LDFLAGS) $(CCFLAGS) -lib -o $@ $+ $(CUDALIBS)
	ar -rcs $@ $+

clean:
	rm -rf *.a *.o
