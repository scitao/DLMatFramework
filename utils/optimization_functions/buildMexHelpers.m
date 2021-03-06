%% Build mex bridge for 2d matrix multiplication

%% Im2col
mex  CFLAGS="\$CFLAGS -std=c++11 -O2 -fopenmp" ...
    -Iutils/optimization_functions/include ...
    utils/optimization_functions/mexFunctions/mex_im2col.cpp ...    
    utils/optimization_functions/cpu/im2col.cpp ...
    -outdir work -output mex_im2col;

%% Im2col_back
mex  CFLAGS="\$CFLAGS -std=c++11 -O2 -fopenmp" ...
    -Iutils/optimization_functions/include ...
    utils/optimization_functions/mexFunctions/mex_im2col_back.cpp ...    
    utils/optimization_functions/cpu/im2col_back.cpp ...
    -outdir work -output mex_im2col_back;

%% Reshape row major
mex -g CFLAGS="\$CFLAGS -std=c++11 -O2 -fopenmp" ...
    -Iutils/optimization_functions/include ...
    utils/optimization_functions/mexFunctions/mex_reshape_row_major.cpp ...    
    utils/optimization_functions/cpu/reshape_row_major.cpp ...
    -outdir work -output mex_reshape_row_major;

%% OpenCL naive sgemm (Matrix multplication)
mex CFLAGS="\$CFLAGS -std=c99 " ...
    -Iutils/optimization_functions/include ...
    -I/usr/local/cuda-8.0/include/ -L/usr/local/cuda-8.0/lib64 ...    
    utils/optimization_functions/mexFunctions/mex_matMult2D.cpp ...
    utils/optimization_functions/opencl/OpenCl_Helper.cpp ...
    utils/optimization_functions/opencl/sgemm_naive.cpp ...
    -lOpenCL -lm ...
    -outdir work -output mex_matMult2D_CL;