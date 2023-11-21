; ModuleID = 'LLVMDialectModule'
source_filename = "LLVMDialectModule"

declare ptr @malloc(i64)

declare void @free(ptr)

!llvm.module.flags = !{!0}

!0 = !{i32 2, !"Debug Info Version", i32 3}
