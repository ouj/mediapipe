function(process_deps deps result)
  file(RELATIVE_PATH RELATIVE_LIB_DIR ${CMAKE_SOURCE_DIR} ${CMAKE_CURRENT_LIST_DIR})
  set(${result} "")

  foreach(dep IN LISTS ${deps})
    if(dep MATCHES "^:")
      string(SUBSTRING "${dep}" 1 -1 LOCAL_DEP)
      string(REPLACE "/" "." LONG_DEP_NAME ${RELATIVE_LIB_DIR}/${LOCAL_DEP})
      list(APPEND result ${LONG_DEP_NAME})
    elseif(dep MATCHES "^//")
      string(SUBSTRING "${dep}" 2 -1 ABS_DEP)
      string(REPLACE "/" "." LONG_DEP_NAME ${ABS_DEP})
      string(REPLACE ":" "." LONG_DEP_NAME ${LONG_DEP_NAME})
      list(APPEND result ${LONG_DEP_NAME})
    elseif(dep MATCHES "^@")
      string(SUBSTRING "${dep}" 1 -1 THIRD_PARTY_DEP)
      list(APPEND result ${THIRD_PARTY_DEP})
    else()
      message(FATAL_ERROR "Unknown dependency format: ${dep}")
    endif()
  endforeach()

  set(${result} ${${result}} PARENT_SCOPE)
endfunction()

function(mediapipe_proto_library)
  cmake_parse_arguments(LIB
    "TESTONLY"
    "NAME"
    "SRCS;DEPS"
    ${ARGN}
  )

  file(RELATIVE_PATH RELATIVE_LIB_DIR ${CMAKE_SOURCE_DIR} ${CMAKE_CURRENT_LIST_DIR})
  string(REPLACE "/" "." LONG_TARGET_NAME "${RELATIVE_LIB_DIR}/${LIB_NAME}")

  set(_NAME ${LONG_TARGET_NAME})

  foreach(INPUT_FILE IN LISTS LIB_SRCS)
    list(APPEND PROTO_INPUTS ${CMAKE_CURRENT_LIST_DIR}/${INPUT_FILE})
    get_filename_component(PROTO_NAME ${INPUT_FILE} NAME_WE)
    list(APPEND PROTO_OUTPUTS ${PROTO_NAME}.pb.h ${PROTO_NAME}.pb.cc)
  endforeach()

  add_custom_command(
    OUTPUT ${PROTO_OUTPUTS}
    COMMAND $<TARGET_FILE:protobuf::protoc>
    ARGS --cpp_out ${CMAKE_BINARY_DIR}
         --proto_path ${CMAKE_SOURCE_DIR}
         --proto_path ${protocolbuffers_SOURCE_DIR}/src
         ${PROTO_INPUTS}
    DEPENDS ${PROTO_INPUTS}
  )
  add_library(${_NAME}
    ${PROTO_OUTPUTS}
  )

  target_include_directories(${_NAME} PUBLIC ${CMAKE_BINARY_DIR})

  process_deps(LIB_DEPS DEPS)
  target_link_libraries(${_NAME} PUBLIC protobuf::libprotobuf ${DEPS})
endfunction()


function(cc_library)
  cmake_parse_arguments(LIB
    "TESTONLY"
    "NAME"
    "SRCS;HDRS;WINDOWS_SRCS;APPLE_SRCS;DEPS"
    ${ARGN}
  )

  file(RELATIVE_PATH RELATIVE_LIB_DIR ${CMAKE_SOURCE_DIR} ${CMAKE_CURRENT_LIST_DIR})
  string(REPLACE "/" "." LONG_TARGET_NAME "${RELATIVE_LIB_DIR}/${LIB_NAME}")

  set(_NAME ${LONG_TARGET_NAME})
  add_library(${_NAME} 
    ${LIB_HDRS} 
    ${LIB_SRCS}
  )
  if(WIN32)
    target_sources(${_NAME} PRIVATE ${LIB_WINDOWS_SOURCES})
  elseif(APPLE)
    target_sources(${_NAME} PRIVATE ${LIB_APPLE_SOURCES})
  endif()
  set_target_properties(${_NAME} PROPERTIES LINKER_LANGUAGE CXX)

  target_include_directories(${_NAME} PUBLIC ${CMAKE_SOURCE_DIR})

  process_deps(LIB_DEPS DEPS)
  target_link_libraries(${_NAME} PUBLIC ${DEPS})
endfunction()
