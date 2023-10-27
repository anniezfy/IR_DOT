 ;ModuleID = 'LLVMDialectModule'
source_filename = "LLVMDialectModule"

declare ptr @malloc(i64)

declare void @free(ptr)

define void @forward(ptr %0, ptr %1, i64 %2, i64 %3, i64 %4, i64 %5, i64 %6, ptr %7, ptr %8, i64 %9, i64 %10, i64 %11, i64 %12, i64 %13, ptr %14, ptr %15, i64 %16, i64 %17, i64 %18, i64 %19, i64 %20) {
  %22 = insertvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } undef, ptr %0, 0
  %23 = insertvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %22, ptr %1, 1
  %24 = insertvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %23, i64 %2, 2
  %25 = insertvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %24, i64 %3, 3, 0
  %26 = insertvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %25, i64 %5, 4, 0
  %27 = insertvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %26, i64 %4, 3, 1
  %28 = insertvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %27, i64 %6, 4, 1
  %29 = insertvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } undef, ptr %7, 0
  %30 = insertvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %29, ptr %8, 1
  %31 = insertvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %30, i64 %9, 2
  %32 = insertvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %31, i64 %10, 3, 0
  %33 = insertvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %32, i64 %12, 4, 0
  %34 = insertvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %33, i64 %11, 3, 1
  %35 = insertvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %34, i64 %13, 4, 1
  %36 = insertvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } undef, ptr %14, 0
  %37 = insertvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %36, ptr %15, 1
  %38 = insertvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %37, i64 %16, 2
  %39 = insertvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %38, i64 %17, 3, 0
  %40 = insertvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %39, i64 %19, 4, 0
  %41 = insertvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %40, i64 %18, 3, 1
  %42 = insertvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %41, i64 %20, 4, 1
  %43 = call ptr @malloc(i64 add (i64 ptrtoint (ptr getelementptr (float, ptr null, i32 9) to i64), i64 64))
  %44 = ptrtoint ptr %43 to i64
  %45 = add i64 %44, 63
  %46 = urem i64 %45, 64
  %47 = sub i64 %45, %46
  %48 = inttoptr i64 %47 to ptr
  %49 = insertvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } undef, ptr %43, 0
  %50 = insertvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %49, ptr %48, 1
  %51 = insertvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %50, i64 0, 2
  %52 = insertvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %51, i64 3, 3, 0
  %53 = insertvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %52, i64 3, 3, 1
  %54 = insertvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %53, i64 3, 4, 0
  %55 = insertvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %54, i64 1, 4, 1
  br label %56

56:                                               ; preds = %67, %21
  %57 = phi i64 [ %68, %67 ], [ 0, %21 ]
  %58 = icmp slt i64 %57, 3
  br i1 %58, label %59, label %69

59:                                               ; preds = %62, %56
  %60 = phi i64 [ %66, %62 ], [ 0, %56 ]
  %61 = icmp slt i64 %60, 3
  br i1 %61, label %62, label %67

62:                                               ; preds = %59
  %63 = mul i64 %57, 3
  %64 = add i64 %63, %60
  %65 = getelementptr float, ptr %48, i64 %64
  store float 0.000000e+00, ptr %65, align 4
  %66 = add i64 %60, 1
  br label %59

67:                                               ; preds = %59
  %68 = add i64 %57, 1
  br label %56

69:                                               ; preds = %56
  %70 = call ptr @malloc(i64 add (i64 ptrtoint (ptr getelementptr (float, ptr null, i32 9) to i64), i64 64))
  %71 = ptrtoint ptr %70 to i64
  %72 = add i64 %71, 63
  %73 = urem i64 %72, 64
  %74 = sub i64 %72, %73
  %75 = inttoptr i64 %74 to ptr
  %76 = insertvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } undef, ptr %70, 0
  %77 = insertvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %76, ptr %75, 1
  %78 = insertvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %77, i64 0, 2
  %79 = insertvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %78, i64 3, 3, 0
  %80 = insertvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %79, i64 3, 3, 1
  %81 = insertvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %80, i64 3, 4, 0
  %82 = insertvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %81, i64 1, 4, 1
  %83 = getelementptr float, ptr %48, i64 0
  %84 = getelementptr float, ptr %75, i64 0
  call void @llvm.memcpy.p0.p0.i64(ptr %84, ptr %83, i64 mul (i64 ptrtoint (ptr getelementptr (float, ptr null, i32 1) to i64), i64 9), i1 false)
  call void @free(ptr %43)
  br label %85

85:                                               ; preds = %115, %69
  %86 = phi i64 [ %116, %115 ], [ 0, %69 ]
  %87 = icmp slt i64 %86, 3
  br i1 %87, label %88, label %117

88:                                               ; preds = %113, %85
  %89 = phi i64 [ %114, %113 ], [ 0, %85 ]
  %90 = icmp slt i64 %89, 3
  br i1 %90, label %91, label %115

91:                                               ; preds = %94, %88
  %92 = phi i64 [ %112, %94 ], [ 0, %88 ]
  %93 = icmp slt i64 %92, 3
  br i1 %93, label %94, label %113

94:                                               ; preds = %91
  %95 = mul i64 %86, 3
  %96 = add i64 %95, %92
  %97 = getelementptr float, ptr %1, i64 %96
  %98 = load float, ptr %97, align 4
  %99 = mul i64 %92, 3
  %100 = add i64 %99, %89
  %101 = getelementptr float, ptr %8, i64 %100
  %102 = load float, ptr %101, align 4
  %103 = mul i64 %86, 3
  %104 = add i64 %103, %89
  %105 = getelementptr float, ptr %75, i64 %104
  %106 = load float, ptr %105, align 4
  %107 = fmul float %98, %102
  %108 = fadd float %106, %107
  %109 = mul i64 %86, 3
  %110 = add i64 %109, %89
  %111 = getelementptr float, ptr %75, i64 %110
  store float %108, ptr %111, align 4
  %112 = add i64 %92, 1
  br label %91

113:                                              ; preds = %91
  %114 = add i64 %89, 1
  br label %88

115:                                              ; preds = %88
  %116 = add i64 %86, 1
  br label %85

117:                                              ; preds = %85
  %118 = getelementptr float, ptr %75, i64 0
  %119 = getelementptr float, ptr %15, i64 %16
  call void @llvm.memcpy.p0.p0.i64(ptr %119, ptr %118, i64 mul (i64 ptrtoint (ptr getelementptr (float, ptr null, i32 1) to i64), i64 9), i1 false)
  ret void
}

; Function Attrs: nocallback nofree nounwind willreturn memory(argmem: readwrite)
declare void @llvm.memcpy.p0.p0.i64(ptr noalias nocapture writeonly, ptr noalias nocapture readonly, i64, i1 immarg) #0

attributes #0 = { nocallback nofree nounwind willreturn memory(argmem: readwrite) }

!llvm.module.flags = !{!0}

!0 = !{i32 2, !"Debug Info Version", i32 3}
