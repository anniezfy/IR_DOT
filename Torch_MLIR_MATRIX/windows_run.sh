
#Export the mlir-opt tool under the llvm build directory
export PATH=$PWD:"/Users/anniezfy/llvm-project-mine/build/bin"

# use mlir-opt to compile the torch2.2.mlir file
mlir-opt compiled_torch2.2.mlir --canonicalize -convert-tensor-to-linalg -empty-tensor-to-alloc-tensor -eliminate-empty-tensors -linalg-bufferize -arith-bufferize   -tensor-bufferize -func-bufferize -finalizing-bufferize -buffer-deallocation   --buffer-results-to-out-params   --canonicalize -cse -convert-linalg-to-affine-loops > matrix_mulitiplication_2.2.mlir


# use mlir-opt --affine-loop-unroll and -test-lower-to-llvm options
# some tips about the options:Most useful linalg transforms, other than unrolling,
# should happen before bufferization. And using the one-shot bufferization is the recommended path.
#mlir-opt matrix_mulitiplication_affine_2.2.mlir --affine-loop-unroll="unroll-full" \
#--affine-loop-unroll="unroll-full" --affine-loop-unroll="unroll-full" \
#-convert-arith-to-llvm -test-lower-to-llvm


OVERVIEW: MLIR modular optimizer driver

Available Dialects: acc, affine, amdgpu, amx, arith, arm_neon, arm_sme, arm_sve, async, bufferization, builtin, cf, complex, dlti, emitc, func, gpu, index, irdl, linalg, llvm, math, memref, ml_program, nvgpu, nvvm, omp, pdl, pdl_interp, quant, rocdl, scf, shape, sparse_tensor, spirv, tensor, test, test_dyn, tosa, transform, ub, vector, x86vector
USAGE: mlir-opt.exe [options] <input file>

OPTIONS:

Color Options:

  --color                                                     - Use colors in output (default=autodetect)

General options:

  --abort-on-max-devirt-iterations-reached                    - Abort when the max iterations for devirtualization CGSCC repeat pass is reached
  --allow-unregistered-dialect                                - Allow operation with no registered dialects
  --atomic-counter-update-promoted                            - Do counter update using atomic fetch add  for promoted counters only
  --atomic-first-counter                                      - Use atomic fetch add for first counter in a function (usually the entry counter)
  --bounds-checking-single-trap                               - Use one trap block per function
  --bounds-checking-unique-traps                              - Always use one trap per check
  --cfg-hide-cold-paths=<number>                              - Hide blocks with relative frequency below the given value
  --cfg-hide-deoptimize-paths                                 -
  --cfg-hide-unreachable-paths                                -
  --cost-kind=<value>                                         - Target cost kind
    =throughput                                               -   Reciprocal throughput
    =latency                                                  -   Instruction latency
    =code-size                                                -   Code size
    =size-latency                                             -   Code size and latency
  --debug-info-correlate                                      - Use debug info to correlate profiles.
  --debugify-func-limit=<ulong>                               - Set max number of processed functions per pass.
  --debugify-level=<value>                                    - Kind of debug info to add
    =locations                                                -   Locations only
    =location+variables                                       -   Locations and Variables
  --debugify-quiet                                            - Suppress verbose debugify output
  --disable-auto-upgrade-debug-info                           - Disable autoupgrade of debug info
  --disable-i2p-p2i-opt                                       - Disables inttoptr/ptrtoint roundtrip optimization
  --do-counter-promotion                                      - Do counter register promotion
  --dot-cfg-mssa=<file name for generated dot file>           - file name for generated dot file
  --dump-pass-pipeline                                        - Print the pipeline that will be run
  --emit-bytecode                                             - Emit bytecode when generating output
  --emit-bytecode-version=<value>                             - Use specified bytecode when generating output
  --enable-gvn-hoist                                          - Enable the GVN hoisting pass (default = off)
  --enable-gvn-memdep                                         -
  --enable-gvn-sink                                           - Enable the GVN sinking pass (default = off)
  --enable-load-in-loop-pre                                   -
  --enable-load-pre                                           -
  --enable-loop-simplifycfg-term-folding                      -
  --enable-name-compression                                   - Enable name/filename string compression
  --enable-split-backedge-in-load-pre                         -
  --experimental-debug-variable-locations                     - Use experimental new value-tracking variable locations
  --force-tail-folding-style=<value>                          - Force the tail folding style
    =none                                                     -   Disable tail folding
    =data                                                     -   Create lane mask for data only, using active.lane.mask intrinsic
    =data-without-lane-mask                                   -   Create lane mask with compare/stepvector
    =data-and-control                                         -   Create lane mask using active.lane.mask intrinsic, and use it for both data and control flow
    =data-and-control-without-rt-check                        -   Similar to data-and-control, but remove the runtime check
  --fs-profile-debug-bw-threshold=<uint>                      - Only show debug message if the source branch weight is greater  than this value.
  --fs-profile-debug-prob-diff-threshold=<uint>               - Only show debug message if the branch probility is greater than this value (in percentage).
  --generate-merged-base-profiles                             - When generating nested context-sensitive profiles, always generate extra base profile for function with all its context profiles merged into it.
  --hash-based-counter-split                                  - Rename counter variable of a comdat function based on cfg hash
  --hot-cold-split                                            - Enable hot-cold splitting pass
  --import-all-index                                          - Import all external functions in index.
  --instcombine-code-sinking                                  - Enable code sinking
  --instcombine-guard-widening-window=<uint>                  - How wide an instruction window to bypass looking for another guard
  --instcombine-max-num-phis=<uint>                           - Maximum number phis to handle in intptr/ptrint folding
  --instcombine-max-sink-users=<uint>                         - Maximum number of undroppable users for instruction sinking
  --instcombine-maxarray-size=<uint>                          - Maximum array size considered when doing a combine
  --instcombine-negator-enabled                               - Should we attempt to sink negations?
  --instcombine-negator-max-depth=<uint>                      - What is the maximal lookup depth when trying to check for viability of negation sinking.
  --instrprof-atomic-counter-update-all                       - Make all profile counter updates atomic (for testing only)
  --internalize-public-api-file=<filename>                    - A file containing list of symbol names to preserve
  --internalize-public-api-list=<list>                        - A list of symbol names to preserve
  --irdl-file=<filename>                                      - IRDL file to register before processing the input
  --iterative-counter-promotion                               - Allow counter promotion across the whole loop nest.
  --load-dialect-plugin=<string>                              - Load dialects from plugin library
  --load-pass-plugin=<string>                                 - Load passes from plugin library
  --log-actions-to=<string>                                   - Log action execution to a file, or stderr if  '-' is passed
  --log-mlir-actions-filter=<string>                          - Comma separated list of locations to filter actions from logging
  --matrix-default-layout=<value>                             - Sets the default matrix layout
    =column-major                                             -   Use column-major layout
    =row-major                                                -   Use row-major layout
  --matrix-print-after-transpose-opt                          -
  --max-counter-promotions=<int>                              - Max number of allowed counter promotions
  --max-counter-promotions-per-loop=<uint>                    - Max number counter promotions per loop to avoid increasing register pressure too much
  --mir-strip-debugify-only                                   - Should mir-strip-debug only strip debug info from debugified modules by default
  --misexpect-tolerance=<uint>                                - Prevents emiting diagnostics when profile counts are within N% of the threshold..
  --mlir-debug-counter=<string>                               - Comma separated list of debug counter skip and count arguments
  --mlir-disable-threading                                    - Disable multi-threading within MLIR, overrides any further call to MLIRContext::enableMultiThreading()
  --mlir-elide-elementsattrs-if-larger=<uint>                 - Elide ElementsAttrs with "..." that have more elements than the given upper limit
  --mlir-elide-resource-strings-if-larger=<uint>              - Elide printing value of resources if string is too long in chars.
  --mlir-enable-debugger-hook                                 - Enable Debugger hook for debugging MLIR Actions
  --mlir-pass-pipeline-crash-reproducer=<string>              - Generate a .mlir reproducer file at the given output path if the pass manager crashes or fails
  --mlir-pass-pipeline-local-reproducer                       - When generating a crash reproducer, attempt to generated a reproducer with the smallest pipeline.
  --mlir-pass-statistics                                      - Display the statistics of each pass
  --mlir-pass-statistics-display=<value>                      - Display method for pass statistics
    =list                                                     -   display the results in a merged list sorted by pass name
    =pipeline                                                 -   display the results with a nested pipeline view
  --mlir-pretty-debuginfo                                     - Print pretty debug info in MLIR output
  --mlir-print-debug-counter                                  - Print out debug counter information after all counters have been accumulated
  --mlir-print-debuginfo                                      - Print debug info in MLIR output
  --mlir-print-elementsattrs-with-hex-if-larger=<long>        - Print DenseElementsAttrs with a hex string that have more elements than the given upper limit (use -1 to disable)
  --mlir-print-ir-after=<pass-arg>                            - Print IR after specified passes
  --mlir-print-ir-after-all                                   - Print IR after each pass
  --mlir-print-ir-after-change                                - When printing the IR after a pass, only print if the IR changed
  --mlir-print-ir-after-failure                               - When printing the IR after a pass, only print if the pass failed
  --mlir-print-ir-before=<pass-arg>                           - Print IR before specified passes
  --mlir-print-ir-before-all                                  - Print IR before each pass
  --mlir-print-ir-module-scope                                - When printing IR for print-ir-[before|after]{-all} always print the top-level operation
  --mlir-print-local-scope                                    - Print with local scope and inline information (eliding aliases for attributes, types, and locations
  --mlir-print-op-on-diagnostic                               - When a diagnostic is emitted on an operation, also print the operation as an attached note
  --mlir-print-stacktrace-on-diagnostic                       - When a diagnostic is emitted, also print the stack trace as an attached note
  --mlir-print-value-users                                    - Print users of operation results and block arguments as a comment
  --mlir-timing                                               - Display execution times
  --mlir-timing-display=<value>                               - Display method for timing data
    =list                                                     -   display the results in a list sorted by total time
    =tree                                                     -   display the results ina with a nested tree view
  --no-discriminators                                         - Disable generation of discriminator information.
  --no-implicit-module                                        - Disable implicit addition of a top-level module op during parsing
  -o <filename>                                               - Output filename
  --object-size-offset-visitor-max-visit-instructions=<uint>  - Maximum number of instructions for ObjectSizeOffsetVisitor to look at
  --pass-pipeline=<string>                                    - Textual description of the pass pipeline to run
  --pgo-block-coverage                                        - Use this option to enable basic block coverage instrumentation
  --pgo-temporal-instrumentation                              - Use this option to enable temporal instrumentation
  --pgo-view-block-coverage-graph                             - Create a dot file of CFGs with block coverage inference information
  --poison-checking-function-local                            - Check that returns are non-poison (for testing)
  --print-pipeline-passes                                     - Print a '-passes' compatible string describing the pipeline (best-effort only).
  --profile-actions-to=<string>                               - Profile action execution to a file, or stderr if  '-' is passed
  --run-reproducer                                            - Run the pipeline stored in the reproducer
  --runtime-counter-relocation                                - Enable relocating counters at runtime.
  --safepoint-ir-verifier-print-only                          -
  --sample-profile-check-record-coverage=<N>                  - Emit a warning if less than N% of records in the input profile are matched to the IR.
  --sample-profile-check-sample-coverage=<N>                  - Emit a warning if less than N% of samples in the input profile are matched to the IR.
  --sample-profile-max-propagate-iterations=<uint>            - Maximum number of iterations to go through when propagating sample block/edge weights through the CFG.
  --show-dialects                                             - Print the list of registered dialects and exit
  --skip-ret-exit-block                                       - Suppress counter promotion if exit blocks contain ret.
  --speculative-counter-promotion-max-exiting=<uint>          - The max number of exiting blocks of a loop to allow  speculative counter promotion
  --speculative-counter-promotion-to-loop                     - When the option is false, if the target block is in a loop, the promotion will be disallowed unless the promoted counter  update can be further/iteratively promoted into an acyclic  region.
  --split-input-file                                          - Split the input file into pieces and process each chunk independently
  --summary-file=<string>                                     - The summary file to use for function importing.
  Compiler passes to run
    Passes:
      --affine-data-copy-generate                             -   Generate explicit copying for affine memory operations
        --fast-mem-capacity=<ulong>                           - Set fast memory space capacity in KiB (default: unlimited)
        --fast-mem-space=<uint>                               - Fast memory space identifier for copy generation (default: 1)
        --generate-dma                                        - Generate DMA instead of point-wise copy
        --min-dma-transfer=<int>                              - Minimum DMA transfer size supported by the target in bytes
        --skip-non-unit-stride-loops                          - Testing purposes: avoid non-unit stride loop choice depths for copy placement
        --slow-mem-space=<uint>                               - Slow memory space identifier for copy generation (default: 0)
        --tag-mem-space=<uint>                                - Tag memory space identifier for copy generation (default: 0)
      --affine-expand-index-ops                               -   Lower affine operations operating on indices into more fundamental operations
      --affine-loop-coalescing                                -   Coalesce nested loops with independent bounds into a single loop
      --affine-loop-fusion                                    -   Fuse affine loop nests
        --fusion-compute-tolerance=<number>                   - Fractional increase in additional computation tolerated while fusing
        --fusion-fast-mem-space=<uint>                        - Faster memory space number to promote fusion buffers to
        --fusion-local-buf-threshold=<ulong>                  - Threshold size (KiB) for promoting local buffers to fast memory space
        --fusion-maximal                                      - Enables maximal loop fusion
        --mode=<value>                                        - fusion mode to attempt
    =greedy                                             -   Perform greedy (both producer-consumer and sibling)  fusion
    =producer                                           -   Perform only producer-consumer fusion
    =sibling                                            -   Perform only sibling fusion
      --affine-loop-invariant-code-motion                     -   Hoist loop invariant instructions outside of affine loops
      --affine-loop-normalize                                 -   Apply normalization transformations to affine loop-like ops
        --promote-single-iter                                 - Promote single iteration loops
      --affine-loop-tile                                      -   Tile affine loop nests
        --cache-size=<ulong>                                  - Set size of cache to tile for in KiB (default: 512)
        --separate                                            - Separate full and partial tiles (default: false)
        --tile-size=<uint>                                    - Use this tile size for all loops
        --tile-sizes=<uint>                                   - List of tile sizes for each perfect nest (overridden by -tile-size)
      --affine-loop-unroll                                    -   Unroll affine loops
        --cleanup-unroll                                      - Fully unroll the cleanup loop when possible.
        --unroll-factor=<uint>                                - Use this unroll factor for all loops being unrolled
        --unroll-full                                         - Fully unroll loops
        --unroll-full-threshold=<uint>                        - Unroll all loops with trip count less than or equal to this
        --unroll-num-reps=<uint>                              - Unroll innermost loops repeatedly this many times
        --unroll-up-to-factor                                 - Allow unrolling up to the factor specified
      --affine-loop-unroll-jam                                -   Unroll and jam affine loops
        --unroll-jam-factor=<uint>                            - Use this unroll jam factor for all loops (default 4)
      --affine-parallelize                                    -   Convert affine.for ops into 1-D affine.parallel
        --max-nested=<uint>                                   - Maximum number of nested parallel loops to produce. Defaults to unlimited (UINT_MAX).
        --parallel-reductions                                 - Whether to parallelize reduction loops. Defaults to false.
      --affine-pipeline-data-transfer                         -   Pipeline non-blocking data transfers between explicitly managed levels of the memory hierarchy
      --affine-scalrep                                        -   Replace affine memref accesses by scalars by forwarding stores to loads and eliminating redundant loads
      --affine-simplify-structures                            -   Simplify affine expressions in maps/sets and normalize memrefs
      --affine-super-vectorize                                -   Vectorize to a target independent n-D vector abstraction
        --test-fastest-varying=<long>                         - Specify a 1-D, 2-D or 3-D pattern of fastest varying memory dimensions to match. See defaultPatterns in Vectorize.cpp for a description and examples. This is used for testing purposes
        --vectorize-reductions                                - Vectorize known reductions expressed via iter_args. Switched off by default.
        --virtual-vector-size=<long>                          - Specify an n-D virtual vector size for vectorization. This must be greater than zero.
      --affine-super-vectorizer-test                          -   Tests vectorizer standalone functionality.
      --allocate-arm-sme-tiles                                -   Allocate SME tiles
      --amdgpu-emulate-atomics                                -   Emulate atomic operations on chipsets that do not support them
        --chipset=<string>                                    - Chipset that these operations will run on
      --arith-bufferize                                       -   Bufferize Arith dialect ops.
        --alignment=<uint>                                    - Create global memrefs with a specified alignment
      --arith-emulate-unsupported-floats                      -   Emulate operations on unsupported floats with extf/truncf
        --source-types=<string>                               - MLIR types without arithmetic support on a given target
        --target-type=<string>                                - MLIR type to convert the unsupported source types to
      --arith-emulate-wide-int                                -   Emulate 2*N-bit integer operations using N-bit operations
        --widest-int-supported=<uint>                         - Widest integer type supported by the target
      --arith-expand                                          -   Legalize Arith ops to be convertible to LLVM.
        --include-bf16                                        - Enable the BF16 expansion patterns
      --arith-int-narrowing                                   -   Reduce integer operation bitwidth
        --int-bitwidths-supported=<uint>                      - Integer bitwidths supported
      --arith-unsigned-when-equivalent                        -   Replace signed ops with unsigned ones where they are proven equivalent
      --arm-neon-2d-to-intr                                   -   Convert Arm NEON structured ops to intrinsics
      --async-func-to-async-runtime                           -   Lower async.func operations to the explicit async.runtime andasync.coro operations
      --async-parallel-for                                    -   Convert scf.parallel operations to multiple async compute ops executed concurrently for non-overlapping iteration ranges
        --async-dispatch                                      - Dispatch async compute tasks using recursive work splitting. If `false` async compute tasks will be launched using simple for loop in the caller thread.
        --min-task-size=<int>                                 - The minimum task size for sharding parallel operation.
        --num-workers=<int>                                   - The number of available workers to execute async operations. If `-1` the value will be retrieved from the runtime.
      --async-runtime-policy-based-ref-counting               -   Policy based reference counting for Async runtime operations
      --async-runtime-ref-counting                            -   Automatic reference counting for Async runtime operations
      --async-runtime-ref-counting-opt                        -   Optimize automatic reference counting operations for theAsync runtime by removing redundant operations
      --async-to-async-runtime                                -   Lower all high level async operations (e.g. async.execute) tothe explicit async.runtime and async.coro operations
      --buffer-deallocation                                   -   Adds all required dealloc operations for all allocations in the input program
      --buffer-deallocation-simplification                    -   Optimizes `bufferization.dealloc` operation for more efficient codegen
      --buffer-hoisting                                       -   Optimizes placement of allocation operations by moving them into common dominators and out of nested regions
      --buffer-loop-hoisting                                  -   Optimizes placement of allocation operations by moving them out of loop nests
      --buffer-results-to-out-params                          -   Converts memref-typed function results to out-params
      --bufferization-bufferize                               -   Bufferize the `bufferization` dialect
      --bufferization-lower-deallocations                     -   Lowers `bufferization.dealloc` operations to `memref.dealloc`operations
      --canonicalize                                          -   Canonicalize operations
        --disable-patterns=<string>                           - Labels of patterns that should be filtered out during application
        --enable-patterns=<string>                            - Labels of patterns that should be used during application, all other patterns are filtered out
        --max-iterations=<long>                               - Max. iterations between applying patterns / simplifying regions
        --max-num-rewrites=<long>                             - Max. number of pattern rewrites within an iteration
        --region-simplify                                     - Perform control flow optimizations to the region tree
        --test-convergence                                    - Test only: Fail pass on non-convergence to detect cyclic pattern
        --top-down                                            - Seed the worklist in general top-down order
      --control-flow-sink                                     -   Sink operations into conditional blocks
      --convert-affine-for-to-gpu                             -   Convert top-level AffineFor Ops to GPU kernels
        --gpu-block-dims=<uint>                               - Number of GPU block dimensions for mapping
        --gpu-thread-dims=<uint>                              - Number of GPU thread dimensions for mapping
      --convert-amdgpu-to-rocdl                               -   Convert AMDGPU dialect to ROCDL dialect
        --chipset=<string>                                    - Chipset that these operations will run on
      --convert-arith-to-amdgpu                               -   Convert Arith operations to AMDGPU-specific implementations
      --convert-arith-to-llvm                                 -   Convert Arith dialect to LLVM dialect
        --index-bitwidth=<uint>                               - Bitwidth of the index type, 0 to use size of machine word
      --convert-arith-to-spirv                                -   Convert Arith dialect to SPIR-V dialect
        --emulate-lt-32-bit-scalar-types                      - Emulate narrower scalar types with 32-bit ones if not supported by the target
        --enable-fast-math                                    - Enable fast math mode (assuming no NaN and infinity for floating point values) when performing conversion
      --convert-arm-sme-to-scf                                -   Lower the operations from the ArmSME dialect into the SCF dialect
      --convert-async-to-llvm                                 -   Convert the operations from the async dialect into the LLVM dialect
        --use-opaque-pointers                                 - Generate LLVM IR using opaque pointers instead of typed pointers
      --convert-bufferization-to-memref                       -   Convert operations from the Bufferization dialect to the MemRef dialect
      --convert-cf-to-llvm                                    -   Convert ControlFlow operations to the LLVM dialect
        --index-bitwidth=<uint>                               - Bitwidth of the index type, 0 to use size of machine word
        --use-opaque-pointers                                 - Generate LLVM IR using opaque pointers instead of typed pointers
      --convert-cf-to-spirv                                   -   Convert ControlFlow dialect to SPIR-V dialect
        --emulate-lt-32-bit-scalar-types                      - Emulate narrower scalar types with 32-bit ones if not supported by the target
      --convert-complex-to-libm                               -   Convert Complex dialect to libm calls
      --convert-complex-to-llvm                               -   Convert Complex dialect to LLVM dialect
      --convert-complex-to-spirv                              -   Convert Complex dialect to SPIRV dialect
      --convert-complex-to-standard                           -   Convert Complex dialect to standard dialect
      --convert-elementwise-to-linalg                         -   Convert ElementwiseMappable ops to linalg
      --convert-func-to-llvm                                  -   Convert from the Func dialect to the LLVM dialect
        --index-bitwidth=<uint>                               - Bitwidth of the index type, 0 to use size of machine word
        --use-bare-ptr-memref-call-conv                       - Replace FuncOp's MemRef arguments with bare pointers to the MemRef element types
        --use-opaque-pointers                                 - Generate LLVM IR using opaque pointers instead of typed pointers
      --convert-func-to-spirv                                 -   Convert Func dialect to SPIR-V dialect
        --emulate-lt-32-bit-scalar-types                      - Emulate narrower scalar types with 32-bit ones if not supported by the target
      --convert-gpu-launch-to-vulkan-launch                   -   Convert gpu.launch_func to vulkanLaunch external call
      --convert-gpu-to-nvvm                                   -   Generate NVVM operations for gpu operations
        --has-redux                                           - Target gpu supports redux
        --index-bitwidth=<uint>                               - Bitwidth of the index type, 0 to use size of machine word
        --use-bare-ptr-memref-call-conv                       - Replace memref arguments in GPU functions with bare pointers. All memrefs must have static shape.
        --use-opaque-pointers                                 - Generate LLVM IR using opaque pointers instead of typed pointers
      --convert-gpu-to-rocdl                                  -   Generate ROCDL operations for gpu operations
        --chipset=<string>                                    - Chipset that these operations will run on
        --index-bitwidth=<uint>                               - Bitwidth of the index type, 0 to use size of machine word
        --runtime=<value>                                     - Runtime code will be run on (default is Unknown, can also use HIP or OpenCl)
    =unknown                                            -   Unknown (default)
    =HIP                                                -   HIP
    =OpenCL                                             -   OpenCL
        --use-bare-ptr-memref-call-conv                       - Replace memref arguments in GPU functions with bare pointers.All memrefs must have static shape
        --use-opaque-pointers                                 - Generate LLVM IR using opaque pointers instead of typed pointers
      --convert-gpu-to-spirv                                  -   Convert GPU dialect to SPIR-V dialect
        --use-64bit-index                                     - Use 64-bit integers to convert index types
        --use-coop-matrix-nv                                  - Use the NV cooperative matrix extension insted of the KHR extension to lower GPU WMMA ops
      --convert-index-to-llvm                                 -   Lower the `index` dialect to the `llvm` dialect.
        --index-bitwidth=<uint>                               - Bitwidth of the index type, 0 to use size of machine word
      --convert-linalg-to-affine-loops                        -   Lower the operations from the linalg dialect into affine loops
      --convert-linalg-to-loops                               -   Lower the operations from the linalg dialect into loops
      --convert-linalg-to-parallel-loops                      -   Lower the operations from the linalg dialect into parallel loops
      --convert-linalg-to-std                                 -   Convert the operations from the linalg dialect into the Standard dialect
      --convert-math-to-funcs                                 -   Convert Math operations to calls of outlined implementations.
        --convert-ctlz                                        - Convert math.ctlz to a software implementation. Enable for targets that do not natively support ctlz.
        --min-width-of-fpowi-exponent=<uint>                  - Convert FPowI only if the width of its exponent's integer type is greater than or equal to this value
      --convert-math-to-libm                                  -   Convert Math dialect to libm calls
      --convert-math-to-llvm                                  -   Convert Math dialect to LLVM dialect
        --approximate-log1p                                   - Enable approximation of Log1p.
      --convert-math-to-spirv                                 -   Convert Math dialect to SPIR-V dialect
      --convert-memref-to-spirv                               -   Convert MemRef dialect to SPIR-V dialect
        --bool-num-bits=<int>                                 - The number of bits to store a boolean value
        --use-64bit-index                                     - Use 64-bit integers to convert index types
      --convert-nvgpu-to-nvvm                                 -   Convert NVGPU dialect to NVVM dialect
        --use-opaque-pointers                                 - Generate LLVM IR using opaque pointers instead of typed pointers
      --convert-nvvm-to-llvm                                  -   Convert NVVM dialect to LLVM dialect
      --convert-openacc-to-scf                                -   Convert the OpenACC ops to OpenACC with SCF dialect
      --convert-openmp-to-llvm                                -   Convert the OpenMP ops to OpenMP ops with LLVM dialect
      --convert-parallel-loops-to-gpu                         -   Convert mapped scf.parallel ops to gpu launch operations
      --convert-pdl-to-pdl-interp                             -   Convert PDL ops to PDL interpreter ops
      --convert-scf-to-cf                                     -   Convert SCF dialect to ControlFlow dialect, replacing structured control flow with a CFG
      --convert-scf-to-emitc                                  -   Convert SCF dialect to EmitC dialect, maintaining structured control flow
      --convert-scf-to-openmp                                 -   Convert SCF parallel loop to OpenMP parallel + workshare constructs.
        --use-opaque-pointers                                 - Generate LLVM IR using opaque pointers instead of typed pointers
      --convert-scf-to-spirv                                  -   Convert SCF dialect to SPIR-V dialect.
      --convert-shape-constraints                             -   Convert shape constraint operations to the standard dialect
      --convert-shape-to-std                                  -   Convert operations from the shape dialect into the standard dialect
      --convert-spirv-to-llvm                                 -   Convert SPIR-V dialect to LLVM dialect
        --client-api=<value>                                  - Derive StorageClass to address space mapping from the client API
    =Unknown                                            -   Unknown (default)
    =Metal                                              -   Metal
    =OpenCL                                             -   OpenCL
    =Vulkan                                             -   Vulkan
    =WebGPU                                             -   WebGPU
        --use-opaque-pointers                                 - Generate LLVM IR using opaque pointers instead of typed pointers
      --convert-tensor-to-linalg                              -   Convert some Tensor dialect ops to Linalg dialect
      --convert-tensor-to-spirv                               -   Convert Tensor dialect to SPIR-V dialect
        --emulate-lt-32-bit-scalar-types                      - Emulate narrower scalar types with 32-bit ones if not supported by the target
      --convert-to-llvm                                       -   Convert to LLVM via dialect interfaces found in the input IR
        --filter-dialects=<string>                            - Test conversion patterns of only the specified dialects
      --convert-ub-to-llvm                                    -   Convert UB dialect to LLVM dialect
        --index-bitwidth=<uint>                               - Bitwidth of the index type, 0 to use size of machine word
      --convert-ub-to-spirv                                   -   Convert UB dialect to SPIR-V dialect
      --convert-vector-to-arm-sme                             -   Lower the operations from the vector dialect into the ArmSME dialect
      --convert-vector-to-gpu                                 -   Lower the operations from the vector dialect into the GPU dialect
        --use-nvgpu                                           - convert to NvGPU ops instead of GPU dialect ops
      --convert-vector-to-llvm                                -   Lower the operations from the vector dialect into the LLVM dialect
        --enable-amx                                          - Enables the use of AMX dialect while lowering the vector dialect.
        --enable-arm-neon                                     - Enables the use of ArmNeon dialect while lowering the vector dialect.
        --enable-arm-sme                                      - Enables the use of ArmSME dialect while lowering the vector dialect.
        --enable-arm-sve                                      - Enables the use of ArmSVE dialect while lowering the vector dialect.
        --enable-x86vector                                    - Enables the use of X86Vector dialect while lowering the vector dialect.
        --force-32bit-vector-indices                          - Allows compiler to assume vector indices fit in 32-bit if that yields faster code
        --reassociate-fp-reductions                           - Allows llvm to reassociate floating-point reductions for speed
        --use-opaque-pointers                                 - Generate LLVM IR using opaque pointers instead of typed pointers
      --convert-vector-to-scf                                 -   Lower the operations from the vector dialect into the SCF dialect
        --full-unroll                                         - Perform full unrolling when converting vector transfers to SCF
        --lower-tensors                                       - Lower transfer ops that operate on tensors
        --target-rank=<uint>                                  - Target vector rank to which transfer ops should be lowered
      --convert-vector-to-spirv                               -   Convert Vector dialect to SPIR-V dialect
      --cse                                                   -   Eliminate common sub-expressions
      --decorate-spirv-composite-type-layout                  -   Decorate SPIR-V composite type with layout info
      --drop-equivalent-buffer-results                        -   Remove MemRef return values that are equivalent to a bbArg
      --duplicate-function-elimination                        -   Deduplicate functions
      --eliminate-empty-tensors                               -   Try to eliminate all tensor.empty ops.
      --empty-tensor-to-alloc-tensor                          -   Replace all empty ops by alloc_tensor ops.
      --enable-arm-streaming                                  -   Enable Armv9 Streaming SVE mode
        --enable-za                                           - Enable ZA storage array.
        --mode=<value>                                        - Select how streaming-mode is managed at the function-level.
    =default                                            -   Streaming mode is part of the function interface (ABI), caller manages PSTATE.SM on entry/exit.
    =locally                                            -   Streaming mode is internal to the function, callee manages PSTATE.SM on entry/exit.
      --ensure-debug-info-scope-on-llvm-func                  -   Materialize LLVM debug info subprogram attribute on every LLVMFuncOp
      --expand-realloc                                        -   Expand memref.realloc operations into its components
        --emit-deallocs                                       - Emit deallocation operations for the original MemRef
      --expand-strided-metadata                               -   Expand memref operations into easier to analyze constructs
      --finalize-memref-to-llvm                               -   Finalize MemRef dialect to LLVM dialect conversion
        --index-bitwidth=<uint>                               - Bitwidth of the index type, 0 to use size of machine word
        --use-aligned-alloc                                   - Use aligned_alloc in place of malloc for heap allocations
        --use-generic-functions                               - Use generic allocation and deallocation functions instead of the classic 'malloc', 'aligned_alloc' and 'free' functions
        --use-opaque-pointers                                 - Generate LLVM IR using opaque pointers instead of typed pointers
      --finalizing-bufferize                                  -   Finalize a partial bufferization
      --fold-memref-alias-ops                                 -   Fold memref alias ops into consumer load/store ops
      --fold-tensor-subset-ops                                -   Fold tensor subset ops into producer/consumer ops
      --func-bufferize                                        -   Bufferize func/call/return ops
      --generate-runtime-verification                         -   Generate additional runtime op verification checks
      --gpu-async-region                                      -   Make GPU ops async
      --gpu-decompose-memrefs                                 -   Decomposes memref index computation into explicit ops.
      --gpu-kernel-outlining                                  -   Outline gpu.launch bodies to kernel functions
        --data-layout-str=<string>                            - String containing the data layout specification to be attached to the GPU kernel module
      --gpu-launch-sink-index-computations                    -   Sink index computations into gpu.launch body
      --gpu-map-parallel-loops                                -   Greedily maps loops to GPU hardware dimensions.
      --gpu-module-to-binary                                  -   Transforms a GPU module into a GPU binary.
        --format=<string>                                     - The target representation of the compilation process.
        --handler=<value>                                     - Offloading handler to be attached to the resulting binary op.
        -l <string>                                           - Extra files to link to.
        --opts=<string>                                       - Command line options to pass to the tools.
        --toolkit=<string>                                    - Toolkit path.
      --gpu-to-llvm                                           -   Convert GPU dialect to LLVM dialect with GPU runtime calls
        --gpu-binary-annotation=<string>                      - Annotation attribute string for GPU binary
        --use-bare-pointers-for-host                          - Use bare pointers to pass memref arguments to host functions. All memrefs must have static shape.
        --use-bare-pointers-for-kernels                       - Use bare pointers to pass memref arguments to kernels. The kernel must use the same setting for this option.
        --use-opaque-pointers                                 - Generate LLVM IR using opaque pointers instead of typed pointers
      --inline                                                -   Inline function calls
        --default-pipeline=<string>                           - The default optimizer pipeline used for callables
        --max-iterations=<uint>                               - Maximum number of iterations when inlining within an SCC
        --op-pipelines=<pass-manager>                         - Callable operation specific optimizer pipelines (in the form of `dialect.op(pipeline)`)
      --int-range-optimizations                               -   Do optimizations based on integer range analysis
      --launch-func-to-vulkan                                 -   Convert vulkanLaunch external call to Vulkan runtime external calls
        --use-opaque-pointers                                 - Generate LLVM IR using opaque pointers instead of typed pointers
      --lift-cf-to-scf                                        -   Lift ControlFlow dialect to SCF dialect
      --linalg-bufferize                                      -   Bufferize the linalg dialect
      --linalg-detensorize                                    -   Detensorize linalg ops
        --aggressive-mode                                     - Detensorize all ops that qualify for detensoring along with branch operands and basic-block arguments.
      --linalg-fold-unit-extent-dims                          -   Remove unit-extent dimension in Linalg ops on tensors
        --use-rank-reducing-slices                            - Generate rank-reducing slices instead of reassociative reshapes
      --linalg-fuse-elementwise-ops                           -   Fuse elementwise operations on tensors
      --linalg-generalize-named-ops                           -   Convert named ops into generic ops
      --linalg-inline-scalar-operands                         -   Inline scalar operands into linalg generic ops
      --linalg-named-op-conversion                            -   Convert from one named linalg op to another.
      --llvm-add-comdats                                      -   Add comdats to linkonce and linkonce_odr functions
      --llvm-legalize-for-export                              -   Legalize LLVM dialect to be convertible to LLVM IR
      --llvm-optimize-for-nvvm-target                         -   Optimize NVVM IR
      --llvm-request-c-wrappers                               -   Request C wrapper emission for all functions
      --llvm-type-consistency                                 -   Rewrites to improve type consistency
        --max-vector-split-size=<uint>                        - Maximum size in bits of a vector value in a load or store operation operating on multiple elements that should still be split
      --loop-invariant-code-motion                            -   Hoist loop invariant instructions outside of the loop
      --lower-affine                                          -   Lower Affine operations to a combination of Standard and SCF operations
      --lower-host-to-llvm                                    -   Lowers the host module code and `gpu.launch_func` to LLVM
        --use-opaque-pointers                                 - Generate LLVM IR using opaque pointers instead of typed pointers
      --lower-vector-mask                                     -   Lower 'vector.mask' operations
      --map-memref-spirv-storage-class                        -   Map numeric MemRef memory spaces to SPIR-V storage classes
        --client-api=<string>                                 - The client API to use for populating mappings
      --math-uplift-to-fma                                    -   Uplift arith ops to math.fma.
      --mem2reg                                               -   Promotes memory slots into values.
        --region-simplify                                     - Perform control flow optimizations to the region tree
      --memref-emulate-wide-int                               -   Emulate 2*N-bit integer operations using N-bit operations
        --widest-int-supported=<uint>                         - Widest integer type supported by the target
      --memref-expand                                         -   Legalize memref operations to be convertible to LLVM.
      --mlprogram-pipeline-globals                            -   Optimize `ml_program` global operations for read and store
      --normalize-memrefs                                     -   Normalize memrefs
      --nvgpu-optimize-shared-memory                          -   Optimizes accesses to shard memory memrefs in order to reduce bank conflicts.
      --nvvm-attach-target                                    -   Attaches an NVVM target attribute to a GPU Module.
        -O <uint>                                             - Optimization level.
        --chip=<string>                                       - Target chip.
        --fast                                                - Enable fast math mode.
        --features=<string>                                   - Target features.
        --ftz                                                 - Enable flush to zero for denormals.
        -l <string>                                           - Extra bitcode libraries paths to link to.
        --module=<string>                                     - Regex used to identify the modules to attach the target to.
        --triple=<string>                                     - Target triple.
      --one-shot-bufferize                                    -   One-Shot Bufferize
        --allow-return-allocs-from-loops                      - Allows returning/yielding new allocations from a loop.
        --allow-unknown-ops                                   - Allows unknown (not bufferizable) ops in the input IR.
        --analysis-fuzzer-seed=<uint>                         - Test only: Analyze ops in random order with a given seed (fuzzer)
        --analysis-heuristic=<string>                         - Heuristic that control the IR traversal during analysis
        --bufferize-function-boundaries                       - Bufferize function boundaries (experimental).
        --copy-before-write                                   - Skip the analysis. Make a buffer copy on every write.
        --dialect-filter=<string>                             - Restrict bufferization to ops from these dialects.
        --dump-alias-sets                                     - Test only: Annotate tensor IR with alias sets
        --function-boundary-type-conversion=<string>          - Controls layout maps when bufferizing function signatures.
        --must-infer-memory-space                             - The memory space of an memref types must always be inferred. If unset, a default memory space of 0 is used otherwise.
        --no-analysis-func-filter=<string>                    - Skip analysis of functions with these symbol names.Set copyBeforeWrite to true when bufferizing them.
        --print-conflicts                                     - Test only: Annotate IR with RaW conflicts. Requires test-analysis-only.
        --test-analysis-only                                  - Test only: Only run inplaceability analysis and annotate IR
        --unknown-type-conversion=<string>                    - Controls layout maps for non-inferrable memref types.
      --outline-shape-computation                             -   Using shape.func to preserve shape computation
      --ownership-based-buffer-deallocation                   -   Adds all required dealloc operations for all allocations in the input program
        --private-function-dynamic-ownership                  - Allows to add additional arguments to private functions to dynamically pass ownership of memrefs to callees. This can enable earlier deallocations.
      --post-sparsification-rewrite                           -   Applies sparse tensor rewriting rules after sparsification
        --enable-convert                                      - Enable rewriting rules for the convert operator
        --enable-foreach                                      - Enable rewriting rules for the foreach operator
        --enable-runtime-library                              - Enable runtime library for manipulating sparse tensors
      --pre-sparsification-rewrite                            -   Applies sparse tensor rewriting rules prior to sparsification
      --print-ir                                              -   Print IR on the debug stream
        --label=<string>                                      - Label
      --print-op-stats                                        -   Print statistics of operations
        --json                                                - print the stats as JSON
      --promote-buffers-to-stack                              -   Promotes heap-based allocations to automatically managed stack-based allocations
        --max-alloc-size-in-bytes=<uint>                      - Maximal size in bytes to promote allocations to stack.
        --max-rank-of-allocated-memref=<uint>                 - Maximal memref rank to promote dynamic buffers.
      --reconcile-unrealized-casts                            -   Simplify and eliminate unrealized conversion casts
      --remove-dead-values                                    -   Remove dead values
      --remove-shape-constraints                              -   Replace all cstr_ ops with a true witness
      --resolve-ranked-shaped-type-result-dims                -   Resolve memref.dim of result values of ranked shape type
      --resolve-shaped-type-result-dims                       -   Resolve memref.dim of result values
      --rocdl-attach-target                                   -   Attaches a ROCDL target attribute to a GPU Module.
        -O <uint>                                             - Optimization level.
        --abi=<string>                                        - Optimization level.
        --chip=<string>                                       - Target chip.
        --correct-sqrt                                        - Enable correct rounded sqrt.
        --daz                                                 - Enable denormals are zero opt.
        --fast                                                - Enable fast relaxed math opt.
        --features=<string>                                   - Target features.
        --finite-only                                         - Enable finite only opt.
        -l <string>                                           - Extra bitcode libraries paths to link to.
        --module=<string>                                     - Regex used to identify the modules to attach the target to.
        --triple=<string>                                     - Target triple.
        --unsafe-math                                         - Enable unsafe math opt.
        --wave64                                              - Use Wave64 mode.
      --sccp                                                  -   Sparse Conditional Constant Propagation
      --scf-bufferize                                         -   Bufferize the scf dialect.
      --scf-for-loop-canonicalization                         -   Canonicalize operations within scf.for loop bodies
      --scf-for-loop-peeling                                  -   Peel `for` loops at their upper bounds.
        --skip-partial                                        - Do not peel loops inside of the last, partial iteration of another already peeled loop.
      --scf-for-loop-range-folding                            -   Fold add/mul ops into loop range
      --scf-for-loop-specialization                           -   Specialize `for` loops for vectorization
      --scf-for-to-while                                      -   Convert SCF for loops to SCF while loops
      --scf-parallel-loop-fusion                              -   Fuse adjacent parallel loops
      --scf-parallel-loop-specialization                      -   Specialize parallel loops for vectorization
      --scf-parallel-loop-tiling                              -   Tile parallel loops
        --no-min-max-bounds                                   - Perform tiling with fixed upper bound with inbound check inside the internal loops
        --parallel-loop-tile-sizes=<long>                     - Factors to tile parallel loops by
      --set-llvm-module-datalayout                            -   Attach a datalayout string as a module attribute
        --data-layout=<string>                                - String description (LLVM format) of the data layout that is expected on the produced module
      --shape-bufferize                                       -   Bufferize the shape dialect.
      --shape-to-shape-lowering                               -   Legalize Shape dialect to be convertible to Arith
      --slice-analysis-test                                   -   Test Slice analysis functionality.
        --omit-block-arguments                                - Test Slice analysis with multiple blocks but slice omiting block arguments
      --snapshot-op-locations                                 -   Generate new locations from the current IR
        --filename=<string>                                   - The filename to print the generated IR
        --tag=<string>                                        - A tag to use when fusing the new locations with the original. If unset, the locations are replaced.
      --sparse-buffer-rewrite                                 -   Rewrite sparse primitives on buffers to actual code
        --enable-buffer-initialization                        - Enable zero-initialization of the memory buffers
      --sparse-gpu-codegen                                    -   Generates GPU code during sparsification
        --num_threads=<int>                                   - Sets the number of GPU threads
      --sparse-storage-specifier-to-llvm                      -   Lower sparse storage specifer to llvm structure
      --sparse-tensor-codegen                                 -   Convert sparse tensors and primitives to actual code
        --create-sparse-deallocs                              - Specify if the temporary buffers created by the sparse compiler should be deallocated. For compatibility with core bufferization passes. This option is only used when enable-runtime-library=false. See also create-deallocs for BufferizationOption.
        --enable-buffer-initialization                        - Enable zero-initialization of the memory buffers
      --sparse-tensor-conversion                              -   Convert sparse tensors and primitives to library calls
        --s2s-strategy=<int>                                  - Set the strategy for sparse-to-sparse conversion
      --sparse-vectorization                                  -   Vectorizes loops after sparsification
        --enable-simd-index32                                 - Enable i32 indexing into vectors (for efficient gather/scatter)
        --enable-vla-vectorization                            - Enable vector length agnostic vectorization
        --vl=<int>                                            - Set the vector length (use 0 to disable vectorization)
      --sparsification                                        -   Automatically generate sparse tensor code from sparse tensor types
        --enable-gpu-libgen                                   - Enable GPU acceleration by means of direct library calls (like cuSPARSE)
        --enable-index-reduction                              - Enable dependent index reduction based algorithm to handle non-trivial index expressions on sparse inputs (experimental features)
        --enable-runtime-library                              - Enable runtime library for manipulating sparse tensors
        --gpu-data-transfer-strategy=<value>                  - Set the data transfer strategy
    =regular-dma                                        -   Default option: malloc on host without additional options or care and then use DMA to copy the data
    =pinned-dma                                         -   Based on the default option, pin the host memory to accelerate the data transfer
    =zero-copy                                          -   Use zero-copy to perform the data transfer from the host to the GPU
        --parallelization-strategy=<value>                    - Set the parallelization strategy
    =none                                               -   Turn off sparse parallelization.
    =dense-outer-loop                                   -   Enable dense outer loop sparse parallelization.
    =any-storage-outer-loop                             -   Enable sparse parallelization regardless of storage for the outer loop.
    =dense-any-loop                                     -   Enable dense parallelization for any loop.
    =any-storage-any-loop                               -   Enable sparse parallelization for any storage and loop.
      --sparsification-and-bufferization                      -   Mini-pipeline that combines bufferization and sparsifiation
      --spirv-canonicalize-gl                                 -   Canonicalize GLSL ops
      --spirv-lower-abi-attrs                                 -   Decorate SPIR-V composite type with layout info
      --spirv-rewrite-inserts                                 -   Rewrite sequential chains of `spirv.CompositeInsert` operations into `spirv.CompositeConstruct` operations
      --spirv-unify-aliased-resource                          -   Unify access of multiple aliased resources into access of one single resource
      --spirv-update-vce                                      -   Deduce and attach minimal (version, capabilities, extensions) requirements to spirv.module ops
      --spirv-webgpu-prepare                                  -   Prepare SPIR-V to target WebGPU by expanding unsupported ops and replacing with supported ones
      --sroa                                                  -   Scalar Replacement of Aggregates
      --stage-sparse-ops                                      -   Decompose a complex sparse operation into multiple stages
      --strip-debuginfo                                       -   Strip debug info from all operations
      --symbol-dce                                            -   Eliminate dead symbols
      --symbol-privatize                                      -   Mark symbols private
        --exclude=<string>                                    - Comma separated list of symbols that should not be marked private
      --tensor-bufferize                                      -   Bufferize the `tensor` dialect
      --test-affine-data-copy                                 -   Tests affine data copy utility functions.
        --for-memref-region                                   - Test copy generation for a single memref region
        --memref-filter                                       - Enable memref filter testing in affine data copy optimization
      --test-affine-loop-unswitch                             -   Tests affine loop unswitching / if/else hoisting
      --test-affine-parametric-tile                           -   Tile affine loops using SSA values as tile sizes
      --test-affine-reify-value-bounds                        -   Tests ValueBoundsOpInterface with affine dialect reification
        --reify-to-func-args                                  - Reify in terms of function args
        --use-arith-ops                                       - Reify with arith dialect ops
      --test-alias-analysis                                   -   Test alias analysis results.
      --test-alias-analysis-extending                         -   Test alias analysis extending.
      --test-alias-analysis-modref                            -   Test alias analysis ModRef results.
      --test-arith-emulate-wide-int                           -   Function pass to test Wide Integer Emulation
        --function-prefix=<string>                            - Prefix of functions to run the emulation pass on
        --widest-int-supported=<uint>                         - Maximum integer bit width supported by the target
      --test-block-is-in-loop                                 -   Test mlir::blockIsInLoop()
      --test-bytecode-callback                                -   Test encoding of a dialect type/attributes with a custom callback
        --callback-test=<int>                                 - Specifies the test kind to execute
        --test-dialect-version=<value>                        - Specifies the test dialect version to emit and parse
      --test-cf-assert                                        -   Function pass to test cf.assert lowering to LLVM without abort
      --test-cfg-loop-info                                    -   Test the loop info analysis.
      --test-clone                                            -   Test clone of op
      --test-commutativity-utils                              -   Test the functionality of the commutativity utility
      --test-compose-subview                                  -   Test combining composed subviews
      --test-constant-fold                                    -   Test operation constant folding
      --test-control-flow-sink                                -   Test control-flow sink pass
      --test-convert-call-op                                  -   Tests conversion of `func.call` to `llvm.call` in presence of custom types
      --test-create-vector-broadcast                          -   Test optimization transformations for transfer ops
      --test-data-layout-query                                -   Test data layout queries
      --test-dead-code-analysis                               -
      --test-decompose-affine-ops                             -   Tests affine ops decomposition utility functions.
      --test-decompose-call-graph-types                       -   Decomposes types at call graph boundaries.
      --test-derived-attr                                     -   Run test derived attributes
      --test-diagnostic-filter                                -   Test diagnostic filtering support.
        --filters=<string>                                    - Specifies the diagnostic file name filters.
      --test-dialect-conversion-pdll                          -   Test DialectConversion PDLL functionality
      --test-distinct-attrs                                   -   Test parallel creation of distinct attributes
      --test-dynamic-pipeline                                 -   Tests the dynamic pipeline feature by applying a pipeline on a selected set of functions
        --dynamic-pipeline=<string>                           - The pipeline description that will run on the filtered function.
        --op-name=<string>                                    - List of function name to apply the pipeline to
        --run-on-nested-operations                            - This will apply the pipeline on nested operations under the visited operation.
        --run-on-parent                                       - This will apply the pipeline on the parent operation if it exist, this is expected to fail.
      --test-elements-attr-interface                          -   Test ElementsAttr interface support.
      --test-emulate-narrow-int                               -   Function pass to test Narrow Integer Emulation
        --arith-compute-bitwidth=<uint>                       - arith computation bit width
        --memref-load-bitwidth=<uint>                         - memref load/store emulation bit width
      --test-expand-math                                      -   Test expanding math
      --test-extract-fixed-outer-loops                        -   test application of parametric tiling to the outer loops so that the ranges of outer loops become static
        --test-outer-loop-sizes=<long>                        - fixed number of iterations that the outer loops should have
      --test-fold-arith-extf-into-vector-contract-patterns    -   Test patterns that fold arithmetic extension ops into vector contract ops
      --test-foo-analysis                                     -
      --test-func-erase-arg                                   -   Test erasing func args.
      --test-func-erase-result                                -   Test erasing func results.
      --test-func-insert-arg                                  -   Test inserting func args.
      --test-func-insert-result                               -   Test inserting func results.
      --test-func-set-type                                    -   Test FunctionOpInterface::setType.
      --test-function-pass                                    -   Test a function pass in the pass manager
      --test-generic-ir-block-visitors-interrupt              -   Test generic IR visitors with interrupts, starting with Blocks.
      --test-generic-ir-region-visitors-interrupt             -   Test generic IR visitors with interrupts, starting with Regions.
      --test-generic-ir-visitors                              -   Test generic IR visitors.
      --test-generic-ir-visitors-interrupt                    -   Test generic IR visitors with interrupts.
      --test-gpu-memory-promotion                             -   Promotes the annotated arguments of gpu.func to workgroup memory.
      --test-gpu-rewrite                                      -   Applies all rewrite patterns within the GPU dialect.
      --test-inline                                           -   Test inlining region calls
      --test-int-range-inference                              -   Test integer range inference analysis
      --test-interface-pass                                   -   Test an interface pass (running on FunctionOpInterface) in the pass manager
      --test-ir-visitors                                      -   Test various visitors.
      --test-last-modified                                    -
      --test-lazy-loading                                     -   Test LazyLoading of op
        --bytecode-version=<int>                              - Specifies the bytecode version to use.
      --test-legalize-patterns                                -   Run test dialect legalization patterns
      --test-legalize-type-conversion                         -   Test various type conversion functionalities in DialectConversion
      --test-legalize-unknown-root-patterns                   -   Test public remapped value mechanism in ConversionPatternRewriter
      --test-linalg-data-layout-propagation                   -   Test data layout propagation
      --test-linalg-decompose-ops                             -   Test Linalg decomposition patterns
        --remove-dead-args-and-results                        - Test patterns to erase unused operands and results
      --test-linalg-drop-unit-dims                            -
      --test-linalg-elementwise-fusion-patterns               -   Test Linalg element wise operation fusion patterns
        --collapse-dimensions-control=<long>                  - Test controlling dimension collapse pattern
        --control-fusion-by-expansion                         - Test controlling fusion of reshape with generic op by expansion
        --fuse-generic-ops                                    - Test fusion of generic operations.
        --fuse-generic-ops-control                            - Test fusion of generic operations with a control function.
        --fuse-multiuse-producer                              - Test fusion of producer ops with multiple uses
        --fuse-with-reshape-by-collapsing                     - Test linalg expand_shape -> generic fusion patterns that collapse the iteration space of the consumer
        --fuse-with-reshape-by-collapsing-control             - Test controlling the linalg expand_shape -> generic fusion patterns that collapse the iteration space of the consumer
        --fuse-with-reshape-by-expansion                      - Test fusion of generic operations with reshape by expansion
      --test-linalg-greedy-fusion                             -   Test Linalg fusion by applying a greedy test transformation.
      --test-linalg-pad-fusion                                -   Test PadOp fusion
      --test-linalg-transform-patterns                        -   Test Linalg transformation patterns by applying them greedily.
        --loop-type=<string>                                  - Specify the type of loops to generate: for, parallel or tiled_loop
        --peeled-loops=<long>                                 - Loops to be peeled when test-tile-pattern
        --skip-partial                                        - Skip loops inside partial iterations during peeling
        --test-bubble-up-extract-slice-op-pattern             - Test rewrite of linalgOp + extract_slice into extract_slice + linalgOp
        --test-erase-unnecessary-inputs                       - Test patterns to erase unnecessary inputs
        --test-erase-unused-operands-and-results              - Test patterns to erase unused operands and results
        --test-generalize-pad-tensor                          - Test transform pad tensor by copying with generic ops
        --test-generalize-tensor-pack                         - Test transform that generalizes pack ops into a sequence of tensor and Linalg ops
        --test-generalize-tensor-unpack                       - Test transform that generalizes unpack ops into a sequence of tensor and Linalg ops
        --test-linalg-to-vector-patterns                      - Test a set of patterns that rewrite a linalg contraction in vector.contract form
        --test-patterns                                       - Test a mixed set of patterns
        --test-swap-extract-slice-with-fill-pattern           - Test patterns to swap tensor.extract_slice(linalg.fill())
        --test-swap-subtensor-padtensor                       - Test rewrite of subtensor(tensor.pad) into tensor.pad(subtensor)
        --test-vector-transfer-forwarding-patterns            - Test a fused pass that forwards memref.copy to vector.transfer
        --tile-sizes=<long>                                   - Linalg tile sizes for test-tile-pattern
      --test-liveness-analysis                                -
      --test-loop-fusion                                      -   Tests loop fusion utility functions.
      --test-loop-permutation                                 -   Tests affine loop permutation utility
        --permutation-map=<uint>                              - Specify the loop permutation
      --test-loop-unrolling                                   -   Tests loop unrolling transformation
        --annotate                                            - Annotate unrolled iterations.
        --loop-depth=<uint>                                   - Loop depth.
        --unroll-factor=<ulong>                               - Loop unroll factor.
        --unroll-up-to-factor                                 - Loop unroll up to factor.
      --test-make-isolated-from-above                         -   Test making a region isolated from above
        --clone-ops-with-no-operands                          - Test case with cloning of operations with no operands
        --clone-ops-with-operands                             - Test case with cloning of operations with no operands
        --simple                                              - Test simple case with no cloning of operations
      --test-mapping-to-processing-elements                   -   test mapping a single loop on a virtual processor grid
      --test-match-reduction                                  -   Test the match reduction utility.
      --test-matchers                                         -   Test C++ pattern matchers.
      --test-math-algebraic-simplification                    -   Test math algebraic simplification
      --test-math-polynomial-approximation                    -   Test math polynomial approximations
        --enable-avx2                                         - Enable approximations that emit AVX2 intrinsics via the X86Vector dialect
      --test-memref-bound-check                               -   Check memref access bounds
      --test-memref-dependence-check                          -   Checks dependences between all pairs of memref accesses.
      --test-memref-stride-calculation                        -   Test operation constant folding
      --test-merge-blocks                                     -   Test Merging operation in ConversionPatternRewriter
      --test-mlir-reducer                                     -   Tests MLIR Reduce tool by generating failures
      --test-module-pass                                      -   Test a module pass in the pass manager
      --test-multi-buffering                                  -   Test multi buffering transformation
        --multiplier=<uint>                                   - Decide how many versions of the buffer should be created,
      --test-next-access                                      -
      --test-nvgpu-mmasync-f32-to-tf32-patterns               -   Test patterns to convert mma.sync on f32 with tf32 precision
        --precision=<string>                                  - Target nvgpu.mma.sync on f32 input with tf32 or tf32x3 precision
      --test-one-to-n-type-conversion                         -   Test pass for 1:N type conversion
        --convert-func-ops                                    - Enable conversion on func ops
        --convert-scf-ops                                     - Enable conversion on scf ops
        --convert-tuple-ops                                   - Enable conversion on tuple ops
      --test-opaque-loc                                       -   Changes all leaf locations to opaque locations
      --test-operations-equality                              -   Test operations equality.
      --test-options-pass                                     -   Test options parsing capabilities
        --enum=<value>                                        - Example enum option
    =zero                                               -   Example zero value
    =one                                                -   Example one value
        --list=<int>                                          - Example list option
        --string=<string>                                     - Example string option
        --string-list=<string>                                - Example string list option
      --test-pass-crash                                       -   Test a pass in the pass manager that always crashes
      --test-pass-create-invalid-ir                           -   Test pass that adds an invalid operation in a function body
        --emit-invalid-ir                                     - Emit invalid IR
        --signal-pass-failure                                 - Trigger a pass failure
      --test-pass-failure                                     -   Test a pass in the pass manager that always fails
      --test-pass-invalid-parent                              -   Test a pass in the pass manager that makes the parent operation invalid
      --test-pattern-selective-replacement                    -   Test selective replacement in the PatternRewriter
      --test-patterns                                         -   Run test dialect patterns
        --max-iterations=<int>                                - Max. iterations in the GreedyRewriteConfig
        --top-down                                            - Seed the worklist in general top-down order
      --test-pdl-bytecode-pass                                -   Test PDL ByteCode functionality
      --test-pdll-pass                                        -   Test PDLL functionality
      --test-print-callgraph                                  -   Print the contents of a constructed callgraph.
      --test-print-defuse                                     -   Test various printing.
      --test-print-dominance                                  -   Print the dominance information for multiple regions.
      --test-print-invalid                                    -   Test printing invalid ops.
      --test-print-liveness                                   -   Print the contents of a constructed liveness information.
      --test-print-nesting                                    -   Test various printing.
      --test-print-shape-mapping                              -   Print the contents of a constructed shape mapping information.
      --test-print-topological-sort                           -   Print operations in topological order
      --test-recursive-types                                  -   Test support for recursive types
      --test-remapped-value                                   -   Test public remapped value mechanism in ConversionPatternRewriter
      --test-return-type                                      -   Run return type functions
      --test-rewrite-dynamic-op                               -   Test rewritting on dynamic operations
      --test-scalar-vector-transfer-lowering                  -   Test lowering of scalar vector transfers to memref loads/stores.
        --allow-multiple-uses                                 - Fold transfer operations with multiple uses
      --test-scf-for-utils                                    -   test scf.for utils
        --test-replace-with-new-yields                        - Test replacing a loop with a new loop that returns new additional yield values
      --test-scf-if-utils                                     -   test scf.if utils
      --test-scf-parallel-loop-collapsing                     -   Test parallel loops collapsing transformation
        --collapsed-indices-0=<uint>                          - Which loop indices to combine 0th loop index
        --collapsed-indices-1=<uint>                          - Which loop indices to combine into the position 1 loop index
        --collapsed-indices-2=<uint>                          - Which loop indices to combine into the position 2 loop index
      --test-scf-pipelining                                   -   test scf.forOp pipelining
        --annotate                                            - Annote operations during loop pipelining transformation
        --no-epilogue-peeling                                 - Use predicates instead of peeling the epilogue.
      --test-scf-while-op-builder                             -   test build functions of scf.while
      --test-shape-function-report                            -   Test pass to report associated shape functions
      --test-side-effects                                     -   Test side effects interfaces
      --test-sink-vector-broadcast                            -   Test lowering patterns that eliminate redundant brodacast operations.
      --test-spirv-entry-point-abi                            -   Set the spirv.entry_point_abi attribute on GPU kernel function within the module, intended for testing only
        --workgroup-size=<int>                                - Workgroup size to use for all gpu.func kernels in the module, specified with x-dimension first, y-dimension next and z-dimension last. Unspecified dimensions will be set to 1
      --test-spirv-module-combiner                            -   Tests SPIR-V module combiner library
      --test-spirv-op-availability                            -   Test SPIR-V op availability
      --test-spirv-target-env                                 -   Test SPIR-V target environment
      --test-stats-pass                                       -   Test pass statistics
      --test-strict-pattern-driver                            -   Test strict mode of pattern driver
        --strictness=<string>                                 - Can be {AnyOp, ExistingAndNewOps, ExistingOps}
      --test-symbol-rauw                                      -   Test replacement of symbol uses
      --test-symbol-uses                                      -   Test detection of symbol uses
      --test-take-body                                        -   Test Region's takeBody
      --test-target-materialization-with-no-uses              -   Test a special case of target materialization in DialectConversion
      --test-tensor-copy-insertion                            -   Module pass to test Tensor Copy Insertion
        --allow-return-allocs-from-loops                      - Allows returning/yielding new allocations from a loop.
        --bufferize-function-boundaries                       - Bufferize function boundaries.
        --must-infer-memory-space                             - The memory space of an memref types must always be inferred. If unset, a default memory space of 0 is used otherwise.
      --test-tensor-transform-patterns                        -   Test Tensor transformation patterns by applying them greedily.
        --test-drop-redundant-insert-slice-rank-expansion     - Test dropping redundant insert_slice rank expansions
        --test-fold-consecutive-insert-extract-slice          - Test folding consecutive tensor.insert_slice/tensor.extract_slice
        --test-fold-constant-extract-slice                    - Test folding arith.constant and tensor.extract_slice
        --test-fold-into-pack-and-unpack                      - Test folding ops into tensor.pack and tensor.unpack
        --test-reassociative-reshape-folding                  - Test folding of expand_shape/collapse_shape
        --test-rewrite-extract-slice-from-collapse-shape      - Test swapping tensor.extract_slice of a collapse_shape with loop nest
        --test-simplify-pack-patterns                         - Test patterns to simplify tensor.pack
        --test-tracking-listener                              - Test tensor TrackingListener for the transform dialect
        --use-foreach                                         - Use the scf.forall operation when generating loop nests for the extract_slice of collapse_shape pattern
      --test-tiling-interface                                 -   Test tiling using TilingInterface
        --lower-to-scalar-using-scf-for                       - Test lowering to scalar implementation using TilingInterface with scf.for operations
        --tile-consumer-and-fuse-producer-using-scf-for       - Test tile and fuse transformation using TilingInterface with scf.for operations
        --tile-consumer-fuse-and-yield-producer-using-scf-for - Test tile and fuse transformation while yielding fused producer replacements using TilingInterface with scf.for operations
        --tile-using-scf-for                                  - Test tiling using TilingInterface with scf.for operations
      --test-topological-sort-analysis                        -   Test topological sorting of ops
      --test-trait-folder                                     -   Run trait folding
      --test-transform-dialect-erase-schedule                 -   erase transform dialect schedule from the IR
      --test-transform-dialect-interpreter                    -   apply transform dialect operations one by one
        --bind-first-extra-to-ops=<string>                    - bind the first extra argument of the top-level op to payload operations of the given kind
        --bind-first-extra-to-params=<int>                    - bind the first extra argument of the top-level op to the given integer parameters
        --bind-first-extra-to-results-of-ops=<string>         - bind the first extra argument of the top-level op to results of payload operations of the given kind
        --bind-second-extra-to-ops=<string>                   - bind the second extra argument of the top-level op to payload operations of the given kind
        --bind-second-extra-to-params=<int>                   - bind the second extra argument of the top-level op to the given integer parameters
        --bind-second-extra-to-results-of-ops=<string>        - bind the second extra argument of the top-level op to results of payload operations of the given kind
        --debug-payload-root-tag=<string>                     - Select the operation with 'transform.target_tag' attribute having the given value as payload IR root. If empty select the pass anchor operation as the payload IR root.
        --debug-transform-root-tag=<string>                   - Select the operation with 'transform.target_tag' attribute having the given value as container IR for top-level transform ops. This allows user control on what transformation to apply. If empty, select the container of the top-level transform op.
        --enable-expensive-checks                             - perform expensive checks to better report errors in the transform IR
        --test-module-generation                              - test the generation of the transform module during pass initialization, overridden by parsing
        --transform-file-name=<string>                        - Optional filename containing a transform dialect specification to apply. If left empty, the IR is assumed to contain one top-level transform dialect operation somewhere in the module.
        --transform-library-paths=<string>                    - Optional paths to files with modules that should be merged into the transform module to provide the definitions of external named sequences.
      --test-type-interfaces                                  -   Test type interface support.
      --test-vector-break-down-bitcast                        -   Test pattern that breaks down vector.bitcast ops
      --test-vector-contraction-prepare-for-mmt-lowering      -   Test vector.contraction matmul canonicalization for MMT lowering.
      --test-vector-extract-strided-slice-lowering            -   Test lowering patterns that converts vector.extract_strided_slice into a chain of vector.extract and vector.insert ops
      --test-vector-gather-lowering                           -   Test patterns that lower the gather op in the vector conditional loads
      --test-vector-reduction-to-contract-patterns            -   Test patterns to convert multireduce op to contract and combine broadcast/transpose to contract
      --test-vector-reduction-to-spirv-dot-prod               -   Test lowering patterns that converts vector.reduction to SPIR-V integer dot product ops
      --test-vector-scan-lowering                             -   Test lowering patterns that lower the scan op in the vector dialect
      --test-vector-to-vector-lowering                        -   Test lowering patterns between ops in the vector dialect
        --unroll                                              - Include unrolling
      --test-vector-transfer-collapse-inner-most-dims         -   Test lowering patterns that reducedes the rank of the vector transfer memory and vector operands.
      --test-vector-transfer-flatten-patterns                 -   Test patterns to rewrite contiguous row-major N-dimensional vector.transfer_{read,write} ops into 1D transfers
      --test-vector-transfer-unrolling-patterns               -   Test lowering patterns to unroll transfer ops in the vector dialect
        --reverse-unroll-order                                - reverse the order of unrolling of vector transfer operations
      --test-vector-transferop-opt                            -   Test optimization transformations for transfer ops
      --test-vector-unrolling-patterns                        -   Test lowering patterns to unroll contract ops in the vector dialect
        --unroll-based-on-type                                - Set the unroll factor based on type of the operation
        --unroll-order=<long>                                 - set the unroll order
      --test-vector-warp-distribute                           -   Test vector warp distribute transformation and lowering patterns
        --distribute-transfer-write                           - Test distribution of transfer write
        --hoist-uniform                                       - Test hoist uniform
        --propagate-distribution                              - Test distribution propgation
        --rewrite-warp-ops-to-scf-if                          - Lower vector.warp_execute_on_lane0 to scf.if op
      --test-verify-uselistorder                              -   Verify that roundtripping the IR to bytecode preserves the order of the uselists
        --rng-seed=<uint>                                     - Specify an input random seed
      --test-written-to                                       -
      --topological-sort                                      -   Sort regions without SSA dominance in topological order
      --tosa-infer-shapes                                     -   Propagate shapes across TOSA operations
      --tosa-layerwise-constant-fold                          -   Fold layerwise operations on constant tensors
      --tosa-make-broadcastable                               -   TOSA rank Reshape to enable Broadcasting
      --tosa-optional-decompositions                          -   Applies Tosa operations optional decompositions
      --tosa-test-quant-utils                                 -   TOSA Test: Exercise the APIs in QuantUtils.cpp.
      --tosa-to-arith                                         -   Lower TOSA to the Arith dialect
        --include-apply-rescale                               - Whether to include the lowering for tosa.apply_rescale to arith
        --use-32-bit                                          - Whether to prioritze lowering to 32-bit operations
      --tosa-to-linalg                                        -   Lower TOSA to LinAlg on tensors
      --tosa-to-linalg-named                                  -   Lower TOSA to LinAlg named operations
      --tosa-to-scf                                           -   Lower TOSA to the SCF dialect
      --tosa-to-tensor                                        -   Lower TOSA to the Tensor dialect
      --tosa-validate                                         -   Validates TOSA dialect
        --level=<value>                                       - Validate if operator parameters are within specfication for the given level
    =8k                                                 -   Ranges are expected to be sufficient for applications with frame sizes up to 8K.
    =none                                               -   Allows the full range of arguments specified by the operations according to the operation data types.
        --profile=<value>                                     - Validate if operations match for the given profile
    =bi                                                 -   Use Base Inference profile.
    =mi                                                 -   Use Main Inference profile.
    =mt                                                 -   Use Main Training profile.
    =undefined                                          -   Do not define a profile.
        --strict-op-spec-alignment                            - Verify if the properties of certain operations align the spec requirement
      --transform-dialect-check-uses                          -   warn about potential use-after-free in the transform dialect
      --transform-infer-effects                               -   infer transform side effects for symbols
      --vector-bufferize                                      -   Bufferize Vector dialect ops
      --view-op-graph                                         -   Print Graphviz visualization of an operation
        --max-label-len=<uint>                                - Limit attribute/type length to number of chars
        --print-attrs                                         - Print attributes of operations
        --print-control-flow-edges                            - Print control flow edges
        --print-data-flow-edges                               - Print data flow edges
        --print-result-types                                  - Print result types of operations
    Pass Pipelines:
      --buffer-deallocation-pipeline                          -   The default pipeline for automatically inserting deallocation operations after one-shot bufferization. Deallocation operations (except `memref.realloc`) may not be present already.
        --private-function-dynamic-ownership                  - Allows to add additional arguments to private functions to dynamically pass ownership of memrefs to callees. This can enable earlier deallocations.
      --sparse-compiler                                       -   The standard pipeline for taking sparsity-agnostic IR using the sparse-tensor type, and lowering it to LLVM IR with concrete representations and algorithms for sparse tensors.
        --create-sparse-deallocs                              - Specify if the temporary buffers created by the sparse compiler should be deallocated. For compatibility with core bufferization passes. This option is only used when enable-runtime-library=false.
        --enable-amx                                          - Enables the use of AMX dialect while lowering the vector dialect
        --enable-arm-neon                                     - Enables the use of ArmNeon dialect while lowering the vector dialect
        --enable-arm-sve                                      - Enables the use of ArmSVE dialect while lowering the vector dialect
        --enable-buffer-initialization                        - Enable zero-initialization of memory buffers
        --enable-gpu-libgen                                   - Enables GPU acceleration by means of direct library calls (like cuSPARSE)
        --enable-index-optimizations                          - Allows compiler to assume indices fit in 32-bit if that yields faster code
        --enable-index-reduction                              - Enable dependent index reduction based algorithm to handle non-trivial index expressions on sparse inputs (experimental features)
        --enable-runtime-library                              - Enable runtime library for manipulating sparse tensors
        --enable-x86vector                                    - Enables the use of X86Vector dialect while lowering the vector dialect
        --gpu-chip=<string>                                   - GPU target architecture
        --gpu-data-transfer-strategy=<value>                  - Set the data transfer strategy between the host and the GPUs
    =regular-dma                                        -   Default option: malloc on host without additional options or care and then use DMA to copy the data
    =pinned-dma                                         -   Based on the default option, pin the host memory to accelerate the data transfer
    =zero-copy                                          -   Use zero-copy to perform the data transfer from the host to the GPU
        --gpu-features=<string>                               - GPU target features
        --gpu-format=<string>                                 - GPU compilation format
        --gpu-triple=<string>                                 - GPU target triple
        --parallelization-strategy=<value>                    - Set the parallelization strategy
    =none                                               -   Turn off sparse parallelization.
    =dense-outer-loop                                   -   Enable dense outer loop sparse parallelization.
    =any-storage-outer-loop                             -   Enable sparse parallelization regardless of storage for the outer loop.
    =dense-any-loop                                     -   Enable dense parallelization for any loop.
    =any-storage-any-loop                               -   Enable sparse parallelization for any storage and loop.
        --reassociate-fp-reductions                           - Allows llvm to reassociate floating-point reductions for speed
        --s2s-strategy=<int>                                  - Set the strategy for sparse-to-sparse conversion
        --test-bufferization-analysis-only                    - Run only the inplacability analysis
        --vl=<int>                                            - Set the vector length (0 disables vectorization)
      --test-lower-to-llvm                                    -   An example of pipeline to lower the main dialects (arith, linalg, memref, scf, vector) down to LLVM.
        --reassociate-fp-reductions                           - Allow reassociation og FP reductions
      --test-options-pass-pipeline                            -   Parses options using pass pipeline registration
        --enum=<value>                                        - Example enum option
    =zero                                               -   Example zero value
    =one                                                -   Example one value
        --list=<int>                                          - Example list option
        --string=<string>                                     - Example string option
        --string-list=<string>                                - Example string list option
      --test-pm-nested-pipeline                               -   Test a nested pipeline in the pass manager
      --test-textual-pm-nested-pipeline                       -   Test a nested pipeline in the pass manager
  --test-legalize-mode=<value>                                - The legalization mode to use with the test driver
    =analysis                                                 -   Perform an analysis conversion
    =full                                                     -   Perform a full conversion
    =partial                                                  -   Perform a partial conversion
  --type-based-intrinsic-cost                                 - Calculate intrinsics cost based only on argument types
  --verify-diagnostics                                        - Check that emitted diagnostics match expected-* lines on the corresponding line
  --verify-each                                               - Run the verifier after each transformation pass
  --verify-region-info                                        - Verify region info (time consuming)
  --verify-roundtrip                                          - Round-trip the IR after parsing and ensure it succeeds
  --vp-counters-per-site=<number>                             - The average number of profile counters allocated per value profiling site.
  --vp-static-alloc                                           - Do static counter allocation for value profiler

Generic Options:

  --help                                                      - Display available options (--help-hidden for more)
  --help-list                                                 - Display list of available options (--help-list-hidden for more)
  --version                                                   - Display the version of this program

affine-super-vectorizer-test options:

  --backward-slicing                                          - Enable testing backward static slicing and topological sort functionalities
  --compose-maps                                              - Enable testing the composition of AffineMap where each AffineMap in the composition is specified as the affine_map attribute in a constant op.
  --forward-slicing                                           - Enable testing forward static slicing and topological sort functionalities
  --slicing                                                   - Enable testing static slicing and topological sort functionalities
  --vector-shape-ratio=<int>                                  - Specify the HW vector size for vectorization
  --vectorize-affine-loop-nest                                - Enable testing for the 'vectorizeAffineLoopNest' utility by vectorizing the outermost loops found

test-loop-fusion options:

  --test-loop-fusion-dependence-check                         - Enable testing of loop fusion dependence check
  --test-loop-fusion-slice-computation                        - Enable testing of loop fusion slice computation
  --test-loop-fusion-transformation                           - Enable testing of loop fusion transformation