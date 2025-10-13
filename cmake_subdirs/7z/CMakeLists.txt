#lib7z
set(7z_dir ${CMAKE_SOURCE_DIR}/3rdparty/lzma)

if(CMAKE_GENERATOR STREQUAL "Unix Makefiles" OR CMAKE_GENERATOR STREQUAL "Ninja")
set(CMAKE_C_FLAGS "${CMAKE_C_FLAGS} -Wno-error=strict-prototypes -Wno-error=undef")
endif()

if(CMAKE_C_COMPILER_ID STREQUAL "GNU" AND CMAKE_C_COMPILER_VERSION VERSION_GREATER 13.0)
set(CMAKE_C_FLAGS "${CMAKE_C_FLAGS} -Wno-error=dangling-pointer")
endif()

add_compile_definitions(
    Z7_PPMD_SUPPPORT
    Z7_ST
)

add_library(7z STATIC
    ${7z_dir}/C/7zAlloc.c
    ${7z_dir}/C/7zArcIn.c
    ${7z_dir}/C/7zBuf.c
    ${7z_dir}/C/7zBuf2.c
    ${7z_dir}/C/7zCrc.c
    ${7z_dir}/C/7zCrcOpt.c
    ${7z_dir}/C/7zDec.c
    ${7z_dir}/C/7zFile.c
    ${7z_dir}/C/7zStream.c
    ${7z_dir}/C/Aes.c
    ${7z_dir}/C/AesOpt.c
    ${7z_dir}/C/Alloc.c
    ${7z_dir}/C/Bcj2.c
    ${7z_dir}/C/Bra.c
    ${7z_dir}/C/Bra86.c
    ${7z_dir}/C/BraIA64.c
    ${7z_dir}/C/CpuArch.c
    ${7z_dir}/C/Delta.c
    ${7z_dir}/C/LzFind.c
    ${7z_dir}/C/LzFindOpt.c
    ${7z_dir}/C/Lzma2Dec.c
    ${7z_dir}/C/LzmaDec.c
    ${7z_dir}/C/LzmaEnc.c
    ${7z_dir}/C/Ppmd7.c
    ${7z_dir}/C/Ppmd7Dec.c
    ${7z_dir}/C/Sha256.c
    ${7z_dir}/C/Sha256Opt.c
    ${7z_dir}/C/Sort.c
)
