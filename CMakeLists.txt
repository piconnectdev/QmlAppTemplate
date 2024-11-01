cmake_minimum_required(VERSION 3.20)

project(QmlAppTemplate VERSION 0.8 LANGUAGES CXX)

set(CMAKE_CXX_STANDARD 17)
set(CMAKE_CXX_STANDARD_REQUIRED ON)
set(CMAKE_AUTOMOC ON)
set(CMAKE_AUTORCC ON)

string(TIMESTAMP CURRENT_TIMESTAMP "%s" UTC)
set(APP_NAME ${CMAKE_PROJECT_NAME})
set(APP_VERSION ${CMAKE_PROJECT_VERSION})
set(APP_VERSION_CODE ${TIMESTAMP})

################################################################################

message(STATUS "[CMAKE] CMAKE_VERSION               = ${CMAKE_VERSION}")
message(STATUS "[CMAKE] CMAKE_PREFIX_PATH           = ${CMAKE_PREFIX_PATH}")
message(STATUS "[SYSTEM] (HOST) SYSTEM NAME         = ${CMAKE_HOST_SYSTEM_NAME}")
message(STATUS "[SYSTEM] (HOST) SYSTEM VERSION      = ${CMAKE_HOST_SYSTEM_VERSION}")
message(STATUS "[SYSTEM] (TARGET) SYSTEM NAME       = ${CMAKE_SYSTEM_NAME}")
message(STATUS "[SYSTEM] (TARGET) SYSTEM VERSION    = ${CMAKE_SYSTEM_VERSION}")
message(STATUS "[PROJECT] SOURCE_DIR                = ${CMAKE_SOURCE_DIR}")
message(STATUS "[PROJECT] BUILD_TYPE                = ${CMAKE_BUILD_TYPE}")
message(STATUS "[PROJECT] TOOLCHAIN_FILE            = ${CMAKE_TOOLCHAIN_FILE}")
message(STATUS "[PROJECT] QT_HOST_PATH              = ${QT_HOST_PATH}")

################################################################################

find_package(Qt6 REQUIRED COMPONENTS Core Gui Qml Quick QuickControls2 Svg)
find_package(Qt6 REQUIRED COMPONENTS LinguistTools)

qt_standard_project_setup(REQUIRES 6.7)

qt_policy(SET QTP0001 NEW)
qt_policy(SET QTP0002 NEW)
qt_policy(SET QTP0003 NEW)
#qt_policy(SET QTP0004 NEW) # Qt 6.8

qt_add_executable(${CMAKE_PROJECT_NAME}
    src/main.cpp
    src/SettingsManager.cpp src/SettingsManager.h
    assets/assets.qrc
    assets/icons/IconLibrary.qrc
)

qt_add_qml_module(${CMAKE_PROJECT_NAME}
    URI ${CMAKE_PROJECT_NAME}
    QML_FILES
        qml/MobileApplication.qml
        qml/MobileHeader.qml
        qml/MobileDrawer.qml
        qml/MobilePermissions.qml
        qml/MobileMenu.qml
        qml/MobileExit.qml

        qml/DesktopApplication.qml
        qml/DesktopHeader.qml
        qml/DesktopSidebar.qml

        qml/ScreenMainView.qml
        qml/ScreenMobileComponents.qml
        qml/ScreenDesktopComponents.qml
        qml/ScreenPlayground.qml
        qml/ScreenFontInfos.qml
        qml/ScreenHostInfos.qml
        qml/ScreenSettings.qml
        qml/ScreenAbout.qml

        qml/PageButtons.qml
        qml/PageColors.qml
        qml/PageDateTime.qml
        qml/PageDialogs.qml
        qml/PageIndicators.qml
        qml/PageSelectors.qml
        qml/PageSliders.qml
        qml/PageTextFields.qml
        qml/PageTickers.qml

        qml/popups/PopupMessage.qml
        qml/popups/PopupChoice.qml
        qml/popups/PopupDate.qml
        qml/popups/PopupTime.qml
)

target_include_directories(${CMAKE_PROJECT_NAME} PRIVATE src/)
target_include_directories(${CMAKE_PROJECT_NAME} PRIVATE thirdparty/)

################################################################################

qt_standard_project_setup(
    I18N_SOURCE_LANGUAGE en
    I18N_TRANSLATED_LANGUAGES fr
)
qt_add_translations(${CMAKE_PROJECT_NAME}
    TS_FILE_BASE ${CMAKE_PROJECT_NAME}
    TS_FILE_DIR ${CMAKE_SOURCE_DIR}/i18n/
    RESOURCE_PREFIX "/i18n"
)

################################################################################

# ComponentLibrary
add_subdirectory(thirdparty/ComponentLibrary)
target_link_libraries(${CMAKE_PROJECT_NAME} PRIVATE ComponentLibraryplugin)

# QML module import path for ComponentLibrary ???
#set(QML_IMPORT_PATH "${CMAKE_SOURCE_DIR}/thirdparty/" CACHE STRING "ComponentLibraryPaths" FORCE)
#include_directories(QML_IMPORT_PATH)

# AppUtils
set(UTILS_DOCK_ENABLED true)
add_subdirectory(thirdparty/AppUtils)
target_link_libraries(${CMAKE_PROJECT_NAME} PRIVATE AppUtils)

# MobileUI
add_subdirectory(thirdparty/MobileUI)
target_link_libraries(${CMAKE_PROJECT_NAME} PRIVATE MobileUI)

# SingleApplication
set(QAPPLICATION_CLASS QGuiApplication)
add_subdirectory(thirdparty/SingleApplication)
target_link_libraries(${CMAKE_PROJECT_NAME} PRIVATE SingleApplication)

# Qt
target_link_libraries(${CMAKE_PROJECT_NAME} PRIVATE
    Qt6::Core
    Qt6::Gui
    Qt6::Qml
    Qt6::Quick
    Qt6::QuickControls2
    Qt6::Svg
)

################################################################################

## Android
if (CMAKE_SYSTEM_NAME STREQUAL "Android")
    set_target_properties(${CMAKE_PROJECT_NAME} PROPERTIES
        #QT_ANDROID_ABIS "armeabi-v7a;arm64-v8a;x86;x86_64"
        #QT_ANDROID_BUILD_ALL_ABIS ON
        QT_ANDROID_MIN_SDK_VERSION 23
        QT_ANDROID_TARGET_SDK_VERSION 35
        QT_ANDROID_PACKAGE_SOURCE_DIR "${CMAKE_SOURCE_DIR}/assets/android/"
    )
endif()

#if (APPLE)
#    set(CMAKE_XCODE_ATTRIBUTE_CODE_SIGNING_REQUIRED "NO")
#    set(CMAKE_XCODE_ATTRIBUTE_CODE_SIGN_IDENTITY "")
#    set(CMAKE_XCODE_ATTRIBUTE_DEVELOPMENT_TEAM "")
#    set(CMAKE_XCODE_ATTRIBUTE_PROVISIONING_PROFILE "")
#endif()

## macOS
if (CMAKE_SYSTEM_NAME STREQUAL "Darwin")
    set_target_properties(${CMAKE_PROJECT_NAME} PROPERTIES
        MACOSX_BUNDLE ON
    )

    set(CMAKE_XCODE_ATTRIBUTE_PRODUCT_BUNDLE_IDENTIFIER "io.emeric.qmlapptemplate")
    set(CMAKE_XCODE_ATTRIBUTE_MARKETING_VERSION "${CMAKE_PROJECT_VERSION}")

    set(CMAKE_OSX_ARCHITECTURES "x86_64;arm64")
    set(CMAKE_OSX_DEPLOYMENT_TARGET "11.0")
    set(CMAKE_XCODE_ATTRIBUTE_INFOPLIST_FILE "${CMAKE_SOURCE_DIR}/assets/macos/Info.plist")
    set(CMAKE_XCODE_ATTRIBUTE_CODE_SIGN_ENTITLEMENTS "${CMAKE_SOURCE_DIR}/assets/macos/${CMAKE_PROJECT_NAME}.entitlements")
endif()

## iOS
if (CMAKE_SYSTEM_NAME STREQUAL "iOS")
    set(CMAKE_OSX_ARCHITECTURES "arm64")
    set(CMAKE_OSX_SYSROOT "iphoneos")
    set(CMAKE_OSX_DEPLOYMENT_TARGET "14.0")
    set(CMAKE_XCODE_ATTRIBUTE_IPHONEOS_DEPLOYMENT_TARGET "14.0")
    set(CMAKE_XCODE_ATTRIBUTE_TARGETED_DEVICE_FAMILY "1,2") # iPhone,iPad
    set(CMAKE_XCODE_ATTRIBUTE_INFOPLIST_FILE "${CMAKE_SOURCE_DIR}/assets/ios/Info.plist")

    set_target_properties(${CMAKE_PROJECT_NAME} PROPERTIES
        MACOSX_BUNDLE ON
        MACOSX_BUNDLE_INFO_PLIST "${CMAKE_SOURCE_DIR}/assets/ios/Info.plist"
        # Qt
        QT_IOS_LAUNCH_SCREEN "${CMAKE_SOURCE_DIR}/assets/ios/LaunchScreen.storyboard"
        # WIP # Old way ???
        MACOSX_BUNDLE_GUI_IDENTIFIER            "io.emeric.qmlapptemplate"
        MACOSX_BUNDLE_BUNDLE_NAME               ${CMAKE_PROJECT_NAME}
        MACOSX_BUNDLE_BUNDLE_VERSION            ${CMAKE_PROJECT_VERSION}
        MACOSX_BUNDLE_SHORT_VERSION_STRING      ${PROJECT_VERSION_MAJOR}.${PROJECT_VERSION_MINOR}
        MACOSX_BUNDLE_COPYRIGHT                 "Copyright © 2024 Emeric Grange"
        # WIP # New Xcode attributes ???
        XCODE_ATTRIBUTE_PRODUCT_BUNDLE_IDENTIFIER "io.emeric.qmlapptemplate"
        XCODE_ATTRIBUTE_PRODUCT_NAME                        ${CMAKE_PROJECT_NAME}
        XCODE_ATTRIBUTE_CURRENT_PROJECT_VERSION             ${CMAKE_PROJECT_VERSION}
        XCODE_ATTRIBUTE_MARKETING_VERSION                   ${PROJECT_VERSION_MAJOR}.${PROJECT_VERSION_MINOR}
        XCODE_ATTRIBUTE_IPHONEOS_DEPLOYMENT_TARGET          "16.0"
        XCODE_ATTRIBUTE_TARGETED_DEVICE_FAMILY              "1,2"   # iPhone,iPad
        XCODE_ATTRIBUTE_ASSETCATALOG_COMPILER_APPICON_NAME "AppIcon"
    )
endif()

## Windows
if (WIN32)
    set_target_properties(${CMAKE_PROJECT_NAME} PROPERTIES
        WIN32_EXECUTABLE ON
    )
endif()

## Release build? Set "no debug" macros
if (CMAKE_BUILD_TYPE STREQUAL Release)
    target_compile_definitions(${CMAKE_PROJECT_NAME} PRIVATE
        NDEBUG
        QT_NO_DEBUG
        QT_NO_DEBUG_OUTPUT
    )
endif()

################################################################################

# Output?
set_target_properties(${CMAKE_PROJECT_NAME} PROPERTIES
    MACOSX_BUNDLE ON
    WIN32_EXECUTABLE ON
    #ARCHIVE_OUTPUT_DIRECTORY "${CMAKE_SOURCE_DIR}/lib"
    #LIBRARY_OUTPUT_DIRECTORY "${CMAKE_SOURCE_DIR}/lib"
    RUNTIME_OUTPUT_DIRECTORY "${CMAKE_SOURCE_DIR}/bin"
)

# Output?
install(TARGETS ${CMAKE_PROJECT_NAME}
    BUNDLE DESTINATION bin/
    LIBRARY DESTINATION ${CMAKE_INSTALL_LIBDIR}
)

################################################################################
