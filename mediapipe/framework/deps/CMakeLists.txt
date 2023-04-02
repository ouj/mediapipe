
mediapipe_proto_library(
  NAME
    proto_descriptor_proto
  SRCS 
    proto_descriptor.proto
)

cc_library(
  NAME
    aligned_malloc_and_free
  HDRS
    aligned_malloc_and_free.h
)

cc_library(
  NAME
    cleanup
  HDRS
    cleanup.h
  DEPS
    @absl::base
)

cc_library(
  NAME 
    clock
  HDRS
    clock.h
    monotonic_clock.h
  SRCS
    clock.cc
    monotonic_clock.cc
  DEPS
    @absl::base
    @absl::synchronization
    @absl::time
    //mediapipe/framework/port:logging
)


cc_library(
  NAME
    intops
  HDRS
    safe_int.h
    strong_int.h
  DEPS
    //mediapipe/framework/port
    //mediapipe/framework/port:integral_types
    //mediapipe/framework/port:logging
    @absl::base
)

cc_library(
  NAME
    image_resizer
  HDRS
    image_resizer.h
  DEPS
    //mediapipe/framework/port:opencv_imgproc

)

cc_library(
  NAME
    map_util
  HDRS
    map_util.h
  DEPS
    //mediapipe/framework/port:logging
)

cc_library(
  NAME
    mathutil
  HDRS
    mathutil.h
  DEPS
    //mediapipe/framework/port:integral_types
    //mediapipe/framework/port:logging
)

cc_library(
  NAME
    numbers
  HDRS
    numbers.h
  DEPS
    //mediapipe/framework/port:integral_types
    @absl::strings
)

cc_library(
  NAME
    no_destructor
  HDRS
    no_destructor.h
)

cc_library(
  NAME
    point
  HDRS
    point2.h
  DEPS
    :mathutil
    :vector
    //mediapipe/framework/port:integral_types
    //mediapipe/framework/port:logging
)

cc_library(
  NAME
    random
  HDRS
    random_base.h
  DEPS
    //mediapipe/framework/port:integral_types
)

cc_library(
  NAME
    rectangle
  HDRS
    rectangle.h
  DEPS
    :point
    :vector
    //mediapipe/framework/port:integral_types
    //mediapipe/framework/port:logging
)

cc_library(
  NAME
    registration_token
  SRCS
    registration_token.cc
  HDRS
    registration_token.h
)

cc_library(
  NAME
    registration
  SRCS
    registration.cc
  HDRS
    registration.h
  DEPS
    :registration_token
    //mediapipe/framework/port:logging
    //mediapipe/framework/port:status
    //mediapipe/framework/port:statusor
    @absl::base
    @absl::flat_hash_map
    @absl::flat_hash_set
    @absl::meta
    @absl::strings
    @absl::synchronization
)

cc_library(
  NAME
    singleton
  HDRS
    singleton.h
  DEPS
    @absl::synchronization
)

cc_library(
  NAME
    source_location
  HDRS
    source_location.h
)

cc_library(
  NAME
    status
  SRCS
    status.cc
    status_builder.cc
  HDRS
    canonical_errors.h
    status.h
    status_builder.h
    status_macros.h
  DEPS
    :source_location
    //mediapipe/framework/port:logging
    @absl::base
    @absl::memory
    @absl::status
    @absl::strings
)

cc_library(
  NAME
    re2
  HDRS
    re2.h
)

cc_library(
  NAME
    ret_check
  SRCS
    ret_check.cc
  HDRS
    ret_check.h
  DEPS
    :status
    @absl::base
)

cc_library(
  NAME
    thread_options
  HDRS
    thread_options.h
)

cc_library(
  NAME
    threadpool
  WINDOWS_SRCS
    threadpool_std_thread_impl.cc
  APPLE_SRCS
    threadpool_pthread_impl.cc
  HDRS
    threadpool.h
  DEPS
    :thread_options
    //mediapipe/framework/port:logging
    @absl::strings
    @absl::synchronization
)

cc_library(
  NAME
    topologicalsorter
  SRCS
    topologicalsorter.cc
  HDRS
    topologicalsorter.h
  DEPS
    //mediapipe/framework/port:logging
)

cc_library(
  NAME
    vector
  HDRS
    vector.h
  DEPS
    //mediapipe/framework/port:integral_types
    //mediapipe/framework/port:logging
    @absl::utility
)