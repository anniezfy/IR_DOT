; ModuleID = 'LLVMDialectModule'
source_filename = "LLVMDialectModule"

@fmtstr = global [3 x i8] c"%f\0A"

declare ptr @malloc(i64)

declare void @free(ptr)

declare double @atof(ptr)

declare i32 @printf(ptr, ...)

define i32 @main(i32 %0, ptr %1) {
  %3 = getelementptr ptr, ptr %1, i32 1
  %4 = load ptr, ptr %3, align 8
  %5 = call double @atof(ptr %4)
  %6 = getelementptr ptr, ptr %1, i32 2
  %7 = load ptr, ptr %6, align 8
  %8 = call double @atof(ptr %7)
  %9 = fadd double %5, %8
  %10 = call i32 (ptr, ...) @printf(ptr @fmtstr, double %9)
  ret i32 %10
}

!llvm.module.flags = !{!0}

!0 = !{i32 2, !"Debug Info Version", i32 3}
