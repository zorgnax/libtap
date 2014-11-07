cmake_minimum_required (VERSION 2.6)
project (tap C)

option (LIBTAP_TESTS "Build libtap tests" OFF)

include_directories (
	${CMAKE_CURRENT_SOURCE_DIR})

add_library (tap
	tap.c
	tap.h)
install (TARGETS tap
	DESTINATION lib)

if (LIBTAP_TESTS)
	enable_testing ()
	add_subdirectory (t)
	add_test (prove
		${CMAKE_COMMAND} -E chdir ${CMAKE_CURRENT_SOURCE_DIR} prove)
endif ()
