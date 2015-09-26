if(EXISTS "${CMAKE_SOURCE_DIR}/${SFMLBOOTSTRAP_EXTERNAL_DIR}/libnoise" AND IS_DIRECTORY "${CMAKE_SOURCE_DIR}/${SFMLBOOTSTRAP_EXTERNAL_DIR}/libnoise")
        set(LIBNOISE_CMAKE_ARGS -DCMAKE_INSTALL_PREFIX=${PROJ_BUILD_DIR} -DCMAKE_BUILD_TYPE=${CMAKE_BUILD_TYPE} -DLIBNOISE_BUILD_SHARED_LIBS=FALSE)
        ExternalProject_Add(libnoise
          PREFIX "${PROJ_BUILD_DIR}/${SFMLBOOTSTRAP_EXTERNAL_DIR}/libnoise"
          SOURCE_DIR "${CMAKE_SOURCE_DIR}/${SFMLBOOTSTRAP_EXTERNAL_DIR}/libnoise"
          INSTALL_DIR "${PROJ_BUILD_DIR}"
          CMAKE_ARGS "${LIBNOISE_CMAKE_ARGS}"
        )
        ExternalProject_Add_Step(libnoise forcebuild COMMAND ${CMAKE_COMMAND} -E echo "Force build of libnoise" DEPENDEES configure DEPENDERS build ALWAYS 1)
        if(PROJ_DEPS)
            add_dependencies(libnoise ${PROJ_DEPS})
        endif()
        # Specify absolute paths to these libraries so that if they are rebuilt our application will relink.
        set(LIBNOISE_LIBS
                ${PROJ_BUILD_DIR}/lib/${CMAKE_STATIC_LIBRARY_PREFIX}noise${CMAKE_STATIC_LIBRARY_SUFFIX}
        )
        include_directories(${PROJECT_SOURCE_DIR}/${SFMLBOOTSTRAP_EXTERNAL_DIR}/libnoise/include)
        list(APPEND PROJ_DEPS libnoise)
        list(APPEND PROJ_LIBS ${LIBNOISE_LIBS} ${SYSTEM_LIBS})
endif()
