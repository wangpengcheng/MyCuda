#include <iostream>
#include <memory>
#include <helper_string.h>
#include <helper_cuda.h>
#include <cuda.h>
#include <cuda_runtime.h>
#include <stdlib.h>
#include <string>

#define SHOW_DETAIL 1

#define CUDA_ERROR_HANDLER(error_id,function_name) \
    if(error_id != cudaSuccess) { \
        printf( #function_name " returned code:%d -> error_msg: %s\n",(int)error_id,cudaGetErrorString(error_id) ); \ 
        printf("Result = FAIL\n"); \
    }
#define CUDA_PROP_PRINTF(property_name) \
    if(typeid(property_name)!=typeid(std::string)){ \
        std::string pro_value = std::to_string(property_name); \
        std::cout<<"cuda " #property_name "'s value:"<<pro_value<<std::endl;\
    } else { std::cout<<"cuda " #property_name "'s value:"<<property_name<<std::endl; }\
     

int main(int argc,char* argv[]) {
    // 开始
    printf("------ %s start ... ------ \n",argv[0]);
    // 查询设备数量
    int device_count = 0;
    cudaError_t error_id = cudaGetDeviceCount(&device_count);
    CUDA_ERROR_HANDLER(error_id,cudaGetdevice_count)
    if(device_count<=0) {
        printf("There are no available device(s) that support CUDA \n");
    }else {
        printf("Detected %d CUDA Capable device(s)\n", device_count);
    }
    int driver_version = 0;
    int runtime_version = 0;
    for(int dev=0;dev<device_count;++dev) {
        // 设置当前设备
        cudaSetDevice(dev);
        // 查询对应基础版本
        cudaDriverGetVersion(&driver_version);
        cudaRuntimeGetVersion(&runtime_version);
        printf("  CUDA Driver Version/Runtime Version/NumDevs    %d.%d / %d.%d / %d\n", driver_version/1000, (driver_version%100)/10, runtime_version/1000, (runtime_version%100)/10,device_count);
        // 查询属性
        cudaDeviceProp device_properties;
        cudaGetDeviceProperties(&device_properties,dev);
        // 输出设备名称
        printf("  Device_properties.name :                       %s\n",device_properties.name);
#ifdef SHOW_DETAIL
        // 计算总的内存大小
        char msg[255];
        sprintf(msg,"  Total amount of global memory:                 %.0f MBytes (%llu bytes)\n",
                (float)device_properties.totalGlobalMem/1048576.0f, (unsigned long long) device_properties.totalGlobalMem);
        printf(msg);
        // 内存刷新频率
        printf("  Memory Clock rate:                             %.0f Mhz\n", device_properties.memoryClockRate * 1e-3f);
        // 总线带宽
        printf("  Memory Bus Width:                              %d-bit\n",device_properties.memoryBusWidth);
        // 输出其支持的SM小代
        printf("  Support SM with:                               sm_%0x compute\n",((device_properties.major << 4) + device_properties.minor));
        //流式处理器数目/每个流式处理器中的core 数目/CUDA core的数目
        printf("  (%2d) Multiprocessors, (%3d) CUDA Cores/MP:     %d CUDA Cores\n",
               device_properties.multiProcessorCount,
               _ConvertSMVer2Cores(device_properties.major, device_properties.minor),
               _ConvertSMVer2Cores(device_properties.major, device_properties.minor) * device_properties.multiProcessorCount);
        // GPU时钟频率
        printf("  GPU Max Clock rate:                            %.0f MHz (%0.2f GHz)\n", device_properties.clockRate * 1e-3f, device_properties.clockRate * 1e-6f);
        // 输出l2缓存大小
        if(device_properties.l2CacheSize) {
            printf("  L2 Cache Size:                                 %d bytes\n",device_properties.l2CacheSize);
        }
        // 查看纹理维度大小
        printf("  Maximum Texture Dimension Size (x,y,z)         1D=(%d), 2D=(%d, %d), 3D=(%d, %d, %d)\n",
               device_properties.maxTexture1D   , device_properties.maxTexture2D[0], device_properties.maxTexture2D[1],
               device_properties.maxTexture3D[0], device_properties.maxTexture3D[1], device_properties.maxTexture3D[2]);
        printf("  Maximum Layered 1D Texture Size, (num) layers  1D=(%d), %d layers\n",
               device_properties.maxTexture1DLayered[0], device_properties.maxTexture1DLayered[1]);
        printf("  Maximum Layered 2D Texture Size, (num) layers  2D=(%d, %d), %d layers\n",
               device_properties.maxTexture2DLayered[0], device_properties.maxTexture2DLayered[1], device_properties.maxTexture2DLayered[2]);
        // 静态内存大小
        printf("  Total amount of constant memory:               %lu bytes\n", device_properties.totalConstMem);
        // 每个block的共享内存大小
        printf("  Total amount of shared memory per block:       %lu bytes\n", device_properties.sharedMemPerBlock);
        // 每个block的寄存器数量
        printf("  Total number of registers available per block: %d\n", device_properties.regsPerBlock);
        // GPU中最小调度单位warp的大小
        printf("  Warp size:                                     %d\n", device_properties.warpSize);
        // 每个流式处理器中的最大线线程数目
        printf("  Maximum number of threads per multiprocessor:  %d\n", device_properties.maxThreadsPerMultiProcessor);
        // 每个block中的线程数
        printf("  Maximum number of threads per block:           %d\n", device_properties.maxThreadsPerBlock);
        // 每个block中线程块的最大维度大小
        printf("  Max dimension size of a thread block (x,y,z): (%d, %d, %d)\n",
               device_properties.maxThreadsDim[0],
               device_properties.maxThreadsDim[1],
               device_properties.maxThreadsDim[2]);
        // 每个网格的各个维度大小
        printf("  Max dimension size of a grid size    (x,y,z): (%d, %d, %d)\n",
               device_properties.maxGridSize[0],
               device_properties.maxGridSize[1],
               device_properties.maxGridSize[2]);
        // 最大内存步长
        printf("  Maximum memory pitch:                          %lu bytes\n", device_properties.memPitch);
        // 纹理对齐内存大小
        printf("  Texture alignment:                             %lu bytes\n", device_properties.textureAlignment);
        // 异步引擎计数
        printf("  Concurrent copy and kernel execution:          %s with %d copy engine(s)\n", (device_properties.deviceOverlap ? "Yes" : "No"), device_properties.asyncEngineCount);
        // 运行时超时限制
        printf("  Run time limit on kernels:                     %s\n", device_properties.kernelExecTimeoutEnabled ? "Yes" : "No");
        // 是否支持共享逻辑内存
        printf("  Integrated GPU sharing Host Memory:            %s\n", device_properties.integrated ? "Yes" : "No");
        // 是否支持共享内存映射
        printf("  Support host page-locked memory mapping:       %s\n", device_properties.canMapHostMemory ? "Yes" : "No");
        // 是否支持海浪处理
        printf("  Alignment requirement for Surfaces:            %s\n", device_properties.surfaceAlignment ? "Yes" : "No");
        // 是否支持ECC
        printf("  Device has ECC support:                        %s\n", device_properties.ECCEnabled ? "Enabled" : "Disabled");
        // 是否支持统一寻址
        printf("  Device supports Unified Addressing (UVA):      %s\n", device_properties.unifiedAddressing ? "Yes" : "No");
        // 是否支持协同内核启动
        printf("  Supports Cooperative Kernel Launch:            %s\n", device_properties.cooperativeLaunch ? "Yes" : "No");
        // 支持多设备协同内核启动
        printf("  Supports MultiDevice Co-op Kernel Launch:      %s\n", device_properties.cooperativeMultiDeviceLaunch ? "Yes" : "No");
        // 对应的PCIE设备号和总线编号
        printf("  Device PCI Domain ID / Bus ID / location ID:   %d / %d / %d\n", device_properties.pciDomainID, device_properties.pciBusID, device_properties.pciDeviceID);
        // 支持的计算模型
        const char *sComputeMode[] =
        {
            "Default (multiple host threads can use ::cudaSetDevice() with device simultaneously)",
            "Exclusive (only one host thread in one process is able to use ::cudaSetDevice() with this device)",
            "Prohibited (no host thread can use ::cudaSetDevice() with this device)",
            "Exclusive Process (many threads in one process is able to use ::cudaSetDevice() with this device)",
            "Unknown",
            NULL
        };
        printf("  Compute Mode:\n");
        printf("     < %s >\n", sComputeMode[device_properties.computeMode]);
        
    }
#else
        CUDA_PROP_PRINTF(device_properties.computeMode)
#endif
    // If there are 2 or more GPUs, query to determine whether RDMA is supported
    if (device_count >= 2)
    {
        cudaDeviceProp prop[64];
        int gpuid[64]; // 找到对点传输的GPU
        int gpu_p2p_count = 0;

        for (int i=0; i < device_count; i++)
        {
            checkCudaErrors(cudaGetDeviceProperties(&prop[i], i));

            // P2P先要确定其为费米或者开普勒架构
            if ((prop[i].major >= 2))
            {
                // This is an array of P2P capable GPUs
                gpuid[gpu_p2p_count++] = i;
            }
        }

        // Show all the combinations of support P2P GPUs
        int can_access_peer;
        // 支持数目大于2
        if (gpu_p2p_count >= 2)
        {
            for (int i = 0; i < gpu_p2p_count; i++)
            {
                for (int j = 0; j < gpu_p2p_count; j++)
                {
                    if (gpuid[i] == gpuid[j])
                    {
                        continue;
                    }
                    // 查询GPU之间是否支持直接通路
                    checkCudaErrors(cudaDeviceCanAccessPeer(&can_access_peer, gpuid[i], gpuid[j]));
                        printf("> Peer access from %s (GPU%d) -> %s (GPU%d) : %s\n", prop[gpuid[i]].name, gpuid[i],
                           prop[gpuid[j]].name, gpuid[j] ,
                           can_access_peer ? "Yes" : "No");
                }
            }
        }
    }
    printf("------ %s end ... ------ \n\n",argv[0]);
    return 0;
}