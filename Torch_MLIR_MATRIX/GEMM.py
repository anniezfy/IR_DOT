import torch
import torch_mlir
## mlir-opt compiled_torch2.2.mlir -empty-tensor-to-alloc-tensor -one-shot-bufferize -convert-linalg-to-affine-loops
class MatMulModule(torch.nn.Module):
    def forward(self, a, b):
        return torch.matmul(a, b)

# 创建两个 3x3 的矩阵作为输入
input_a = torch.ones(3, 3)
input_b = torch.ones(3, 3) * 2

# 编译模型
compiled = torch_mlir.compile(MatMulModule(), (input_a, input_b), output_type=torch_mlir.OutputType.LINALG_ON_TENSORS)

# 其中：
# MatMulModule() 是定义的矩阵乘法模型
# (input_a, input_b) 是示例输入，两个 3x3 的矩阵
# torch_mlir.OutputType.LINALG_ON_TENSORS 指定了输出类型

print(compiled)

# 将编译结果转为字符串（如果它不是字符串）
compiled_str = str(compiled)

# 写入到文件
with open("compiled_model.txt", "w") as f:
    f.write(compiled_str)
    