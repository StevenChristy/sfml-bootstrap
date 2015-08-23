# The External Folder

The purpose of the external folder is to provide a simple location for the SFML source and other external support libraries. To use the sfml-bootstrap you will download the sfml source and either place it in the sfml subdirectory (which you will create) or create a symbolic link to your already downloaded SFML source directory.

Example - To create your sfml subfolder you might execute a command like:

	git clone https://github.com/SFML/SFML sfml

OR

	ln -s <my sfml source dir> sfml

## Mini-FAQ

### What do I put in the external folder?

You will need to create subfolders containing the project source code for each library you wish to use. For example, at minimum a working sfml project will need sfml. So, SFML source code must be directly inside the sfml subfolder. So you should have a folder like:

MyProject/external/sfml

### How does the sfml-bootstrap work?

The SFML bootstrap contains some cmake files that are already configured for certain libraries. Your Project's CMakeLists.txt will need to have a line like:

include(cmake/sfml-bootstrap/Main.cmake)

This include will include the other cmake files in the sfml-bootstrap/cmake subfolder. The sfml-bootstrap comes preconfigured for a few different libraries. When you place source code or create a symbolic link in the external folder then your project will be configured automatically to use that library. For more information read the CMakeLists.txt file included with this project. I've added comments to provide additional details.

NOTE: On Linux the subfolder name is case sensitive.

### What libraries are supported?

This version of the sfml-bootstrap project supports the following:

#### SFML Library - Required
Subfolder Name: sfml
Git URL: https://github.com/SFML/SFML

#### SFGUI - Optional
Subfolder Name: sfgui
Git URL: https://github.com/TankOs/SFGUI

#### TGUI - Optional
Subfolder Name: tgui
Git URL: https://github.com/texus/TGUI