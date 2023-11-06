import torch
import torch_mlir
class ComplexMatMulModule(torch.nn.Module):
    def forward(self, a, b):
        return torch.add(a,b)
input_a = torch.tensor([[1 + 2j, 3 + 4j], [5 + 6j, 7 + 8j]])
input_b = torch.tensor([[9 + 10j, 11 + 12j], [13 + 14j, 15 + 16j]])

compiled = torch_mlir.compile(ComplexMatMulModule(), (input_a, input_b), output_type=torch_mlir.OutputType.LINALG_ON_TENSORS)
print(compiled)