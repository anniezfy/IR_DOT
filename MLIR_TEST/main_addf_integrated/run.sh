# exprot mlir tool path mlir version: 5341d5465dbf0b35c64c54f200af8389a8b76aef
export PATH=$PWD:"/Users/anniezfy/llvm-project-mine/build/bin"

# process the mlir file to llvm dialects and then convert to mlir dialects
 mlir-opt --one-shot-bufferize='bufferize-function-boundaries' -test-lower-to-llvm main.mlir | mlir-translate -mlir-to-llvmir > main.ll

# using clang tool to compile mlir dialects to generate object file
# and specifies the include system path
/Users/anniezfy/Polygeist_Hector/Polygeist/llvm-project/build/bin/clang -x ir main.ll   -isysroot $(xcrun --sdk macosx --show-sdk-path)
