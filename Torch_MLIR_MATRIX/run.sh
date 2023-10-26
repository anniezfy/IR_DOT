#Export the mlir-opt tool under the llvm build directory
export PATH=$PWD:"/Users/anniezfy/llvm-project-mine/build/bin"


# use mlir-opt to compile the torch2.2.mlir file
mlir-opt compiled_torch2.2.mlir --canonicalize -convert-tensor-to-linalg -empty-tensor-to-alloc-tensor \
-eliminate-empty-tensors -linalg-bufferize -arith-bufferize   -tensor-bufferize -func-bufferize \
-finalizing-bufferize -buffer-deallocation   --buffer-results-to-out-params   --canonicalize -cse \
-convert-linalg-to-affine-loops > matrix_mulitiplication_2.2.mlir

# | indicate the output of the first command is the input of the second command
# use mlir-opt tool test-lower-to-llvm option to compile the mlir file to llvm ir
# use mlir-translate tool to compile the mlir file to llvm ir
mlir-opt test.mlir --one-shot-bufferize='bufferize-function-boundaries' -test-lower-to-llvm | mlir-translate -mlir-to-llvmir > matrix_mulitiplication_2.2.ll
# clang indicate the input is llvm ir file and -c indicate the output is object file
/Users/anniezfy/Polygeist_Hector/Polygeist/llvm-project/build/bin/clang matrix_mulitiplication_2.2.ll -x ir -c

# opt is tool for llvm LLVM analysis option -aa-pipeline=basic-aa indicate the alias analysis
# -passes indicate the passes we want to run and -dot-cfg-mssa indicate the output is dot file
opt matrix_mulitiplication_2.2.ll -aa-pipeline=basic-aa -passes='print<memoryssa>' -dot-cfg-mssa="matrix_mulitiplication_2.2.dot"



# use mlir-opt --affine-#$loop-unroll and -test-lower-to-llvm options
# some tips about the options:Most useful linalg transforms, other than unrolling,
# should happen before bufferization. And using the one-shot bufferization is the recommended path.
#mlir-opt matrix_mulitiplication_affine_2.2.mlir --affine-loop-unroll="unroll-full" \
#--affine-loop-unroll="unroll-full" --affine-loop-unroll="unroll-full" \
#-convert-arith-to-llvm -test-lower-to-llvm