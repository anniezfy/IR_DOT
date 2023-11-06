 export PATH=$PWD:"/Users/anniezfy/llvm-project-mine/build/bin"

 mlir-opt --one-shot-bufferize='bufferize-function-boundaries' -test-lower-to-llvm main.mlir | mlir-translate -mlir-to-llvmir > main.ll

/Users/anniezfy/Polygeist_Hector/Polygeist/llvm-project/build/bin/clang -x ir main.ll   -isysroot $(xcrun --sdk macosx --show-sdk-path)
