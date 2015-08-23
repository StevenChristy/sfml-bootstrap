include(ExternalProject)

# Setup some initial variables
set(PROJ_BUILD_DIR "${CMAKE_CURRENT_BINARY_DIR}")
link_directories(${PROJ_BUILD_DIR}/lib)
if ( SFMLBOOTSTRAP_EXTERNAL_DIR STREQUAL "" OR NOT DEFINED SFMLBOOTSTRAP_EXTERNAL_DIR)
    set(SFMLBOOTSTRAP_EXTERNAL_DIR external)
    set_directory_properties(PROPERTIES ADDITIONAL_MAKE_CLEAN_FILES "${PROJ_BUILD_DIR}/${SFMLBOOTSTRAP_EXTERNAL_DIR}")
endif()
if ( CMAKE_BUILD_TYPE STREQUAL "" )
    set(CMAKE_BUILD_TYPE "Debug")
endif()
if ( CMAKE_INSTALL_PREFIX STREQUAL "" )
	set(CMAKE_INSTALL_PREFIX ${CMAKE_BINARY_DIR})
endif()
if(CMAKE_COMPILER_IS_GNUCXX )
   add_definitions(-Wall)
endif(CMAKE_COMPILER_IS_GNUCXX )
# Main Project
if(CMAKE_SIZEOF_VOID_P MATCHES "8")
    set(CURRENT_ARCH "x64")
else()
    set(CURRENT_ARCH "x86")
endif()
include(${CMAKE_SOURCE_DIR}/cmake/sfml-bootstrap/SFML.cmake)