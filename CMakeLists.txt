project(SFMLHelloWorld)

# minimum version for sfml-bootstrap is 2.8, but by default I want to be targeting C++14 for my future projects. You can easily change this to whatever you want.
cmake_minimum_required(VERSION 3.1.0 FATAL_ERROR)
set(CMAKE_CXX_STANDARD 14)

# This configuration file sets up all supported external libraries. See external/README.md for a list of those libraries.
# Additional variables:
# SFMLBOOTSTRAP_EXTERNAL_DIR = The subfolder that we'll be looking for our external libs in. Defaults to "external"
# You can change this but do not include a leading or trailing slash - no absolute paths for this variable. Sorry!
# To disable cleaning of external libs on a make clean, you can set SFMLBOOTSTRAP_EXTERNAL_DIR to any non-blank value including "external"
include(cmake/sfml-bootstrap/Main.cmake)

# basic stuff
set(SRC_FILES src/main.cpp)
add_executable(hellosfml ${SRC_FILES})

# Important! PROJ_LIBS was constructed by the sfml-bootstrap cmake files to contain any supported libraries lib files.
# Libs will be listed in the correct order for those compilers that care about ordering.
# other defines setup in the form of <LIBNAME>_LIBS - ex: SFML_LIBS SYSTEM_LIBS TGUI_LIBS but these are already included in PROJ_LIBS
target_link_libraries(hellosfml ${PROJ_LIBS})

# Important! Tell CMake what external libs we're using
add_dependencies(hellosfml ${PROJ_DEPS})

# TODO: Don't forget to set your install rules for a minimum make install. The below rule would be the minimum for a basic install that required no resource files.
# install(TARGETS hellosfml DESTINATION bin) - copies to /usr/local/bin
