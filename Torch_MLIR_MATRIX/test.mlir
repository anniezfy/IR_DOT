module attributes {torch.debug_module_name = "MatMulModule"} {
  func.func @forward(%arg0: memref<3x3xf32>, %arg1: memref<3x3xf32>, %arg2: memref<3x3xf32>) {
    %cst = arith.constant 0.000000e+00 : f32
    %alloc = memref.alloc() {alignment = 64 : i64} : memref<3x3xf32>
    affine.for %arg3 = 0 to 3 {
      affine.for %arg4 = 0 to 3 {
        affine.store %cst, %alloc[%arg3, %arg4] : memref<3x3xf32>
      }
    }
    %alloc_0 = memref.alloc() {alignment = 64 : i64} : memref<3x3xf32>
    memref.copy %alloc, %alloc_0 : memref<3x3xf32> to memref<3x3xf32>
    memref.dealloc %alloc : memref<3x3xf32>
    affine.for %arg3 = 0 to 3 {
      affine.for %arg4 = 0 to 3 {
        affine.for %arg5 = 0 to 3 {
          %0 = affine.load %arg0[%arg3, %arg5] : memref<3x3xf32>
          %1 = affine.load %arg1[%arg5, %arg4] : memref<3x3xf32>
          %2 = affine.load %alloc_0[%arg3, %arg4] : memref<3x3xf32>
          %3 = arith.mulf %0, %1 : f32
          %4 = arith.addf %2, %3 : f32
          affine.store %4, %alloc_0[%arg3, %arg4] : memref<3x3xf32>
        }
      }
    }
    memref.copy %alloc_0, %arg2 : memref<3x3xf32> to memref<3x3xf32>
    return
  }
}

