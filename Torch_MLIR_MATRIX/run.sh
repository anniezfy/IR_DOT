#Export the mlir-opt tool under the llvm build directory
export PATH=$PWD:"/Users/anniezfy/llvm-project-mine/build/bin"

# use mlir-opt to compile the torch2.2.mlir file
mlir-opt compiled_torch2.2.mlir --canonicalize -convert-tensor-to-linalg -empty-tensor-to-alloc-tensor \
-eliminate-empty-tensors -linalg-bufferize -arith-bufferize   -tensor-bufferize -func-bufferize \
-finalizing-bufferize -buffer-deallocation   --buffer-results-to-out-params   --canonicalize -cse \
-convert-linalg-to-affine-loops > matrix_mulitiplication_2.2.mlir


# use mlir-opt --affine-#$loop-unroll and -test-lower-to-llvm options
# some tips about the options:Most useful linalg transforms, other than unrolling,
# should happen before bufferization. And using the one-shot bufferization is the recommended path.
#mlir-opt matrix_mulitiplication_affine_2.2.mlir --affine-loop-unroll="unroll-full" \
#--affine-loop-unroll="unroll-full" --affine-loop-unroll="unroll-full" \
#-convert-arith-to-llvm -test-lower-to-llvm