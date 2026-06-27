cmake_minimum_required(VERSION 3.16)
project(ssss VERSION 0.1 LANGUAGES CXX)

set(CMAKE_CXX_STANDARD_REQUIRED ON)

# Köhnə find_package sətirlərini sil və bunu yaz:
find_package(Qt6 REQUIRED COMPONENTS Quick)

qt_standard_project_setup()

qt_add_executable(appssss
    main.cpp
)

qt_add_qml_module(appssss
    URI ssss
    VERSION 1.0
    QML_FILES
        Main.qml
        LoginPage.qml
        MainPage.qml
)

set_target_properties(appssss PROPERTIES
    MACOSX_BUNDLE_BUNDLE_VERSION ${PROJECT_VERSION}
    MACOSX_BUNDLE_SHORT_VERSION_STRING ${PROJECT_VERSION_MAJOR}.${PROJECT_VERSION_MINOR}
    MACOSX_BUNDLE TRUE
    WIN32_EXECUTABLE TRUE
)

target_link_libraries(appssss
    PRIVATE Qt6::Quick
)

include(GNUInstallDirs)
install(TARGETS appssss
    BUNDLE DESTINATION .
    LIBRARY DESTINATION ${CMAKE_INSTALL_LIBDIR}
    RUNTIME DESTINATION ${CMAKE_INSTALL_BINDIR}
)
