func.func @add_function(%arg0: f32, %arg1:f32) -> (f32) {
     %1= arith.addf %arg0, %arg1 : f32
     return %1:f32
}
