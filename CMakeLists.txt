cmake_minimum_required(VERSION 3.15)
project("chdman")
set(build_version "0.288")
set(vcs_revision "mame0288")
#cd ../mame && git describe --dirty

set(CMAKE_BUILD_TYPE Release CACHE STRING "Choose the type of build." FORCE)

set(CMAKE_CXX_STANDARD 20)
set(CMAKE_CXX_STANDARD_REQUIRED ON)

if(WIN32)
	add_compile_definitions(
		X64_WINDOWS_ABI
		CRLF=3
		OSD_WINDOWS
		_CRT_NONSTDC_NO_DEPRECATE
		_CRT_SECURE_NO_DEPRECATE
		_CRT_STDIO_LEGACY_WIDE_SPECIFIERS
		XML_STATIC
	)
else()
	add_compile_definitions(
		CRLF=2
		SDLMAME_UNIX
		SDLMAME_SDL2
		_FILE_OFFSET_BITS=64
		__STDC_CONSTANT_MACROS
		__STDC_FORMAT_MACROS
		__STDC_LIMIT_MACROS
	)
endif()

if(APPLE)	# Alternatively, could target OSX >= 10.13
    add_compile_options(-faligned-allocation)
endif()

function(addprojectflags)
	if(CMAKE_CXX_COMPILER_ID STREQUAL "GNU")
		# Upstream MAME enforces strict lifetime-dse limits on optimized structures
		set(CMAKE_CXX_FLAGS "${CMAKE_CXX_FLAGS} -Wsuggest-override -flifetime-dse=1" PARENT_SCOPE)
	endif()
endfunction()

if(NOT MSVC)
	# -fno-strict-aliasing preserves raw memory block reading logic 
	# -ffp-contract=off prevents subchannel float optimization variations
	set(CMAKE_CXX_FLAGS "${CMAKE_CXX_FLAGS} -O3 -fno-strict-aliasing -ffp-contract=off")
	set(CMAKE_C_FLAGS "${CMAKE_C_FLAGS} -O3 -fno-strict-aliasing -ffp-contract=off")
else()
	set(CMAKE_CXX_FLAGS "${CMAKE_CXX_FLAGS} /O2 /fp:precise")
	set(CMAKE_C_FLAGS "${CMAKE_C_FLAGS} /O2 /fp:precise")
endif()

add_subdirectory(cmake_subdirs)

#chdman
add_executable(chdman
	${CMAKE_SOURCE_DIR}/src/tools/chdman.cpp
	${CMAKE_SOURCE_DIR}/src/version.cpp
)

target_include_directories(chdman PRIVATE
	${CMAKE_SOURCE_DIR}/src/osd
	${CMAKE_SOURCE_DIR}/src/lib/util
	${CMAKE_SOURCE_DIR}/3rdparty/expat/lib
	${CMAKE_SOURCE_DIR}/3rdparty/lzma/C
	${CMAKE_SOURCE_DIR}/3rdparty/zlib
	${CMAKE_SOURCE_DIR}/3rdparty/zstd/lib
	${CMAKE_SOURCE_DIR}/3rdparty/flac/include
	${CMAKE_SOURCE_DIR}/3rdparty/utf8proc
)
set_property(TARGET chdman PROPERTY CXX_STANDARD 20)

target_compile_definitions(chdman PRIVATE
	BARE_BUILD_VERSION="${build_version}"
	BARE_VCS_REVISION="${vcs_revision}"
	NDEBUG
)

target_link_libraries(chdman PRIVATE utils ocore_sdl 7z flac zstd zlib expat utf8proc)

if(UNIX)
	target_link_libraries(chdman PRIVATE pthread util)
elseif(WIN32)
	target_link_libraries(chdman PRIVATE utils) #circular dependency bs Windows only.
	target_link_libraries(chdman PRIVATE
		user32
		winmm
		advapi32
		shlwapi
		wsock32
		ws2_32
		psapi
		iphlpapi
		shell32
		userenv
	)
endif()

if(MINGW)
	set(CMAKE_EXE_LINKER_FLAGS "${CMAKE_EXE_LINKER_FLAGS} -static")
endif()
