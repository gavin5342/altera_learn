# Target system
set(CMAKE_SYSTEM_NAME Generic)
set(CMAKE_SYSTEM_PROCESSOR "Nios V")
set(CMAKE_CROSSCOMPILING TRUE)
set(CMAKE_TRY_COMPILE_TARGET_TYPE STATIC_LIBRARY)

# --------------------------------------------------------------------
# Toolchain prefix path (user-overridable)
# --------------------------------------------------------------------
set(RISCV_TOOLCHAIN_PREFIX
    "/opt/altera/qpro/riscfree/toolchain/riscv32-unknown-elf"
    CACHE PATH
    "RISC-V toolchain installation prefix"
)

# Derived bin directory
set(RISCV_TOOLCHAIN_BIN "${RISCV_TOOLCHAIN_PREFIX}/bin")

# Sanity check (optional but recommended)
if(NOT EXISTS "${RISCV_TOOLCHAIN_BIN}/riscv32-unknown-elf-gcc")
    message(FATAL_ERROR
        "RISC-V toolchain not found at ${RISCV_TOOLCHAIN_BIN}. "
        "Set RISCV_TOOLCHAIN_PREFIX to the correct path."
    )
endif()

# --------------------------------------------------------------------
# Compiler and binutils
# --------------------------------------------------------------------
set(CMAKE_AR             "${RISCV_TOOLCHAIN_BIN}/riscv32-unknown-elf-ar")
set(CMAKE_ASM_COMPILER   "${RISCV_TOOLCHAIN_BIN}/riscv32-unknown-elf-gcc")
set(CMAKE_C_COMPILER     "${RISCV_TOOLCHAIN_BIN}/riscv32-unknown-elf-gcc")
set(CMAKE_CXX_COMPILER   "${RISCV_TOOLCHAIN_BIN}/riscv32-unknown-elf-g++")

# Toolchain prefix (kept for compatibility with existing BSP logic)
set(ToolchainPrefix
    "riscv32-unknown-elf-"
    CACHE STRING
    "Toolchain prefix."
    FORCE
)

# Objdump
set(ToolchainObjdump
    "${RISCV_TOOLCHAIN_BIN}/riscv32-unknown-elf-objdump"
    CACHE STRING
    "Objdump executable."
    FORCE
)

set(ToolchainObjdumpFlags
    "-Sdtx"
    CACHE STRING
    "Objdump flags."
    FORCE
)


set(ToolchainSize
    "${RISCV_TOOLCHAIN_BIN}/riscv32-unknown-elf-size"
    CACHE STRING
    "Size executable."
    FORCE
)

if(NOT CMAKE_BUILD_TYPE)
    message(STATUS "Defaulting build type to Debug.")
    set(CMAKE_BUILD_TYPE "Debug" CACHE STRING "Choose the type of build." FORCE)
endif()

set(CMAKE_C_FLAGS_DEBUG "-g")
set(CMAKE_CXX_FLAGS_DEBUG "-g")

set(CMAKE_C_FLAGS_RELEASE "-O2")
set(CMAKE_CXX_FLAGS_RELEASE "-O2")

add_compile_options(
    $<$<COMPILE_LANGUAGE:ASM>:-Wa,-gdwarf2>
    --specs=picolibcpp.specs
    -DALT_SINGLE_THREADED
    -Wall -Wformat-security
    -Wformat
    -Wformat-security
    -fstack-protector-strong
    -march=rv32i -mabi=ilp32
)

add_link_options(
    --oslib=libhal2_bsp --specs=picolibcpp.specs -mhal -nostdlib
    -Wl,--defsym=__heap_end=__alt_heap_limit
    -Wl,--defsym=__heap_start=__alt_heap_start
    -march=rv32i -mabi=ilp32
)

add_compile_definitions(
    ALT_LOG_FLAGS=0
    ALT_USE_SMALL_DRIVERS
    USE_PICOLIBC
    __hal__
)

remove_definitions(
)
