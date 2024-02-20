
#include "cuda_runtime.h"
#include "device_launch_parameters.h"

#include <math.h>
#include <stdio.h>
#include "kernel.h"
#define TPB 32

__device__
float distance(float x1, float x2) {
	return sqrt((x2 - x1)*(x2 - x1));
}

__global__
void distanceKernel(float *d_out, float *d_in, float ref) {
	
	const int i = blockIdx.x * blockDim.x + threadIdx.x;
	
	const float x = d_in[i];

	d_out[i] = distance(x, ref);

	printf("i = %2d: dist from %f to %f is %f.\n", i, ref, x, d_out[i]);
}

void distanceArray(float* out, float* in, float ref, int len) {

	// Declare pointers to device arrays
	float* d_in = 0; // Pointers to null, addresses no object
	float* d_out = 0;

	// Allocate memory for device arrays
	cudaMalloc(&d_in, len * sizeof(float)); // The parameters of cudaMalloc() are: devPtr [Pointer to allocated device memory] and size [Requested allocation size in bytes]
	cudaMalloc(&d_out, len * sizeof(float));

	// Copy input data from host to device
	cudaMemcpy(d_in, in, len * sizeof(float), cudaMemcpyHostToDevice); // Parameters: dst [Destination memory address], src [Source memory address], 
	                                                                   //             count [Size in bytes to copy], kind [Type of transfer]

	// Launch kernel to compute and store distance values
	distanceKernel <<<dim3(len / TPB, 1, 1), dim3(TPB, 1, 1) >>> (d_out, d_in, ref);

	// Cpy results from device to host
	cudaMemcpy(out, d_out, len * sizeof(float), cudaMemcpyDeviceToHost);

	// Free memory allocated for device arrays
	cudaFree(d_in);
	cudaFree(d_out);
}
