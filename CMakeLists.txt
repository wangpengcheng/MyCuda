# 按惯例，cmake的版本
CMAKE_MINIMUM_REQUIRED(VERSION 2.8)
# 设置项目名称
set(PROJECT_NAME "MyCuda")

# 设置编译模式

if(NOT CMAKE_BUILD_TYPE)
    set(CMAKE_BUILD_TYPE "Debug")
endif()
message(STATUS "build type: ${CMAKE_BUILD_TYPE}")
#set(CMAKE_CXX_COMPILER "g++")

if(CMAKE_BUILD_TYPE MATCHES "Debug")
    set(CMAKE_CXX_FLAGS_DEBUG "-O0")
    set(CMAKE_CXX_FLAGS_RELEASE "-O0")
    set(CXX_FLAGS
        ${CXX_FLAGS}
        -g
        -Wall
        -Wno-unused-parameter
    )
    set(
        ${CUDA_NVCC_FLAGS}
        -g
        -Wall
        -Wno-unused-parameter
    )
else()
    set(CMAKE_CXX_FLAGS_DEBUG "${CMAKE_CXX_FLAGS_DEBUG} -O3")
    set(CMAKE_CXX_FLAGS_RELEASE "${CMAKE_CXX_FLAGS_RELEASE} -O3")
endif()


# 项目名称
PROJECT(MyCuda)
# cmake寻找cuda，这个要现在系统里面装好cuda，设置好cuda的环境参数啥的
FIND_PACKAGE(CUDA REQUIRED)
if (NOT CUDA_FOUND)
  message(STATUS "CUDA not found. Project will not be built.")
endif(NOT CUDA_FOUND)

# C++和CUDA的编译参数，可选。
SET(CMAKE_CXX_FLAGS "${CMAKE_CXX_FLAGS} -std=c++11")
SET(CUDA_NVCC_FLAGS "${CUDA_NVCC_FLAGS} -gencode arch=compute_61,code=sm_61 -std=c++11")
# 头文件路径，按需
INCLUDE_DIRECTORIES(
    ${PROJECT_SOURCE_DIR}/include
    ${CUDA_INCLUDE_DIRS}
    )
# set(SRC_LIST 
    # ${PROJECT_SOURCE_DIR}/
# )
# 库文件路径，按需
LINK_DIRECTORIES(
    /usr/lib
    /usr/local/lib
    )


set(OUT_ROOT_DIR ${PROJECT_SOURCE_DIR}/install/lib)
message(STATUS "install root dir : ${OUT_ROOT_DIR}")
    
function(check_dir arg)
    set(dir_name ${ARGV0})
    if(EXISTS ${dir_name})
    else()
        file(MAKE_DIRECTORY ${dir_name})
        message(STATUS "create dir:${dir_name}")
    endif()
endfunction()
    
    # 设置一般输出目录函数
function(set_out_path arg)
    set(root_path ${ARGV0})
    check_dir(${root_path}/Debug)
    check_dir(${root_path}/Release)
endfunction()
    
    
# 设置输出目录 
set_out_path(${OUT_ROOT_DIR})
set(CMAKE_ARCHIVE_OUTPUT_DIRECTORY_DEBUG ${OUT_ROOT_DIR}/Debug)
set(CMAKE_ARCHIVE_OUTPUT_DIRECTORY_RELEASE ${OUT_ROOT_DIR}/Release)
set(CMAKE_RUNTIME_OUTPUT_DIRECTORY_DEBUG ${OUT_ROOT_DIR}/Debug)
set(CMAKE_RUNTIME_OUTPUT_DIRECTORY_RELEASE ${OUT_ROOT_DIR}Release)
message(STATUS "out dir :${CMAKE_RUNTIME_OUTPUT_DIRECTORY_DEBUG}")
set(LIBRARY_OUTPUT_PATH ${CMAKE_SOURCE_DIR}/lib)

# 主要就是这个，教cmake去找nvcc来编译这些东西
CUDA_ADD_EXECUTABLE(cudaQuery
    ./src/cudaQuery.cu
)
CUDA_ADD_EXECUTABLE(cudatest
    ./src/cudatest.cu
)
# add_executable(
#     ${RPOJECT_NAME}
#     ${PROJECT_SOURCE_DIR}/main.cpp
# )


# 链接外部库，按需
target_link_libraries(cudaQuery ${CUDA_cudadevrt_LIBRARY})
target_link_libraries(cudatest ${CUDA_cudadevrt_LIBRARY})
