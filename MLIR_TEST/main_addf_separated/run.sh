# exprot mlir tool path mlir version: 5341d5465dbf0b35c64c54f200af8389a8b76aef
export PATH=$PWD:"/Users/anniezfy/llvm-project-mine/build/bin"

# process the mlir file to llvm dialects and then convert to mlir dialects
mlir-opt --one-shot-bufferize='bufferize-function-boundaries' -test-lower-to-llvm addf.mlir | mlir-translate -mlir-to-llvmir > addf.ll

# using clang tool to compile mlir dialects to generate executable file
# and specifies the include system path
# The command compiles and links the C source file main.c and the LLVM Intermediate Representation (IR) file addf.ll to create an executable named main.
#  lower it to LLVMIR, build a binary, run it and compare the outputs to a golden reference
/Users/anniezfy/Polygeist_Hector/Polygeist/llvm-project/build/bin/clang main.c -x ir addf.ll -o main  -isysroot "/Library/Developer/CommandLineTools/SDKs/MacOSX.sdk"

