#ifndef CUDA_TEST_H
#define CUDA_TEST_H
//include cuda
#include <cuda_runtime.h>
#include <device_launch_parameters.h>
#include <malloc.h>
#include <stdio.h>

#define  HEIGHT 10
#define  X_INTER 3
#define  Y_INTER 3
#define  BLOCK_SIZE 8

void BinlinearInterpolation();
#endif // CUDA_TEST_H
