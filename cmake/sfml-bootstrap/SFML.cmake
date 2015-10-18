if(EXISTS "${CMAKE_SOURCE_DIR}/${SFMLBOOTSTRAP_EXTERNAL_DIR}/sfml" AND IS_DIRECTORY "${CMAKE_SOURCE_DIR}/${SFMLBOOTSTRAP_EXTERNAL_DIR}/sfml")
        set(SFML_CMAKE_ARGS -DCMAKE_INSTALL_PREFIX=${PROJ_BUILD_DIR} -DCMAKE_BUILD_TYPE=${CMAKE_BUILD_TYPE} -DBUILD_SHARED_LIBS=FALSE -DSFML_USE_STATIC_STD_LIBS=TRUE)
        ExternalProject_Add(sfml
          PREFIX "${PROJ_BUILD_DIR}/${SFMLBOOTSTRAP_EXTERNAL_DIR}/sfml"
          SOURCE_DIR "${CMAKE_SOURCE_DIR}/${SFMLBOOTSTRAP_EXTERNAL_DIR}/sfml"
          INSTALL_DIR "${PROJ_BUILD_DIR}"
          CMAKE_ARGS "${SFML_CMAKE_ARGS}"
        )
        ExternalProject_Add_Step(sfml forcebuild COMMAND ${CMAKE_COMMAND} -E echo "Force build of sfml" DEPENDEES configure DEPENDERS build ALWAYS 1)
        if(PROJ_DEPS)
            add_dependencies(sfml ${PROJ_DEPS})
        endif()
        # Specify absolute paths to these libraries so that if they are rebuilt our application will relink.
        set(SFML_LIBS
                debug ${PROJ_BUILD_DIR}/lib/${CMAKE_STATIC_LIBRARY_PREFIX}sfml-audio-s-d${CMAKE_STATIC_LIBRARY_SUFFIX}
                debug ${PROJ_BUILD_DIR}/lib/${CMAKE_STATIC_LIBRARY_PREFIX}sfml-graphics-s-d${CMAKE_STATIC_LIBRARY_SUFFIX}
                debug ${PROJ_BUILD_DIR}/lib/${CMAKE_STATIC_LIBRARY_PREFIX}sfml-window-s-d${CMAKE_STATIC_LIBRARY_SUFFIX}
                debug ${PROJ_BUILD_DIR}/lib/${CMAKE_STATIC_LIBRARY_PREFIX}sfml-system-s-d${CMAKE_STATIC_LIBRARY_SUFFIX}
                debug ${PROJ_BUILD_DIR}/lib/${CMAKE_STATIC_LIBRARY_PREFIX}sfml-network-s-d${CMAKE_STATIC_LIBRARY_SUFFIX}
                optimized ${PROJ_BUILD_DIR}/lib/${CMAKE_STATIC_LIBRARY_PREFIX}sfml-audio-s${CMAKE_STATIC_LIBRARY_SUFFIX}
                optimized ${PROJ_BUILD_DIR}/lib/${CMAKE_STATIC_LIBRARY_PREFIX}sfml-graphics-s${CMAKE_STATIC_LIBRARY_SUFFIX}
                optimized ${PROJ_BUILD_DIR}/lib/${CMAKE_STATIC_LIBRARY_PREFIX}sfml-window-s${CMAKE_STATIC_LIBRARY_SUFFIX}
                optimized ${PROJ_BUILD_DIR}/lib/${CMAKE_STATIC_LIBRARY_PREFIX}sfml-system-s${CMAKE_STATIC_LIBRARY_SUFFIX}
                optimized ${PROJ_BUILD_DIR}/lib/${CMAKE_STATIC_LIBRARY_PREFIX}sfml-network-s${CMAKE_STATIC_LIBRARY_SUFFIX})
        include_directories(${PROJECT_SOURCE_DIR}/${SFMLBOOTSTRAP_EXTERNAL_DIR}/sfml/include)
        add_definitions(-DSFML_STATIC)
        if(UNIX)
                set(SYSTEM_LIBS GLEW GLU GL xcb X11-xcb xcb-image xcb-randr udev rt X11 Xext freetype jpeg FLAC ogg vorbisenc vorbisfile vorbis sndfile openal pthread)
        elseif(WIN32)
                if(MINGW)
                        link_directories(${CMAKE_SOURCE_DIR}/${SFMLBOOTSTRAP_EXTERNAL_DIR}/sfml/extlibs/libs-mingw/${CURRENT_ARCH})
                        set(SYSTEM_LIBS ws2_32 winmm opengl32 freetype jpeg FLAC openal32 ogg vorbisenc vorbisfile vorbis)
                elseif(MSVC)
                        link_directories(${CMAKE_SOURCE_DIR}/${SFMLBOOTSTRAP_EXTERNAL_DIR}/sfml/extlibs/libs-msvc/${CURRENT_ARCH})
                        set(SYSTEM_LIBS ws2_32 winmm opengl32 freetype jpeg flac openal32 ogg vorbisenc vorbisfile vorbis)
                endif()
        endif()
        list(APPEND PROJ_DEPS sfml)
        include(cmake/sfml-bootstrap/SFGUI.cmake)
        include(cmake/sfml-bootstrap/TGUI.cmake)
        include(cmake/sfml-bootstrap/LTBL2.cmake)
        list(APPEND PROJ_LIBS ${SFML_LIBS} ${SYSTEM_LIBS})
endif()
