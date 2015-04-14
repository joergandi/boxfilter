HOST_COMPILER ?= $(NDK_ROOT)/toolchains/arm-linux-androideabi-4.6/gen_standalone/linux-x86_64/bin/arm-linux-androideabi-g++

NVCC := $(CUDA_TOOLKIT_ROOT)/bin/nvcc -ccbin $(HOST_COMPILER) -m32 -arch=sm_53
# nvlinker warning: sm_32, sm_30 archs not found in cufft_static... only sm_53?

CUDALIBS := -L$(CUDA_TOOLKIT_ROOT)/targets/armv7-linux-androideabi/lib -lcudart_static -lcufft_static -lcudadevrt -lculibos

################################################################################
# Target rules
all: build

build: lib_boxFilter.a

boxFilter_kernel.o: boxFilter_kernel.cu
	$(NVCC) $(EXTRA_CFLAGS) -o "$@" -dc "$<" 
 #need device compilation, otherwise cufft linkage fails?
#	$(NVCC) $(EXTRA_CFLAGS) -o "$@" -c "$<"

lib_boxFilter.o: boxFilter_kernel.o
	$(NVCC) -dlink -o "$@" "$<" $(CUDALIBS)	
#need device link, otherwise cufft linkage fails?
#	$(NVCC) -lib -o "$@" "$<" 

lib_boxFilter.a: lib_boxFilter.o boxFilter_kernel.o
	ar -rcs $@ $+

clean:
	rm -rf *.a *.o
