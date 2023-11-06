forward:                                # @forward
        push    rbp
        push    r15
        push    r14
        push    r13
        push    r12
        push    rbx
        push    rax
        mov     rbx, rsi
        mov     r13, qword ptr [rsp + 136]
        mov     rbp, qword ptr [rsp + 80]
        mov     edi, 100
        call    malloc@PLT
        mov     r12, rax
        mov     r15, rax
        add     r15, 63
        and     r15, -64
        xor     eax, eax
        mov     rcx, r15
        jmp     .LBB0_1
.LBB0_5:                                #   in Loop: Header=BB0_1 Depth=1
        inc     rax
        add     rcx, 12
.LBB0_1:                                # =>This Loop Header: Depth=1
        cmp     rax, 2
        jg      .LBB0_6
        xor     edx, edx
        cmp     rdx, 2
        jg      .LBB0_5
.LBB0_4:                                #   Parent Loop BB0_1 Depth=1
        mov     dword ptr [rcx + 4*rdx], 0
        inc     rdx
        cmp     rdx, 2
        jle     .LBB0_4
        jmp     .LBB0_5
.LBB0_6:
        mov     edi, 100
        call    malloc@PLT
        mov     r14, rax
        add     r14, 63
        and     r14, -64
        mov     rax, qword ptr [r15]
        mov     rcx, qword ptr [r15 + 8]
        mov     qword ptr [r14], rax
        mov     qword ptr [r14 + 8], rcx
        mov     rax, qword ptr [r15 + 16]
        mov     qword ptr [r14 + 16], rax
        mov     rax, qword ptr [r15 + 24]
        mov     qword ptr [r14 + 24], rax
        mov     eax, dword ptr [r15 + 32]
        mov     dword ptr [r14 + 32], eax
        mov     rdi, r12
        call    free@PLT
        xor     eax, eax
        jmp     .LBB0_7
.LBB0_14:                               #   in Loop: Header=BB0_7 Depth=1
        inc     rax
        add     rbx, 12
.LBB0_7:                                # =>This Loop Header: Depth=1
        cmp     rax, 2
        jg      .LBB0_15
        mov     rcx, rbp
        xor     edx, edx
        jmp     .LBB0_9
.LBB0_13:                               #   in Loop: Header=BB0_9 Depth=2
        inc     rdx
        add     rcx, 4
.LBB0_9:                                #   Parent Loop BB0_7 Depth=1
        cmp     rdx, 2
        jg      .LBB0_14
        mov     rsi, rcx
        xor     edi, edi
        cmp     rdi, 2
        jg      .LBB0_13
.LBB0_12:                               #   Parent Loop BB0_7 Depth=1
        movss   xmm0, dword ptr [rbx + 4*rdi]   # xmm0 = mem[0],zero,zero,zero
        lea     r8, [rax + 2*rax]
        add     r8, rdx
        mulss   xmm0, dword ptr [rsi]
        addss   xmm0, dword ptr [r14 + 4*r8]
        movss   dword ptr [r14 + 4*r8], xmm0
        inc     rdi
        add     rsi, 12
        cmp     rdi, 2
        jle     .LBB0_12
        jmp     .LBB0_13
.LBB0_15:
        mov     eax, dword ptr [r14 + 32]
        mov     rdx, qword ptr [rsp + 144]
        mov     dword ptr [r13 + 4*rdx + 32], eax
        mov     rax, qword ptr [r14 + 24]
        mov     qword ptr [r13 + 4*rdx + 24], rax
        mov     rax, qword ptr [r14 + 16]
        mov     qword ptr [r13 + 4*rdx + 16], rax
        mov     rax, qword ptr [r14]
        mov     rcx, qword ptr [r14 + 8]
        mov     qword ptr [r13 + 4*rdx + 8], rcx
        mov     qword ptr [r13 + 4*rdx], rax
        add     rsp, 8
        pop     rbx
        pop     r12
        pop     r13
        pop     r14
        pop     r15
        pop     rbp
        ret