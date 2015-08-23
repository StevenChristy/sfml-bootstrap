project(SFMLHelloWorld)

# minimum version for sfml-bootstrap is 2.8, but our example has us targeting C++14 by default.
cmake_minimum_required(VERSION 3.1.0 FATAL_ERROR)
set(CMAKE_CXX_STANDARD 14)

# This configuration file sets up all supported external libraries. See external/README.md for a list of those libraries.
# Additional variables:
# SFMLBOOTSTRAP_EXTERNAL_DIR = The subfolder that we'll be looking for our external libs in. Defaults to "external"
# You can change this but do not include a leading or trailing slash - no absolute paths for this variable. Sorry!
# To disable cleaning of external libs, you can set SFMLBOOTSTRAP_EXTERNAL_DIR to any non-blank value including "external"
include(cmake/sfml-bootstrap/Main.cmake)

# Begin Project Settings
set(SRC_FILES src/main.cpp)

# basic stuff
add_executable(hellosfml ${SRC_FILES})

# PROJ_LIBS was constructed by the sfml-bootstrap cmake files to contain any supported libraries lib files.
target_link_libraries(hellosfml ${PROJ_LIBS})
# other defines setup in the form of <LIBNAME>_LIBS - ex: SFML_LIBS SYSTEM_LIBS TGUI_LIBS but these are already included in PROJ_LIBS

# Tell CMake what external libs we're using
add_dependencies(hellosfml ${PROJ_DEPS})

# basic stuff
install(TARGETS hellosfml DESTINATION bin)
