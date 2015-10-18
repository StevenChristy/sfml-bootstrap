include(ExternalProject)

function(add_pch _target _pch_header _pch_cpp)
    if(CMAKE_COMPILER_IS_GNUCXX)
        add_custom_command(OUTPUT ${_pch_header}.gch
            COMMAND "${CMAKE_CXX_COMPILER}" "$(CXX_DEFINES) $(CXX_FLAGS)" -x c++-header -o "${_pch_header}.gch" "${_pch_header}"
            DEPENDS ${_pch_header} 
            COMMENT "Building precompiled header: ${_pch_header}.gch"
        )
        add_definitions(-include ${_pch_header})
        set_source_files_properties(${_pch_cpp} PROPERTIES OBJECT_DEPENDS "${_pch_header}.gch")
     elseif(MSVC)
        add_definitions(/Yu${_pch_header} /FU${_pch_header})
     endif()
endfunction()

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

if(CMAKE_COMPILER_IS_GNUCXX)
   add_definitions(-Wall)
endif(CMAKE_COMPILER_IS_GNUCXX)

# Main Project
if(CMAKE_SIZEOF_VOID_P MATCHES "8")
    set(CURRENT_ARCH "x64")
else()
    set(CURRENT_ARCH "x86")
endif()

if(MSVC)
        foreach(flag_var CMAKE_CXX_FLAGS CMAKE_CXX_FLAGS_DEBUG CMAKE_CXX_FLAGS_RELEASE CMAKE_CXX_FLAGS_MINSIZEREL CMAKE_CXX_FLAGS_RELWITHDEBINFO)
                if(${flag_var} MATCHES "/MD")
                        string(REGEX REPLACE "/MD" "/MT" ${flag_var} "${${flag_var}}")
                endif(${flag_var} MATCHES "/MD")
        endforeach(flag_var)
endif()

include(${CMAKE_SOURCE_DIR}/cmake/sfml-bootstrap/Bullet2.cmake)
include(${CMAKE_SOURCE_DIR}/cmake/sfml-bootstrap/libnoise.cmake)
include(${CMAKE_SOURCE_DIR}/cmake/sfml-bootstrap/SFML.cmake)