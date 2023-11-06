llvm.func @atof(!llvm.ptr) -> f64 attributes {sym_visibility = "private"}
llvm.func @printf(!llvm.ptr, ...) -> i32 attributes {sym_visibility = "private"}

llvm.mlir.global @fmtstr("%f\n") : !llvm.array<3 x i8>

func.func @main(%argc : i32, %argv : !llvm.ptr) -> i32 {
  %ep1 = llvm.getelementptr %argv[1] : (!llvm.ptr) -> !llvm.ptr, !llvm.ptr
  %p1 = llvm.load %ep1 : !llvm.ptr -> !llvm.ptr
  %f1 = llvm.call @atof(%p1) : (!llvm.ptr) -> f64

  %ep2 = llvm.getelementptr %argv[2] : (!llvm.ptr) -> !llvm.ptr, !llvm.ptr
  %p2 = llvm.load %ep2 : !llvm.ptr -> !llvm.ptr
  %f2 = llvm.call @atof(%p2) : (!llvm.ptr) -> f64

  %r = arith.addf %f1, %f2 : f64

  %fmt = llvm.mlir.addressof @fmtstr : !llvm.ptr
  %rr = llvm.call @printf(%fmt, %r) vararg(!llvm.func<i32 (ptr, ...)>) : (!llvm.ptr, f64) -> i32

  return %rr : i32
}