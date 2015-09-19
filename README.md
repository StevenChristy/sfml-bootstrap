# sfml-bootstrap

A simple system for quickly starting a new statically linked C++ project using SFML.

## Goals

I created this project mostly for myself. I hope you find it useful for your own projects. My personal goals were to make a simple foundation project that I can use if I want to play around with SFML. It must support the following objectives:

1. Static linking - I hate having to distribute dozens of shared libraries.
2. Ease of reuse - I don't want to have to customize my CMakeLists.txt for each project that uses a different set of SFML dependent libraries - easily switch out libraries by creating a symbolic link in the external folder.
3. No-hassle rebuilding and contributing - Make changes to the libraries source code and watch your project quickly rebuild and relink. Great for contributing back or making changes to your own fork.

## Setup New Project - Basic

Step 1: Download the latest version of this project into a new directory on your computer.

Step 2: Put your SFML source code in the external/sfml subfolder (tip: you must create the folder). See external/README.md for more details.

Step 3: Customize the existing CMakeLists.txt as you add source files for your project.

## Setup a New Github Project

Step 1: Create the github repository DO NOT include a README.md file.

Step 2: Execute some commands like this:

	git clone https://github.com/<myuser>/<mynewrepo>
	cd <mynewrepo>
	svn export https://github.com/StevenChristy/sfml-bootstrap/trunk . --force
	cd external
	git clone https://github.com/SFML/SFML sfml

Step 3: Update the README.md, edit the CMakeLists.txt and clean out the comments, add source code, etc.

Step 4: Use cmake generate your new project.

## Setup Existing Project (Not Recommended)

In an existing project there are many things that can go wrong. But assuming everything works fine, these are steps you'd follow:

Step 1: Copy the cmake/sfml-bootstrap folder into your project source directory.

Step 2: Create an external folder in your project source directory.

Step 3: Put your SFML source code in the external/sfml subfolder. Repeat this for any other library supported by this project.

Step 4: Edit your CMakeLists.txt file and add toward the top:

	include(cmake/sfml-bootstrap/Main.cmake)
	
Step 5: Add link libraries defined with ${PROJ_LIBS} for your project target(s), like:

	target_link_libraries(myexecutable ${PROJ_LIBS})
	
Step 6: Add dependency information with ${PROJ_DEPS} to help CMake figure out what to build:

	add_dependencies(myexecutable ${PROJ_DEPS})

## Currently Supported Platforms

* Linux - Tested on Ubuntu 15.10 - You will need to download and install sfml dependencies see SFML documentation for more details.
* Windows - MINGW - Works
* Windows - MSVC - Has issues - probably easily resolved, but I haven't had time to look at this.

## Future Platforms

A contributor will be needed to support these platforms:

* Mac
* Android
* iOS

Partial support should be in there by virtue of using the original unmodified versions of the SFML and other libraries. To the extent those libraries support your target OS you should find that there are only a few additional things you might need to add to your project to make it work for these systems. Specifically the cmake/sfml-bootstrap/*.cmake files will need to be modified to link in the correct libraries for the target OS and maybe specify other platform specific linker parameters.

Contributions in the form of a pull request or patch file are appreciated.

## Currently Supported Libraries

SFML, SFGUI, TGUI, libnoise, bullet2 - See external/README.md for more details.

## Notes

This project will never support dynamic linking. Contributions are welcome in the form of pull requests that add additional library, compiler, and OS support. Please contribute only cmake files for statically linking other libraries that might be used along side SFML - provided these libraries use a permissive non-copyleft open source license and cmake as their build system they will be graciously accepted. Contributors should update the documentation to reflect their project additions and add their name to the AUTHORS file.

## License

The cmake files included in this project are licensed under a zlib/png license, the same exact license used by SFML. See cmake/sfml-bootstrap/license.txt for more details.
