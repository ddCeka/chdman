#libexpat
#option(BIGENDIAN OFF)
set(expat_dir ${CMAKE_SOURCE_DIR}/3rdparty/expat)

add_compile_definitions(
    HAVE_CXX11
    HAVE_MEMMOVE
    HAVE_STDINT_H
    HAVE_STDIO_H
    HAVE_STDLIB_H
    HAVE_STRING_H
    PACKAGE=expat
    PACKAGE_BUGREPORT="https://github.com/libexpat/libexpat/issues"
    PACKAGE_NAME=expat
    PACKAGE_STRING="expat-2.7.1"
    PACKAGE_TARNAME=expat
    PACKAGE_URL=
    PACKAGE_VERSION="2.7.1"
    STDC_HEADERS
    VERSION="2.7.1"
    XML_CONTEXT_BYTES=1024
    XML_DTD
    XML_GE=1
    XML_NS
)

#if(BIGENDIAN)
#add_compile_definitions(
#    BYTEORDER=4321
#    WORDS_BIGENDIAN
#)
#else()
add_compile_definitions(
    BYTEORDER=1234
)
#endif()

if(${CMAKE_SYSTEM_NAME} STREQUAL "Windows")
add_compile_definitions(
   __USE_MINGW_ANSI_STDIO=0
)
endif()

if(${CMAKE_SYSTEM_NAME} STREQUAL "FreeBSD" OR ${CMAKE_SYSTEM_NAME} STREQUAL "Darwin")
add_compile_definitions(
    HAVE_ARC4RANDOM
)
endif()

if(UNIX)
add_compile_definitions(
    HAVE_DLFCN_H
    HAVE_FCNTL_H
    HAVE_MMAP
    HAVE_SYS_STAT_H
    HAVE_SYS_TYPES_H
    HAVE_UNISTD_H
    XML_DEV_URANDOM
)
endif()

if(CMAKE_C_COMPILER_ID STREQUAL "Clang" OR CMAKE_SYSTEM_NAME STREQUAL "Android")

else()
set(CMAKE_C_FLAGS "${CMAKE_C_FLAGS} -Wno-error=maybe-uninitialized")
endif()

add_library(expat STATIC
    ${expat_dir}/lib/xmlparse.c
    ${expat_dir}/lib/xmlrole.c
    ${expat_dir}/lib/xmltok.c
)
