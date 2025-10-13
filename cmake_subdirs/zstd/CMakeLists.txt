#zstd
set(zstd_dir ${CMAKE_SOURCE_DIR}/3rdparty/zstd)

add_compile_definitions(
    XXH_NAMESPACE=ZSTD_
    DEBUGLEVEL=0
    ZSTD_DISABLE_ASM
    NDEBUG
)

add_library(zstd STATIC
    ${zstd_dir}/lib/common/debug.c
    ${zstd_dir}/lib/common/entropy_common.c
    ${zstd_dir}/lib/common/error_private.c
    ${zstd_dir}/lib/common/fse_decompress.c
    ${zstd_dir}/lib/common/pool.c
    ${zstd_dir}/lib/common/threading.c
    ${zstd_dir}/lib/common/xxhash.c
    ${zstd_dir}/lib/common/zstd_common.c
    ${zstd_dir}/lib/compress/fse_compress.c
    ${zstd_dir}/lib/compress/hist.c
    ${zstd_dir}/lib/compress/huf_compress.c
    ${zstd_dir}/lib/compress/zstd_compress.c
    ${zstd_dir}/lib/compress/zstd_compress_literals.c
    ${zstd_dir}/lib/compress/zstd_compress_sequences.c
    ${zstd_dir}/lib/compress/zstd_compress_superblock.c
    ${zstd_dir}/lib/compress/zstd_double_fast.c
    ${zstd_dir}/lib/compress/zstd_fast.c
    ${zstd_dir}/lib/compress/zstd_lazy.c
    ${zstd_dir}/lib/compress/zstd_ldm.c
    ${zstd_dir}/lib/compress/zstdmt_compress.c
    ${zstd_dir}/lib/compress/zstd_opt.c
    ${zstd_dir}/lib/decompress/huf_decompress.c
    ${zstd_dir}/lib/decompress/zstd_ddict.c
    ${zstd_dir}/lib/decompress/zstd_decompress_block.c
    ${zstd_dir}/lib/decompress/zstd_decompress.c
)
