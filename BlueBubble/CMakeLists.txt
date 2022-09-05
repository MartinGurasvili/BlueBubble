cmake_minimum_required(VERSION 3.18)

project(BlueBubble LANGUAGES CXX)

set(CMAKE_INCLUDE_CURRENT_DIR ON)
set(CMAKE_AUTOMOC ON)

find_package(Qt6 COMPONENTS Gui Qml Quick)
add_executable(BlueBubbleApp src/main.cpp)

find_package(Qt6 COMPONENTS Core5Compat REQUIRED)
target_link_libraries(BlueBubbleApp PUBLIC Qt6::Core5Compat)

qt_add_resources(BlueBubbleApp "configuration"
    PREFIX "/"
    FILES
        qtquickcontrols2.conf
)

target_link_libraries(BlueBubbleApp PRIVATE
    Qt${QT_VERSION_MAJOR}::Core
    Qt${QT_VERSION_MAJOR}::Gui
    Qt${QT_VERSION_MAJOR}::Quick
    Qt${QT_VERSION_MAJOR}::Qml
)

include(${CMAKE_CURRENT_SOURCE_DIR}/qmlmodules)
