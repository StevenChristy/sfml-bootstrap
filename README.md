# sfml-bootstrap

A simple system for quickly starting a new statically linked C++ project using SFML.

## Goals

I created this project mostly for myself. I hope you find it useful for your own projects. My personal goals were to make a simple foundation project that I can use if I want to play around with SFML. It must support the following objectives:

1. Static linking - I hate having to distribute dozens of shared libraries.
2. Ease of reuse - I don't want to have to customize my CMakeLists.txt for each project that uses a different set of SFML dependent libraries - easily switch out libraries by creating a symbolic link in the external folder.
3. No-hassle rebuilding and contributing - Make changes to the libraries source code and watch your project quickly rebuild and relink. Great for contributing back or making changes to your own fork.

## Using the bootstrap - New Project

Step 1: Download the latest version of this project into a new directory on your computer.

Step 2: Put your SFML source code in the external/sfml subfolder (tip: you must create the folder). See external/README.md for more details.

Step 3: Customize the existing CMakeLists.txt as you add source files for your project.

## Using the bootstrap - Existing Project (Not Recommended)

In an existing project there are many things that can go wrong. But assuming everything works fine, these are steps you'd follow:

Step 1: Copy the cmake/sfml-bootstrap folder into your project.

Step 2: Create an external folder in your project source directory.

Step 3: Put your SFML source code in the external/sfml subfolder. Repeat this for any other library supported by this project.

Step 4: Edit your CMakeLists.txt file and add toward the top:

	include(cmake/sfml-bootstrap/Main.cmake)
	
Step 5: Add link libraries defined with ${PROJ_LIBS} for your project target(s), like:

	target_link_libraries(myexecutable ${PROJ_LIBS})
	
Step 6: Add dependency information with ${PROJ_DEPS} to help CMake figure out what to build:

	add_dependencies(myexecutable ${PROJ_DEPS})

## Currently Supported Platforms

Linux - Tested on Ubuntu 15.10 - You will need to download and install sfml dependencies see SFML documentation for more details.

Windows - Untested - The conditionals are in there, but it needs to be tested. I'll get around to it later, but Windows is not my personal choice for an OS. Will support both mingw and MSVC.

## Future Platforms

Ideally a contributor will be needed to claim support these platforms:

Mac
Android
iOS

Partial support should be in there by virtue of using the original unmodified versions of the SFML and other libraries. To the extent those libraries support your target OS you should find that there are only a few additional things you might need to add to your project to make it work for these systems. Specifically the cmake/sfml-bootstrap/*.cmake files will need to be modified to link in the correct libraries for the target OS and maybe specify other platform specific linker parameters.

Contributions in the form of a pull request or patch file are appreciated.

## Currently Supported Libraries

SFML, SFGUI, TGUI - See external/README.md for more details.

## Notes

This project will never support dynamic linking so please don't make requests for it. Other requests will be considered. Feel free to contribute cmake files for statically linking other libraries that might be used along side SFML - provided these libraries use a permissive non-copyleft license.
