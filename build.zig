const std = @import("std");

pub fn build(b: *std.Build) void {
    const target = b.standardTargetOptions(.{});
    const optimize = b.standardOptimizeOption(.{});

    const strip = b.option(bool, "strip", "strip binaries") orelse false;

    const binaryen_mod = b.addModule("binaryen", .{
        .target = target,
        .optimize = optimize,
        .link_libcpp = true,
        .strip = strip,
    });

    const source_files = &[_][]const u8{
        "src/binaryen-c.cpp",
        "third_party/llvm-project/Binary.cpp",
        "third_party/llvm-project/ConvertUTF.cpp",
        "third_party/llvm-project/DJB.cpp",
        "third_party/llvm-project/DWARFAbbreviationDeclaration.cpp",
        "third_party/llvm-project/DWARFAcceleratorTable.cpp",
        "third_party/llvm-project/DWARFAddressRange.cpp",
        "third_party/llvm-project/DWARFCompileUnit.cpp",
        "third_party/llvm-project/DWARFContext.cpp",
        "third_party/llvm-project/DWARFDataExtractor.cpp",
        "third_party/llvm-project/DWARFDebugAbbrev.cpp",
        "third_party/llvm-project/DWARFDebugAddr.cpp",
        "third_party/llvm-project/DWARFDebugArangeSet.cpp",
        "third_party/llvm-project/DWARFDebugAranges.cpp",
        "third_party/llvm-project/DWARFDebugFrame.cpp",
        "third_party/llvm-project/DWARFDebugInfoEntry.cpp",
        "third_party/llvm-project/DWARFDebugLine.cpp",
        "third_party/llvm-project/DWARFDebugLoc.cpp",
        "third_party/llvm-project/DWARFDebugMacro.cpp",
        "third_party/llvm-project/DWARFDebugPubTable.cpp",
        "third_party/llvm-project/DWARFDebugRangeList.cpp",
        "third_party/llvm-project/DWARFDebugRnglists.cpp",
        "third_party/llvm-project/DWARFDie.cpp",
        "third_party/llvm-project/DWARFEmitter.cpp",
        "third_party/llvm-project/DWARFExpression.cpp",
        "third_party/llvm-project/DWARFFormValue.cpp",
        "third_party/llvm-project/DWARFGdbIndex.cpp",
        "third_party/llvm-project/DWARFListTable.cpp",
        "third_party/llvm-project/DWARFTypeUnit.cpp",
        "third_party/llvm-project/DWARFUnit.cpp",
        "third_party/llvm-project/DWARFUnitIndex.cpp",
        "third_party/llvm-project/DWARFVerifier.cpp",
        "third_party/llvm-project/DWARFVisitor.cpp",
        "third_party/llvm-project/DWARFYAML.cpp",
        "third_party/llvm-project/DataExtractor.cpp",
        "third_party/llvm-project/Debug.cpp",
        "third_party/llvm-project/Dwarf.cpp",
        "third_party/llvm-project/Error.cpp",
        "third_party/llvm-project/ErrorHandling.cpp",
        "third_party/llvm-project/FormatVariadic.cpp",
        "third_party/llvm-project/Hashing.cpp",
        "third_party/llvm-project/LEB128.cpp",
        "third_party/llvm-project/LineIterator.cpp",
        "third_party/llvm-project/MCRegisterInfo.cpp",
        "third_party/llvm-project/MD5.cpp",
        "third_party/llvm-project/MemoryBuffer.cpp",
        "third_party/llvm-project/NativeFormatting.cpp",
        "third_party/llvm-project/ObjectFile.cpp",
        "third_party/llvm-project/Optional.cpp",
        "third_party/llvm-project/Path.cpp",
        "third_party/llvm-project/ScopedPrinter.cpp",
        "third_party/llvm-project/SmallVector.cpp",
        "third_party/llvm-project/SourceMgr.cpp",
        "third_party/llvm-project/StringMap.cpp",
        "third_party/llvm-project/StringRef.cpp",
        "third_party/llvm-project/SymbolicFile.cpp",
        "third_party/llvm-project/Twine.cpp",
        "third_party/llvm-project/UnicodeCaseFold.cpp",
        "third_party/llvm-project/WithColor.cpp",
        "third_party/llvm-project/YAMLParser.cpp",
        "third_party/llvm-project/YAMLTraits.cpp",
        "third_party/llvm-project/dwarf2yaml.cpp",
        "third_party/llvm-project/obj2yaml_Error.cpp",
        "third_party/llvm-project/raw_ostream.cpp",

        "src/ir/ExpressionAnalyzer.cpp",
        "src/ir/ExpressionManipulator.cpp",
        "src/ir/debuginfo.cpp",
        "src/ir/drop.cpp",
        "src/ir/effects.cpp",
        "src/ir/eh-utils.cpp",
        "src/ir/export-utils.cpp",
        "src/ir/intrinsics.cpp",
        "src/ir/lubs.cpp",
        "src/ir/memory-utils.cpp",
        "src/ir/module-utils.cpp",
        "src/ir/names.cpp",
        "src/ir/possible-contents.cpp",
        "src/ir/properties.cpp",
        "src/ir/LocalGraph.cpp",
        "src/ir/LocalStructuralDominance.cpp",
        "src/ir/public-type-validator.cpp",
        "src/ir/ReFinalize.cpp",
        "src/ir/return-utils.cpp",
        "src/ir/stack-utils.cpp",
        "src/ir/table-utils.cpp",
        "src/ir/type-updating.cpp",
        "src/ir/module-splitting.cpp",

        "src/asmjs/asmangle.cpp",
        "src/asmjs/asm_v_wasm.cpp",
        "src/asmjs/shared-constants.cpp",

        "src/cfg/Relooper.cpp",

        "src/emscripten-optimizer/optimizer-shared.cpp",
        "src/emscripten-optimizer/simple_ast.cpp",

        "src/parser/context-decls.cpp",
        "src/parser/context-defs.cpp",
        "src/parser/lexer.cpp",
        "src/parser/parse-1-decls.cpp",
        "src/parser/parse-2-typedefs.cpp",
        "src/parser/parse-3-implicit-types.cpp",
        "src/parser/parse-4-module-types.cpp",
        "src/parser/parse-5-defs.cpp",
        "src/parser/wast-parser.cpp",
        "src/parser/wat-parser.cpp",

        "src/support/archive.cpp",
        "src/support/bits.cpp",
        "src/support/colors.cpp",
        "src/support/command-line.cpp",
        "src/support/debug.cpp",
        "src/support/dfa_minimization.cpp",
        "src/support/file.cpp",
        "src/support/intervals.cpp",
        "src/support/istring.cpp",
        "src/support/json.cpp",
        "src/support/name.cpp",
        "src/support/path.cpp",
        "src/support/safe_integer.cpp",
        "src/support/string.cpp",
        "src/support/suffix_tree.cpp",
        "src/support/suffix_tree_node.cpp",
        "src/support/threads.cpp",
        "src/support/utilities.cpp",

        "src/wasm/literal.cpp",
        "src/wasm/parsing.cpp",
        "src/wasm/source-map.cpp",
        "src/wasm/wasm.cpp",
        "src/wasm/wasm-binary.cpp",
        "src/wasm/wasm-debug.cpp",
        "src/wasm/wasm-emscripten.cpp",
        "src/wasm/wasm-interpreter.cpp",
        "src/wasm/wasm-io.cpp",
        "src/wasm/wasm-ir-builder.cpp",
        "src/wasm/wasm-stack.cpp",
        "src/wasm/wasm-stack-opts.cpp",
        "src/wasm/wasm-type.cpp",
        "src/wasm/wasm-type-shape.cpp",
        "src/wasm/wasm-validator.cpp",

        "src/analysis/cfg.cpp",

        "src/passes/pass.cpp",
        "src/passes/AbstractTypeRefining.cpp",
        "src/passes/AlignmentLowering.cpp",
        "src/passes/Asyncify.cpp",
        "src/passes/AvoidReinterprets.cpp",
        "src/passes/CoalesceLocals.cpp",
        "src/passes/CodeFolding.cpp",
        "src/passes/CodePushing.cpp",
        "src/passes/ConstantFieldPropagation.cpp",
        "src/passes/ConstHoisting.cpp",
        "src/passes/DataFlowOpts.cpp",
        "src/passes/DeadArgumentElimination.cpp",
        "src/passes/DeadCodeElimination.cpp",
        "src/passes/DeAlign.cpp",
        "src/passes/DebugLocationPropagation.cpp",
        "src/passes/DeNaN.cpp",
        "src/passes/Directize.cpp",
        "src/passes/DuplicateFunctionElimination.cpp",
        "src/passes/DuplicateImportElimination.cpp",
        "src/passes/DWARF.cpp",
        "src/passes/EncloseWorld.cpp",
        "src/passes/ExtractFunction.cpp",
        "src/passes/Flatten.cpp",
        "src/passes/FuncCastEmulation.cpp",
        "src/passes/GenerateDynCalls.cpp",
        "src/passes/GlobalEffects.cpp",
        "src/passes/GlobalRefining.cpp",
        "src/passes/GlobalStructInference.cpp",
        "src/passes/GlobalTypeOptimization.cpp",
        "src/passes/GUFA.cpp",
        "src/passes/hash-stringify-walker.cpp",
        "src/passes/Heap2Local.cpp",
        "src/passes/HeapStoreOptimization.cpp",
        "src/passes/I64ToI32Lowering.cpp",
        "src/passes/Inlining.cpp",
        "src/passes/InstrumentLocals.cpp",
        "src/passes/InstrumentMemory.cpp",
        "src/passes/Intrinsics.cpp",
        "src/passes/J2CLItableMerging.cpp",
        "src/passes/J2CLOpts.cpp",
        "src/passes/JSPI.cpp",
        "src/passes/LegalizeJSInterface.cpp",
        "src/passes/LimitSegments.cpp",
        "src/passes/LLVMMemoryCopyFillLowering.cpp",
        "src/passes/LLVMNontrappingFPToIntLowering.cpp",
        "src/passes/LocalCSE.cpp",
        "src/passes/LocalSubtyping.cpp",
        "src/passes/LogExecution.cpp",
        "src/passes/LoopInvariantCodeMotion.cpp",
        "src/passes/Memory64Lowering.cpp",
        "src/passes/MemoryPacking.cpp",
        "src/passes/MergeBlocks.cpp",
        "src/passes/MergeLocals.cpp",
        "src/passes/MergeSimilarFunctions.cpp",
        "src/passes/Metrics.cpp",
        "src/passes/MinifyImportsAndExports.cpp",
        "src/passes/MinimizeRecGroups.cpp",
        "src/passes/Monomorphize.cpp",
        "src/passes/MultiMemoryLowering.cpp",
        "src/passes/NameList.cpp",
        "src/passes/NameTypes.cpp",
        "src/passes/NoInline.cpp",
        "src/passes/OnceReduction.cpp",
        "src/passes/OptimizeAddedConstants.cpp",
        "src/passes/OptimizeCasts.cpp",
        "src/passes/OptimizeForJS.cpp",
        "src/passes/OptimizeInstructions.cpp",
        "src/passes/Outlining.cpp",
        "src/passes/param-utils.cpp",
        "src/passes/PickLoadSigns.cpp",
        "src/passes/Poppify.cpp",
        "src/passes/PostEmscripten.cpp",
        "src/passes/Precompute.cpp",
        "src/passes/Print.cpp",
        "src/passes/PrintCallGraph.cpp",
        "src/passes/PrintFeatures.cpp",
        "src/passes/PrintFunctionMap.cpp",
        "src/passes/RedundantSetElimination.cpp",
        "src/passes/RemoveImports.cpp",
        "src/passes/RemoveMemoryInit.cpp",
        "src/passes/RemoveNonJSOps.cpp",
        "src/passes/RemoveUnusedBrs.cpp",
        "src/passes/RemoveUnusedModuleElements.cpp",
        "src/passes/RemoveUnusedNames.cpp",
        "src/passes/RemoveUnusedTypes.cpp",
        "src/passes/ReorderFunctions.cpp",
        "src/passes/ReorderGlobals.cpp",
        "src/passes/ReorderLocals.cpp",
        "src/passes/ReReloop.cpp",
        "src/passes/RoundTrip.cpp",
        "src/passes/SafeHeap.cpp",
        "src/passes/SeparateDataSegments.cpp",
        "src/passes/SetGlobals.cpp",
        "src/passes/SignaturePruning.cpp",
        "src/passes/SignatureRefining.cpp",
        "src/passes/SignExtLowering.cpp",
        "src/passes/SimplifyGlobals.cpp",
        "src/passes/SimplifyLocals.cpp",
        "src/passes/Souperify.cpp",
        "src/passes/SpillPointers.cpp",
        "src/passes/SSAify.cpp",
        "src/passes/StackCheck.cpp",
        "src/passes/string-utils.cpp",
        "src/passes/StringLifting.cpp",
        "src/passes/StringLowering.cpp",
        "src/passes/Strip.cpp",
        "src/passes/StripEH.cpp",
        "src/passes/StripTargetFeatures.cpp",
        "src/passes/test_passes.cpp",
        "src/passes/TraceCalls.cpp",
        "src/passes/TranslateEH.cpp",
        "src/passes/TrapMode.cpp",
        "src/passes/TupleOptimization.cpp",
        "src/passes/TypeFinalizing.cpp",
        "src/passes/TypeGeneralizing.cpp",
        "src/passes/TypeMerging.cpp",
        "src/passes/TypeRefining.cpp",
        "src/passes/TypeSSA.cpp",
        "src/passes/Unsubtyping.cpp",
        "src/passes/Untee.cpp",
        "src/passes/Vacuum.cpp",
        "src/passes/WasmIntrinsics.cpp",
    };

    binaryen_mod.addIncludePath(b.path("src"));
    binaryen_mod.addIncludePath(b.path("third_party/FP16/include"));
    binaryen_mod.addIncludePath(b.path("third_party/llvm-project/include"));
    binaryen_mod.addIncludePath(b.path("."));

    binaryen_mod.addCSourceFiles(.{
        .files = source_files,
        .flags = &.{
            "-std=c++17",
            "-fno-rtti",
            "-Wno-unused-parameter",
            "-DBUILD_STATIC_LIBRARY",
            "-DPROJECT_VERSION=123",
        },
    });

    const lib_binaryen = b.addLibrary(.{
        .name = "binaryen",
        .root_module = binaryen_mod,
        .linkage = .static,
    });

    lib_binaryen.installHeader(b.path("src/binaryen-c.h"), "binaryen-c.h");
    lib_binaryen.installHeader(b.path("src/wasm-delegations.def"), "wasm-delegations.def");

    lib_binaryen.linkSystemLibrary("pthread");

    b.installArtifact(lib_binaryen);

    const wasm_opt_mod = b.addModule("wasm-opt", .{
        .target = target,
        .optimize = optimize,
        .strip = strip,
    });
    wasm_opt_mod.addIncludePath(b.path("src/tools"));
    wasm_opt_mod.addIncludePath(b.path("src"));
    wasm_opt_mod.addIncludePath(b.path("third_party/FP16/include"));
    wasm_opt_mod.addIncludePath(b.path("src/tools/fuzzing"));
    wasm_opt_mod.addCSourceFiles(.{
        .files = &.{
            "src/tools/wasm-opt.cpp",

            "src/tools/fuzzing/fuzzing.cpp",
            "src/tools/fuzzing/heap-types.cpp",
            "src/tools/fuzzing/parameters.cpp",
            "src/tools/fuzzing/random.cpp",
        },
        .language = .cpp,
    });

    wasm_opt_mod.linkLibrary(lib_binaryen);

    const wasm_opt_exe = b.addExecutable(.{
        .name = "wasm-merge",
        .root_module = wasm_opt_mod,
    });

    b.installArtifact(wasm_opt_exe);

    const wasm_merge_mod = b.addModule("wasm-merge", .{
        .target = target,
        .optimize = optimize,
        .strip = strip,
    });
    wasm_merge_mod.addIncludePath(b.path("src/tools"));
    wasm_merge_mod.addIncludePath(b.path("src"));
    wasm_merge_mod.addCSourceFiles(.{
        .files = &.{
            "src/tools/wasm-merge.cpp",
        },
        .language = .cpp,
    });

    wasm_merge_mod.linkLibrary(lib_binaryen);

    const wasm_merge_exe = b.addExecutable(.{
        .name = "wasm-merge",
        .root_module = wasm_merge_mod,
    });

    b.installArtifact(wasm_merge_exe);
}
