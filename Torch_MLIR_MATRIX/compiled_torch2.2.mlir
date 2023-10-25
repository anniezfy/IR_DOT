module attributes {torch.debug_module_name = "MatMulModule"} {
  ml_program.global private mutable @global_seed(dense<0> : tensor<i64>) : tensor<i64>
  func.func @forward(%arg0: tensor<3x3xf32>, %arg1: tensor<3x3xf32>) -> tensor<3x3xf32> {
    %cst = arith.constant 0.000000e+00 : f32
    %0 = tensor.empty() : tensor<3x3xf32>
    %1 = linalg.fill ins(%cst : f32) outs(%0 : tensor<3x3xf32>) -> tensor<3x3xf32>
    %2 = linalg.matmul ins(%arg0, %arg1 : tensor<3x3xf32>, tensor<3x3xf32>) outs(%1 : tensor<3x3xf32>) -> tensor<3x3xf32>
    return %2 : tensor<3x3xf32>
  }
}
