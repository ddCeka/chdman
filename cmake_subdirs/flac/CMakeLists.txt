#libflac
set(flac_dir ${CMAKE_SOURCE_DIR}/3rdparty/flac)

add_compile_definitions(
    NDEBUG
    HAVE_CONFIG_H
    ENABLE_64_BIT_WORDS=1
    OGG_FOUND=0
    FLAC__HAS_OGG=0
    HAVE_LROUND=1
    HAVE_INTTYPES_H
    HAVE_STDBOOL_H
    HAVE_STDINT_H
    HAVE_STDIO_H
    HAVE_STDLIB_H
    HAVE_STRING_H
    _FILE_OFFSET_BITS=64
    _LARGEFILE_SOURCE
    CPU_IS_BIG_ENDIAN=0
    CPU_IS_LITTLE_ENDIAN=1
    WORDS_BIGENDIAN=0
    HAVE_BSWAP16
    HAVE_BSWAP32
)

if(MINGW)
add_compile_definitions(
HAVE_FSEEKO
)
endif()

if(${CMAKE_SYSTEM_NAME} STREQUAL "Linux")
add_compile_definitions(
   FLAC__SYS_LINUX
)
endif()

if(${CMAKE_SYSTEM_NAME} STREQUAL "Darwin")
add_compile_definitions(
   FLAC__SYS_DARWIN
)
endif()

if(${CMAKE_GENERATOR} STREQUAL "Unix Makefiles" OR ${CMAKE_GENERATOR} STREQUAL "Ninja")
set(CMAKE_C_FLAGS "${CMAKE_C_FLAGS} -Wno-error=unused-function -Wno-error=bad-function-cast")
endif()

if(CMAKE_C_COMPILER_ID STREQUAL "Clang" OR CMAKE_SYSTEM_NAME STREQUAL "Android")
set(CMAKE_C_FLAGS "${CMAKE_C_FLAGS} -Wno-enum-conversion")
endif()

if(${CMAKE_SYSTEM_NAME} STREQUAL "Darwin")
set(CMAKE_C_FLAGS "${CMAKE_C_FLAGS} -Wno-unknown-attributes")
endif()

include_directories(
    ${flac_dir}/src/libFLAC/include
    ${flac_dir}/include
)

add_library(flac STATIC
    ${flac_dir}/src/libFLAC/bitmath.c
    ${flac_dir}/src/libFLAC/bitreader.c
    ${flac_dir}/src/libFLAC/bitwriter.c
    ${flac_dir}/src/libFLAC/cpu.c
    ${flac_dir}/src/libFLAC/crc.c
    ${flac_dir}/src/libFLAC/fixed.c
    ${flac_dir}/src/libFLAC/fixed_intrin_avx2.c
    ${flac_dir}/src/libFLAC/fixed_intrin_sse2.c
    ${flac_dir}/src/libFLAC/fixed_intrin_sse42.c
    ${flac_dir}/src/libFLAC/fixed_intrin_ssse3.c
    ${flac_dir}/src/libFLAC/float.c
    ${flac_dir}/src/libFLAC/format.c
    ${flac_dir}/src/libFLAC/lpc.c
    ${flac_dir}/src/libFLAC/lpc_intrin_avx2.c
    ${flac_dir}/src/libFLAC/lpc_intrin_fma.c
    ${flac_dir}/src/libFLAC/lpc_intrin_neon.c
    ${flac_dir}/src/libFLAC/lpc_intrin_sse2.c
    ${flac_dir}/src/libFLAC/lpc_intrin_sse41.c
    ${flac_dir}/src/libFLAC/md5.c
    ${flac_dir}/src/libFLAC/memory.c
    ${flac_dir}/src/libFLAC/stream_decoder.c
    ${flac_dir}/src/libFLAC/stream_encoder.c
    ${flac_dir}/src/libFLAC/stream_encoder_framing.c
    ${flac_dir}/src/libFLAC/stream_encoder_intrin_avx2.c
    ${flac_dir}/src/libFLAC/stream_encoder_intrin_sse2.c
    ${flac_dir}/src/libFLAC/stream_encoder_intrin_ssse3.c
    ${flac_dir}/src/libFLAC/window.c
)

if(WIN32)
target_sources(flac PRIVATE
${flac_dir}/src/share/win_utf8_io/win_utf8_io.c
)
endif()
