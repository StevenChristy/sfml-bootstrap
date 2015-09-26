if(EXISTS "${CMAKE_SOURCE_DIR}/${SFMLBOOTSTRAP_EXTERNAL_DIR}/bullet2" AND IS_DIRECTORY "${CMAKE_SOURCE_DIR}/${SFMLBOOTSTRAP_EXTERNAL_DIR}/bullet2")
        set(BULLET2_CMAKE_ARGS -DCMAKE_INSTALL_PREFIX=${PROJ_BUILD_DIR} -DCMAKE_BUILD_TYPE=${CMAKE_BUILD_TYPE} -DBUILD_SHARED_LIBS=FALSE -DBUILD_BULLET2_DEMOS=FALSE -DBUILD_CPU_DEMOS=FALSE -DBUILD_BULLET3=FALSE -DBUILD_UNIT_TESTS=FALSE -DBUILD_EXTRAS=FALSE -DUSE_GLUT=FALSE)
        ExternalProject_Add(bullet2
          PREFIX "${PROJ_BUILD_DIR}/${SFMLBOOTSTRAP_EXTERNAL_DIR}/bullet2"
          SOURCE_DIR "${CMAKE_SOURCE_DIR}/${SFMLBOOTSTRAP_EXTERNAL_DIR}/bullet2"
          INSTALL_DIR "${PROJ_BUILD_DIR}"
          CMAKE_ARGS "${BULLET2_CMAKE_ARGS}"
        )
        ExternalProject_Add_Step(bullet2 forcebuild COMMAND ${CMAKE_COMMAND} -E echo "Force build of bullet2" DEPENDEES configure DEPENDERS build ALWAYS 1)
        if(PROJ_DEPS)
            add_dependencies(bullet2 ${PROJ_DEPS})
        endif()
        # Specify absolute paths to these libraries so that if they are rebuilt our application will relink.
        set(BULLET2_LIBS
                ${PROJ_BUILD_DIR}/lib/${CMAKE_STATIC_LIBRARY_PREFIX}BulletCollision${CMAKE_STATIC_LIBRARY_SUFFIX}
                ${PROJ_BUILD_DIR}/lib/${CMAKE_STATIC_LIBRARY_PREFIX}BulletDynamics${CMAKE_STATIC_LIBRARY_SUFFIX}
                ${PROJ_BUILD_DIR}/lib/${CMAKE_STATIC_LIBRARY_PREFIX}BulletSoftBody${CMAKE_STATIC_LIBRARY_SUFFIX}
                ${PROJ_BUILD_DIR}/lib/${CMAKE_STATIC_LIBRARY_PREFIX}LinearMath${CMAKE_STATIC_LIBRARY_SUFFIX}
        )
        include_directories(${PROJECT_SOURCE_DIR}/${SFMLBOOTSTRAP_EXTERNAL_DIR}/bullet2/include)
        list(APPEND PROJ_DEPS bullet2)
        list(APPEND PROJ_LIBS ${BULLET2_LIBS} ${SYSTEM_LIBS})
endif()
