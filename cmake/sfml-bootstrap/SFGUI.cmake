if(EXISTS "${CMAKE_SOURCE_DIR}/${SFMLBOOTSTRAP_EXTERNAL_DIR}/sfgui" AND IS_DIRECTORY "${CMAKE_SOURCE_DIR}/${SFMLBOOTSTRAP_EXTERNAL_DIR}/sfgui")
        set(SFGUI_CMAKE_ARGS "-DSFML_ROOT=${PROJ_BUILD_DIR}" "-DCMAKE_INSTALL_PREFIX=${PROJ_BUILD_DIR}" "-DCMAKE_BUILD_TYPE=${CMAKE_BUILD_TYPE}" "-DSFGUI_BUILD_SHARED_LIBS=FALSE" "-DSFML_STATIC_LIBRARIES=TRUE" "-DSFGUI_BUILD_EXAMPLES=FALSE")
	ExternalProject_Add(sfgui
          PREFIX "${PROJ_BUILD_DIR}/${SFMLBOOTSTRAP_EXTERNAL_DIR}/sfgui"
          SOURCE_DIR "${CMAKE_SOURCE_DIR}/${SFMLBOOTSTRAP_EXTERNAL_DIR}/sfgui"
          INSTALL_DIR "${PROJ_BUILD_DIR}"
          CMAKE_ARGS "${SFGUI_CMAKE_ARGS}"
	)
        ExternalProject_Add_Step(sfgui forcebuild COMMAND ${CMAKE_COMMAND} -E echo "Force build of sfgui" DEPENDEES configure DEPENDERS build ALWAYS 1)
        include_directories(${CMAKE_SOURCE_DIR}/${SFMLBOOTSTRAP_EXTERNAL_DIR}/sfgui/include)
        add_dependencies(sfgui sfml)
        set(SFGUI_LIBS debug ${PROJ_BUILD_DIR}/lib/${CMAKE_STATIC_LIBRARY_PREFIX}sfgui-s-d${CMAKE_STATIC_LIBRARY_SUFFIX} optimized ${PROJ_BUILD_DIR}/lib/${CMAKE_STATIC_LIBRARY_PREFIX}sfgui-s${CMAKE_STATIC_LIBRARY_SUFFIX})
        list(APPEND PROJ_LIBS ${SFGUI_LIBS})
        list(APPEND PROJ_DEPS sfgui)
endif()