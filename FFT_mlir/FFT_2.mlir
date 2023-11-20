  func.func @FFT(%arg0: memref<?x2xf64>) -> i32 attributes {llvm.linkage = #llvm.linkage<external>} {
    %c33 = arith.constant 33 : index
    %c1 = arith.constant 1 : index
    %c-1_i32 = arith.constant -1 : i32
    %c0 = arith.constant 0 : index
    %c1024_i32 = arith.constant 1024 : i32
    %alloca = memref.alloca() : memref<1x2xf64>
    %alloca_0 = memref.alloca() : memref<1x2xf64>
    %cast = memref.cast %alloca_0 : memref<1x2xf64> to memref<?x2xf64>
    %cast_1 = memref.cast %alloca : memref<1x2xf64> to memref<?x2xf64>
    affine.for %arg1 = %c1 to %c33 step %c1 {
      %2 = arith.index_cast %arg1 : index to i32
      %3 = arith.muli %2, %2 : i32
      %4 = arith.divsi %c1024_i32, %3 : i32
      %5 = arith.addi %2, %c-1_i32 : i32
      %6 = arith.muli %5, %5 : i32
      %7 = arith.index_cast %6 : i32 to index
      %8 = arith.index_cast %4 : i32 to index
      affine.for %arg2 = %c0 to %8 step %c1 {
        %9 = arith.index_cast %arg2 : index to i32
        %10 = arith.muli %9, %2 : i32
        %11 = arith.muli %10, %2 : i32
        affine.for %arg3 = %c0 to %7 step %c1 {
          %12 = arith.index_cast %arg3 : index to i32
          %13 = arith.addi %11, %12 : i32
          %14 = arith.addi %13, %6 : i32
          func.call @w_func(%12, %3, %cast) : (i32, i32, memref<?x2xf64>) -> ()
          %15 = affine.load %alloca_0[0, 0] : memref<1x2xf64>
          affine.store %15, %alloca[0, 0] : memref<1x2xf64>
          %16 = affine.load %alloca_0[0, 1] : memref<1x2xf64>
          affine.store %16, %alloca[0, 1] : memref<1x2xf64>
          func.call @f_func(%arg0, %13, %14, %cast_1) : (memref<?x2xf64>, i32, i32, memref<?x2xf64>) -> ()
        }
      }
    }
    %0 = "polygeist.memref2pointer"(%arg0) : (memref<?x2xf64>) -> !llvm.ptr
    %1 = llvm.ptrtoint %0 : !llvm.ptr to i32
    return %1 : i32
  }
  func.func @f_func(%arg0: memref<?x2xf64>, %arg1: i32, %arg2: i32, %arg3: memref<?x2xf64>) attributes {llvm.linkage = #llvm.linkage<external>} {
    %cst = arith.constant -1.000000e+00 : f64
    %0 = arith.index_cast %arg1 : i32 to index
    %1 = arith.index_cast %arg2 : i32 to index
    %2 = affine.load %arg3[0, 0] : memref<?x2xf64>
    %3 = affine.load %arg3[0, 1] : memref<?x2xf64>
    %4 = affine.load %arg0[symbol(%1), 0] : memref<?x2xf64>
    %5 = affine.load %arg0[symbol(%1), 1] : memref<?x2xf64>
    %6 = arith.mulf %2, %4 : f64
    %7 = arith.mulf %3, %5 : f64
    %8 = arith.mulf %7, %cst : f64
    %9 = arith.addf %6, %8 : f64
    %10 = arith.mulf %2, %5 : f64
    %11 = arith.mulf %3, %4 : f64
    %12 = arith.addf %10, %11 : f64
    %13 = affine.load %arg0[symbol(%0), 0] : memref<?x2xf64>
    %14 = affine.load %arg0[symbol(%0), 1] : memref<?x2xf64>
    %15 = arith.addf %13, %9 : f64
    %16 = arith.addf %14, %12 : f64
    affine.store %15, %arg0[symbol(%0), 0] : memref<?x2xf64>
    affine.store %16, %arg0[symbol(%0), 1] : memref<?x2xf64>
    %17 = affine.load %arg3[0, 0] : memref<?x2xf64>
    %18 = affine.load %arg3[0, 1] : memref<?x2xf64>
    %19 = affine.load %arg0[symbol(%1), 0] : memref<?x2xf64>
    %20 = affine.load %arg0[symbol(%1), 1] : memref<?x2xf64>
    %21 = arith.mulf %17, %19 : f64
    %22 = arith.mulf %18, %20 : f64
    %23 = arith.mulf %22, %cst : f64
    %24 = arith.addf %21, %23 : f64
    %25 = arith.mulf %17, %20 : f64
    %26 = arith.mulf %18, %19 : f64
    %27 = arith.addf %25, %26 : f64
    %28 = arith.subf %13, %24 : f64
    %29 = arith.subf %14, %27 : f64
    affine.store %28, %arg0[symbol(%1), 0] : memref<?x2xf64>
    affine.store %29, %arg0[symbol(%1), 1] : memref<?x2xf64>
    return
  }
  func.func @w_func(%arg0: i32, %arg1: i32, %arg2: memref<?x2xf64>) attributes {llvm.linkage = #llvm.linkage<external>} {
    %cst = arith.constant -2.000000e+00 : f64
    %cst_0 = arith.constant -1.000000e+00 : f64
    %cst_1 = arith.constant 2.000000e+00 : f64
    %0 = call @acos(%cst_0) : (f64) -> f64
    %1 = arith.mulf %0, %cst_1 : f64
    %2 = arith.sitofp %arg0 : i32 to f64
    %3 = arith.mulf %1, %2 : f64
    %4 = arith.sitofp %arg1 : i32 to f64
    %5 = arith.divf %3, %4 : f64
    %6 = math.cos %5 : f64
    %7 = call @acos(%cst_0) : (f64) -> f64
    %8 = arith.mulf %7, %cst : f64
    %9 = arith.mulf %8, %2 : f64
    %10 = arith.divf %9, %4 : f64
    %11 = math.sin %10 : f64
    affine.store %6, %arg2[0, 0] : memref<?x2xf64>
    affine.store %11, %arg2[0, 1] : memref<?x2xf64>
    return
  }
  func.func @add(%arg0: memref<?x2xf64>, %arg1: memref<?x2xf64>, %arg2: memref<?x2xf64>) attributes {llvm.linkage = #llvm.linkage<external>} {
    %0 = affine.load %arg0[0, 0] : memref<?x2xf64>
    %1 = affine.load %arg1[0, 0] : memref<?x2xf64>
    %2 = arith.addf %0, %1 : f64
    %3 = affine.load %arg0[0, 1] : memref<?x2xf64>
    %4 = affine.load %arg1[0, 1] : memref<?x2xf64>
    %5 = arith.addf %3, %4 : f64
    affine.store %2, %arg2[0, 0] : memref<?x2xf64>
    affine.store %5, %arg2[0, 1] : memref<?x2xf64>
    return
  }
  func.func @mul(%arg0: memref<?x2xf64>, %arg1: memref<?x2xf64>, %arg2: memref<?x2xf64>) attributes {llvm.linkage = #llvm.linkage<external>} {
    %cst = arith.constant -1.000000e+00 : f64
    %0 = affine.load %arg0[0, 0] : memref<?x2xf64>
    %1 = affine.load %arg1[0, 0] : memref<?x2xf64>
    %2 = arith.mulf %0, %1 : f64
    %3 = affine.load %arg0[0, 1] : memref<?x2xf64>
    %4 = affine.load %arg1[0, 1] : memref<?x2xf64>
    %5 = arith.mulf %3, %4 : f64
    %6 = arith.mulf %5, %cst : f64
    %7 = arith.addf %2, %6 : f64
    %8 = arith.mulf %0, %4 : f64
    %9 = arith.mulf %3, %1 : f64
    %10 = arith.addf %8, %9 : f64
    affine.store %7, %arg2[0, 0] : memref<?x2xf64>
    affine.store %10, %arg2[0, 1] : memref<?x2xf64>
    return
  }
  func.func @sub(%arg0: memref<?x2xf64>, %arg1: memref<?x2xf64>, %arg2: memref<?x2xf64>) attributes {llvm.linkage = #llvm.linkage<external>} {
    %0 = affine.load %arg0[0, 0] : memref<?x2xf64>
    %1 = affine.load %arg1[0, 0] : memref<?x2xf64>
    %2 = arith.subf %0, %1 : f64
    %3 = affine.load %arg0[0, 1] : memref<?x2xf64>
    %4 = affine.load %arg1[0, 1] : memref<?x2xf64>
    %5 = arith.subf %3, %4 : f64
    affine.store %2, %arg2[0, 0] : memref<?x2xf64>
    affine.store %5, %arg2[0, 1] : memref<?x2xf64>
    return
  }
  func.func private @acos(f64) -> f64 attributes {llvm.linkage = #llvm.linkage<external>}

