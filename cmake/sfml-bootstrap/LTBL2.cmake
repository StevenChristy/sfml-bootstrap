if(EXISTS "${CMAKE_SOURCE_DIR}/${SFMLBOOTSTRAP_EXTERNAL_DIR}/ltbl2/LTBL2" AND IS_DIRECTORY "${CMAKE_SOURCE_DIR}/${SFMLBOOTSTRAP_EXTERNAL_DIR}/ltbl2/LTBL2")
        set(LTBL2_CMAKE_ARGS "-DCMAKE_INSTALL_PREFIX=${PROJ_BUILD_DIR}" "-DSFML_ROOT=${PROJ_BUILD_DIR}" "-DSFML_STATIC_LIBRARIES=TRUE" "-DCMAKE_BUILD_TYPE=${CMAKE_BUILD_TYPE}")
	ExternalProject_Add(ltbl2
          PREFIX "${PROJ_BUILD_DIR}/${SFMLBOOTSTRAP_EXTERNAL_DIR}/ltbl2/LTBL2"
          SOURCE_DIR "${CMAKE_SOURCE_DIR}/${SFMLBOOTSTRAP_EXTERNAL_DIR}/ltbl2/LTBL2"
          INSTALL_DIR "${PROJ_BUILD_DIR}"
          CMAKE_ARGS "${LTBL2_CMAKE_ARGS}"
	)
        ExternalProject_Add_Step(ltbl2 forcebuild COMMAND ${CMAKE_COMMAND} -E echo "Force build of ltbl2" DEPENDEES configure DEPENDERS build ALWAYS 1)
	add_dependencies(ltbl2 ${PROJ_DEPS})
        include_directories(${CMAKE_SOURCE_DIR}/${SFMLBOOTSTRAP_EXTERNAL_DIR}/ltbl2/LTBL2/include)
        set(LTBL2_LIBS debug ${PROJ_BUILD_DIR}/lib/${CMAKE_STATIC_LIBRARY_PREFIX}LTBL2-s-d${CMAKE_STATIC_LIBRARY_SUFFIX} optimized ${PROJ_BUILD_DIR}/lib/${CMAKE_STATIC_LIBRARY_PREFIX}LTBL2-s${CMAKE_STATIC_LIBRARY_SUFFIX})
        list(APPEND PROJ_LIBS ${LTBL2_LIBS})
        list(APPEND PROJ_DEPS ltbl2)
endif()
