cmake_minimum_required(VERSION 3.26)

set(SUPPORTED_LANGUAGES CXX C)
if (APPLE)
    list(APPEND SUPPORTED_LANGUAGES OBJC OBJCXX)
endif(APPLE)

project(
    mediapipe
    VERSION 0.0.0
    DESCRIPTION "Google Mediapipe"
    LANGUAGES ${SUPPORTED_LANGUAGES}
)

if(APPLE)
  # Set this up earlier so dependency are built properly
  set(CMAKE_OSX_ARCHITECTURES "arm64;x86_64")
  set(CMAKE_OSX_DEPLOYMENT_TARGET 12.3)

  # Create debug symbols
  set(CMAKE_XCODE_ATTRIBUTE_DEBUG_INFORMATION_FORMAT "dwarf-with-dsym")
  set(CMAKE_XCODE_ATTRIBUTE_CLANG_ENABLE_OBJC_ARC YES)
  set(CMAKE_XCODE_GENERATE_SCHEME YES)
elseif (WIN32)
  add_definitions(-DNOMINMAX)
endif()

if(CMAKE_PROJECT_NAME STREQUAL PROJECT_NAME)
  include(CTest)
endif()

# Setting CXX standards
set(MEDIAPIPE_CXX_STANDARD 20)
if(NOT CMAKE_CXX_STANDARD)
  set(CMAKE_CXX_STANDARD ${MEDIAPIPE_CXX_STANDARD})
elseif(CMAKE_CXX_STANDARD LESS ${MEDIAPIPE_CXX_STANDARD})
  message(FATAL_ERROR
    "mediapipe requires C++20. To ensure ABI compatibility"
    " build and link all targets of the project with the same"
    " version of C++."
  )
endif()
if(NOT CMAKE_OBJCXX_STANDARD)
  set(CMAKE_OBJCXX_STANDARD ${MEDIAPIPE_CXX_STANDARD})
elseif(CMAKE_OBJCXX_STANDARD LESS ${MEDIAPIPE_CXX_STANDARD})
  message(FATAL_ERROR
    "mediapipe requires C++20. To ensure ABI compatibility"
    " build and link all targets of the project with the same"
    " version of C++ for Objective C++."
  )
endif()

set(CMAKE_CXX_EXTENSIONS OFF)
set(CMAKE_OBJC_EXTENSIONS OFF)

include(FetchContent)
include(cmake/CPM.cmake)
include(cmake/Deps.cmake)
include(cmake/Helpers.cmake)
CPMUsePackageLock(package-lock.cmake)

add_definitions(-DMEDIAPIPE_DISABLE_GPU=1)

add_subdirectory(mediapipe)