# - Find Thrift (a cross platform RPC lib/tool)
# This module defines
#  Thrift_VERSION, version string of ant if found
#  Thrift_INCLUDE_DIR, where to find Thrift headers
#  Thrift_LIBS, Thrift libraries
#  Thrift_FOUND, If false, do not try to use ant

exec_program(env ARGS thrift -version OUTPUT_VARIABLE Thrift_VERSION
             RETURN_VALUE Thrift_RETURN)
if (Thrift_VERSION MATCHES "^Thrift version")
    message(STATUS "thrift found in default location.")
else ()
    message(STATUS "try to search thrift in ENV Thrift_ROOT_DIR.")
exec_program(env ARGS $ENV{Thrift_ROOT_DIR}/bin/thrift -version OUTPUT_VARIABLE Thrift_VERSION
             RETURN_VALUE Thrift_RETURN)
endif ()

find_path(Thrift_INCLUDE_DIR Thrift.h NO_DEFAULT_PATH PATHS
  /usr/local/include/thrift
  /opt/local/include/thrift
  /usr/include/thrift
  $ENV{Thrift_ROOT_DIR}/include/thrift
)

set(Thrift_LIB_PATHS  /usr/local/lib /opt/local/lib /usr/lib64)

find_library(Thrift_LIB NAMES thrift NO_DEFAULT_PATH PATHS ${Thrift_LIB_PATHS} $ENV{Thrift_ROOT_DIR}/lib)
#find_library(Thrift_NB_LIB NAMES thriftnb PATHS ${Thrift_LIB_PATHS})

if (Thrift_VERSION MATCHES "^Thrift version"
    AND Thrift_LIB #AND Thrift_NB_LIB
    AND Thrift_INCLUDE_DIR)
  set(Thrift_FOUND TRUE)
  set(Thrift_LIBS ${Thrift_LIB})
else ()
  set(Thrift_FOUND FALSE)
  message(STATUS "Thrift not found, please set the ENV Thrift_ROOT_DIR for search.")
endif ()

#if (Thrift_VERSION MATCHES "^Thrift version" AND LibEvent_LIBS
#    AND LibEvent_INCLUDE_DIR AND Thrift_LIB AND Thrift_NB_LIB
#    AND Thrift_INCLUDE_DIR)
#  set(Thrift_FOUND TRUE)
#  set(Thrift_LIBS ${Thrift_LIB} ${Thrift_NB_LIB})
#else ()
#  set(Thrift_FOUND FALSE)
#  if (NOT LibEvent_LIBS OR NOT LibEvent_INCLUDE_DIR)
#    message(STATUS "libevent is required for thrift broker support")
#  endif ()
#endif ()

if (Thrift_FOUND)
  if (NOT Thrift_FIND_QUIETLY)
    message(STATUS "Found thrift: ${Thrift_LIBS}")
    message(STATUS "    compiler: ${Thrift_VERSION}")
  endif ()
else ()
  message(STATUS "Thrift compiler/libraries NOT found. "
          "Thrift support will be disabled (${Thrift_RETURN}, "
          "${Thrift_INCLUDE_DIR}, ${Thrift_LIB}, ${Thrift_NB_LIB})")
endif ()

mark_as_advanced(
  Thrift_LIB
  #Thrift_NB_LIB
  Thrift_INCLUDE_DIR
  )
