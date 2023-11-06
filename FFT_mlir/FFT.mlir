module attributes {dlti.dl_spec = #dlti.dl_spec<#dlti.dl_entry<f80, dense<128> : vector<2xi32>>, #dlti.dl_entry<i64, dense<64> : vector<2xi32>>, #dlti.dl_entry<!llvm.ptr, dense<64> : vector<4xi32>>, #dlti.dl_entry<i1, dense<8> : vector<2xi32>>, #dlti.dl_entry<i8, dense<8> : vector<2xi32>>, #dlti.dl_entry<i16, dense<16> : vector<2xi32>>, #dlti.dl_entry<i32, dense<32> : vector<2xi32>>, #dlti.dl_entry<f64, dense<64> : vector<2xi32>>, #dlti.dl_entry<f16, dense<16> : vector<2xi32>>, #dlti.dl_entry<!llvm.ptr<270>, dense<32> : vector<4xi32>>, #dlti.dl_entry<f128, dense<128> : vector<2xi32>>, #dlti.dl_entry<!llvm.ptr<271>, dense<32> : vector<4xi32>>, #dlti.dl_entry<!llvm.ptr<272>, dense<64> : vector<4xi32>>, #dlti.dl_entry<"dlti.stack_alignment", 128 : i32>, #dlti.dl_entry<"dlti.endianness", "little">>, llvm.data_layout = "e-m:e-p270:32:32-p271:32:32-p272:64:64-i64:64-f80:128-n8:16:32:64-S128", llvm.target_triple = "x86_64-unknown-linux-gnu", "polygeist.target-cpu" = "x86-64", "polygeist.target-features" = "+cmov,+cx8,+fxsr,+mmx,+sse,+sse2,+x87", "polygeist.tune-cpu" = "generic"} {
  func.func @FFT(%arg0: memref<?x2xf64>, %arg1: i32) -> i32 attributes {llvm.linkage = #llvm.linkage<external>} {
    %c0 = arith.constant 0 : index
    %c1 = arith.constant 1 : index
    %c-1_i32 = arith.constant -1 : i32
    %c1_i32 = arith.constant 1 : i32
    %c2_i32 = arith.constant 2 : i32
    %c0_i32 = arith.constant 0 : i32
    %alloca = memref.alloca() : memref<1x2xf64>
    %alloca_0 = memref.alloca() : memref<1x2xf64>
    %0 = llvm.mlir.undef : i32
    %alloca_1 = memref.alloca() : memref<10x2xf64>
    %1 = scf.while (%arg2 = %c0_i32) : (i32) -> i32 {
      %18 = arith.index_cast %arg2 : i32 to index
      %19 = scf.for %arg3 = %c0 to %18 step %c1 iter_args(%arg4 = %c1_i32) -> (i32) {
        %21 = arith.muli %arg4, %c2_i32 : i32
        scf.yield %21 : i32
      }
      %20 = arith.cmpi sgt, %arg1, %19 : i32
      scf.condition(%20) %arg2 : i32
    } do {
    ^bb0(%arg2: i32):
      %18 = arith.addi %arg2, %c1_i32 : i32
      scf.yield %18 : i32
    }
    %2 = arith.index_cast %1 : i32 to index
    %3 = scf.for %arg2 = %c0 to %2 step %c1 iter_args(%arg3 = %c1_i32) -> (i32) {
      %18 = arith.muli %arg3, %c2_i32 : i32
      scf.yield %18 : i32
    }
    %4 = arith.index_cast %3 : i32 to index
    %5 = arith.addi %1, %c-1_i32 : i32
    scf.for %arg2 = %c0 to %4 step %c1 {
      %18 = arith.index_cast %arg2 : index to i32
      %19:2 = scf.for %arg3 = %c0 to %2 step %c1 iter_args(%arg4 = %c0_i32, %arg5 = %18) -> (i32, i32) {
        %23 = arith.index_cast %arg3 : index to i32
        %24 = arith.andi %arg5, %c1_i32 : i32
        %25 = arith.shrsi %arg5, %c1_i32 : i32
        %26 = arith.subi %5, %23 : i32
        %27 = arith.index_cast %26 : i32 to index
        %28 = scf.for %arg6 = %c0 to %27 step %c1 iter_args(%arg7 = %c1_i32) -> (i32) {
          %31 = arith.muli %arg7, %c2_i32 : i32
          scf.yield %31 : i32
        }
        %29 = arith.muli %24, %28 : i32
        %30 = arith.addi %arg4, %29 : i32
        scf.yield %30, %25 : i32, i32
      }
      %20 = arith.index_cast %19#0 : i32 to index
      %21 = memref.load %arg0[%20, %c0] : memref<?x2xf64>
      memref.store %21, %alloca_1[%arg2, %c0] : memref<10x2xf64>
      %22 = memref.load %arg0[%20, %c1] : memref<?x2xf64>
      memref.store %22, %alloca_1[%arg2, %c1] : memref<10x2xf64>
    }
    %6 = arith.index_cast %0 : i32 to index
    %7 = scf.for %arg2 = %c0 to %6 step %c1 iter_args(%arg3 = %c1_i32) -> (i32) {
      %18 = arith.muli %arg3, %c2_i32 : i32
      scf.yield %18 : i32
    }
    %8 = arith.divsi %3, %7 : i32
    %9 = arith.addi %0, %c-1_i32 : i32
    %10 = arith.index_cast %9 : i32 to index
    %11 = scf.for %arg2 = %c0 to %10 step %c1 iter_args(%arg3 = %c1_i32) -> (i32) {
      %18 = arith.muli %arg3, %c2_i32 : i32
      scf.yield %18 : i32
    }
    %12 = arith.addi %1, %c1_i32 : i32
    %13 = arith.index_cast %12 : i32 to index
    %14 = arith.index_cast %8 : i32 to index
    %15 = arith.index_cast %11 : i32 to index
    %cast = memref.cast %alloca_1 : memref<10x2xf64> to memref<?x2xf64>
    %cast_2 = memref.cast %alloca_0 : memref<1x2xf64> to memref<?x2xf64>
    %cast_3 = memref.cast %alloca : memref<1x2xf64> to memref<?x2xf64>
    scf.for %arg2 = %c1 to %13 step %c1 {
      %18 = arith.index_cast %arg2 : index to i32
      %19 = scf.for %arg3 = %c0 to %arg2 step %c1 iter_args(%arg4 = %c1_i32) -> (i32) {
        %23 = arith.muli %arg4, %c2_i32 : i32
        scf.yield %23 : i32
      }
      %20 = arith.addi %18, %c-1_i32 : i32
      %21 = arith.index_cast %20 : i32 to index
      %22 = scf.for %arg3 = %c0 to %21 step %c1 iter_args(%arg4 = %c1_i32) -> (i32) {
        %23 = arith.muli %arg4, %c2_i32 : i32
        scf.yield %23 : i32
      }
      scf.for %arg3 = %c0 to %14 step %c1 {
        %23 = arith.index_cast %arg3 : index to i32
        %24 = arith.muli %23, %19 : i32
        scf.for %arg4 = %c0 to %15 step %c1 {
          %25 = arith.index_cast %arg4 : index to i32
          %26 = arith.addi %24, %25 : i32
          %27 = arith.addi %26, %22 : i32
          func.call @w(%25, %19, %cast_2) : (i32, i32, memref<?x2xf64>) -> ()
          %28 = affine.load %alloca_0[0, 0] : memref<1x2xf64>
          affine.store %28, %alloca[0, 0] : memref<1x2xf64>
          %29 = affine.load %alloca_0[0, 1] : memref<1x2xf64>
          affine.store %29, %alloca[0, 1] : memref<1x2xf64>
          func.call @f(%cast, %26, %27, %cast_3) : (memref<?x2xf64>, i32, i32, memref<?x2xf64>) -> ()
        }
      }
    }
    %16 = "polygeist.memref2pointer"(%alloca_1) : (memref<10x2xf64>) -> !llvm.ptr
    %17 = llvm.ptrtoint %16 : !llvm.ptr to i32
    return %17 : i32
  }
  func.func @mypow(%arg0: i32, %arg1: i32) -> i32 attributes {llvm.linkage = #llvm.linkage<external>} {
    %c0 = arith.constant 0 : index
    %c1 = arith.constant 1 : index
    %c1_i32 = arith.constant 1 : i32
    %0 = arith.index_cast %arg1 : i32 to index
    %1 = scf.for %arg2 = %c0 to %0 step %c1 iter_args(%arg3 = %c1_i32) -> (i32) {
      %2 = arith.muli %arg3, %arg0 : i32
      scf.yield %2 : i32
    }
    return %1 : i32
  }
  func.func @reverse(%arg0: i32, %arg1: i32) -> i32 attributes {llvm.linkage = #llvm.linkage<external>} {
    %c0 = arith.constant 0 : index
    %c1 = arith.constant 1 : index
    %c-1_i32 = arith.constant -1 : i32
    %c2_i32 = arith.constant 2 : i32
    %c1_i32 = arith.constant 1 : i32
    %c0_i32 = arith.constant 0 : i32
    %0 = arith.index_cast %arg1 : i32 to index
    %1 = arith.addi %arg1, %c-1_i32 : i32
    %2:2 = scf.for %arg2 = %c0 to %0 step %c1 iter_args(%arg3 = %c0_i32, %arg4 = %arg0) -> (i32, i32) {
      %3 = arith.index_cast %arg2 : index to i32
      %4 = arith.andi %arg4, %c1_i32 : i32
      %5 = arith.shrsi %arg4, %c1_i32 : i32
      %6 = arith.subi %1, %3 : i32
      %7 = arith.index_cast %6 : i32 to index
      %8 = scf.for %arg5 = %c0 to %7 step %c1 iter_args(%arg6 = %c1_i32) -> (i32) {
        %11 = arith.muli %arg6, %c2_i32 : i32
        scf.yield %11 : i32
      }
      %9 = arith.muli %4, %8 : i32
      %10 = arith.addi %arg3, %9 : i32
      scf.yield %10, %5 : i32, i32
    }
    return %2#0 : i32
  }
  func.func @f(%arg0: memref<?x2xf64>, %arg1: i32, %arg2: i32, %arg3: memref<?x2xf64>) attributes {llvm.linkage = #llvm.linkage<external>} {
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
  func.func @w(%arg0: i32, %arg1: i32, %arg2: memref<?x2xf64>) attributes {llvm.linkage = #llvm.linkage<external>} {
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
}
