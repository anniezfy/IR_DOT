import torch
import cmath
import math
import torch_mlir


class FFT(torch.nn.Module):

    def f(self, i, j, w, fft):
        t = fft[i]
        fft[i] = fft[i] + w * fft[j]
        fft[j] = t - w * fft[j]

    def w(self, m, N):
        return cmath.exp(2j * cmath.pi * m / N)

    def reverse(self, n, l):
        r = 0
        n1 = int(n)
        for i in range(int(l)):
            t = n1 & 1
            n1 >>= 1
            r += t * 2 ** (l - 1 - i)
        return r

    def forward(self, A, fft_t):

        N = 1
        p = 0
        while 4 > 2 ** p:
            p += 1
        N = 2 ** p



        for i in range(int(N)):
            t = self.reverse(i, p)
            fft_t[i] = A[t]

        for k in range(1, p + 1):
            for l in range(N // 2 ** k):
                for i in range(N // 2 ** (k - 1)):
                    self.f(l * 2 ** k + i, l * 2 ** k + i + 2 ** (k - 1), self.w(i, 2 ** k), fft_t)

        return fft_t


x = torch.tensor([0.0, 1.0, 0.0, 0.0], dtype=torch.complex64)
fft_t = torch.tensor([0j] * 100001, dtype=torch.complex64)

compiled = torch_mlir.compile(FFT(), (x, fft_t), output_type=torch_mlir.OutputType.LINALG_ON_TENSORS)
print(compiled)