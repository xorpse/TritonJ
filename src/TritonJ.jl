module TritonJ

using Libdl
using Cxx

const tritonPath = "/usr/lib/libtriton.so"

function __init__()
    Libdl.dlopen(tritonPath, Libdl.RTLD_GLOBAL)
    cxxinclude("triton/api.hpp")
end


function mkTritonInsn(insnBytes :: Array{UInt8})
    insn = @cxxnew triton::arch::Instruction()

    ptrInsnBytes = pointer(insnBytes)
    lenInsnBytes = length(insnBytes)

    icxx"$insn->setOpcode(reinterpret_cast<unsigned char *>($ptrInsnBytes), $lenInsnBytes);"
    return insn
end

end # module
