# CPMAddPackage(
#   NAME googletest
#   GIT_REPOSITORY https://github.com/google/googletest.git
#   GIT_TAG v1.13.0
#   CACHE TRUE
#   EXCLUDE_FROM_ALL TRUE
#   OPTIONS
#     "CMAKE_GTEST_DISCOVER_TESTS_DISCOVERY_MODE=PRE_TEST"
#     "gtest_force_shared_crt=ON"
# )

CPMAddPackage(
  NAME absl
  VERSION 20230125.1
  URL https://github.com/abseil/abseil-cpp/archive/20230125.0.tar.gz
  EXCLUDE_FROM_ALL TRUE
  OPTIONS
    "ABSL_ENABLE_INSTALL OFF"
    "ABSL_RUN_TESTS OFF"
    "ABSL_CXX_STANDARD 20"
    "ABSL_PROPAGATE_CXX_STD ON"
    "ABSL_USE_GOOGLETEST_HEAD OFF"
)

CPMAddPackage(
  NAME protocolbuffers
  VERSION v3.19.1
  URL https://github.com/protocolbuffers/protobuf/releases/download/v3.19.1/protobuf-cpp-3.19.1.tar.gz
  DOWNLOAD_ONLY TRUE
  PATCH_COMMAND git apply ${CMAKE_SOURCE_DIR}/third_party/com_google_protobuf_fixes.diff
)
if(protocolbuffers_ADDED)
  set(protobuf_BUILD_TESTS OFF CACHE BOOL "" FORCE)
  set(protobuf_BUILD_EXAMPLES OFF CACHE BOOL "" FORCE)
  set(protobuf_WITH_ZLIB_DEFAULT OFF CACHE BOOL "" FORCE)
  set(protobuf_BUILD_PROTOC_BINARIES ON CACHE BOOL "" FORCE)
  add_subdirectory(${protocolbuffers_SOURCE_DIR}/cmake ${protocolbuffers_BINARY_DIR} EXCLUDE_FROM_ALL)
endif()

CPMAddPackage(
  NAME glog
  GITHUB_REPOSITORY google/glog
  GIT_TAG v0.6.0
  EXCLUDE_FROM_ALL TRUE
  OPTIONS
    "BUILD_SHARED_LIBS ON"
    "WITH_GFLAGS OFF"
    "WITH_GTEST OFF"
    "WITH_PKGCONFIG OFF"
)
