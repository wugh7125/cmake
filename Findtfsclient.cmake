IF(TFSCLIENT)
  SET(tfsclient_ROOT_DIR ${TFSCLIENT})
ELSE(TFSCLIENT)
  SET(tfsclient_ROOT_DIR $ENV{TFSCLIENT_ROOT})
ENDIF(TFSCLIENT)

INCLUDE(MacroFindPackageWithCache)

MACRO_FIND_PACKAGE_WITH_CACHE(
  tfsclient tfsclient tfs_client_api.h tfsclient 
  )

MARK_AS_ADVANCED(TFSCLIENT)

