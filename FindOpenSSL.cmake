
IF (OpenSSL_INCLUDE_DIR)
  # Already in cache, be silent
  SET(OpenSSL_FIND_QUIETLY TRUE)
ENDIF (OpenSSL_INCLUDE_DIR)

FIND_PATH(OpenSSL_INCLUDE_DIR openssl/md5.h
  /usr/local/include
  /usr/include
)

FIND_LIBRARY(OpenSSL_LIBRARIES
  NAMES ssl
  PATHS /usr/lib /usr/local/lib /usr/lib64
)

FIND_LIBRARY(CRYPTO_LIBRARY
  NAMES
  crypto
  libcrypto
  eay
  eay32
  libeay
  libeay32
  PATHS /usr/lib /usr/local/lib /usr/lib64
)

IF (CRYPTO_LIBRARY)
  SET(OpenSSL_LIBRARIES
      ${CRYPTO_LIBRARY}
      ${OpenSSL_LIBRARIES}
     )
ENDIF (CRYPTO_LIBRARY)
IF (OpenSSL_INCLUDE_DIR AND OpenSSL_LIBRARIES)
  SET(OpenSSL_FOUND TRUE)
ELSE (OpenSSL_INCLUDE_DIR AND OpenSSL_LIBRARIES)
  SET(OpenSSL_FOUND FALSE)
ENDIF (OpenSSL_INCLUDE_DIR AND OpenSSL_LIBRARIES)


MARK_AS_ADVANCED(
  OpenSSL_LIBRARIES
  OpenSSL_INCLUDE_DIR
  )
