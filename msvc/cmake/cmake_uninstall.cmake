#################################################################################
#
# This file is a part of CMake build configuration of GEOS library
#
# Defines commands used by make uninstall target of CMake build configuration.
#
# Author: Credit to the CMake mailing list archives for providing this solution. 
# Modifications: Mateusz Loskot <mateusz@loskot.net>
#
#################################################################################
if(NOT EXISTS "D:/Development/op3d_active/geos-3.5.0/msvc/install_manifest.txt")
  message(FATAL_ERROR 
    "Cannot find install manifest:
    D:/Development/op3d_active/geos-3.5.0/msvc/install_manifest.txt")
endif()

file(READ "D:/Development/op3d_active/geos-3.5.0/msvc/install_manifest.txt" files)
string(REGEX REPLACE "\n" ";" files "${files}")

set(GEOS_INCLUDE_DIR)
foreach(file ${files})

  if(${file} MATCHES "geos.h")
    get_filename_component(GEOS_INCLUDE_DIR ${file} PATH)
  endif()

  message(STATUS "Uninstalling $ENV{DESTDIR}${file}")
  if(NOT EXISTS "$ENV{DESTDIR}${file}")
    message(STATUS "File \"$ENV{DESTDIR}${file}\" does not exist.")
    message(STATUS "\tTrying to execute remove command anyway.")
  endif()

  exec_program("C:/Program Files (x86)/CMake 2.8/bin/cmake.exe" ARGS "-E remove \"$ENV{DESTDIR}${file}\""
    OUTPUT_VARIABLE rm_out
    RETURN_VALUE rm_retval)
  if(NOT "${rm_retval}" STREQUAL 0)
    message(FATAL_ERROR "Problem when removing \"$ENV{DESTDIR}${file}\"")
  endif()
endforeach()

message(STATUS "Deleting ${GEOS_INCLUDE_DIR} directory")
exec_program("C:/Program Files (x86)/CMake 2.8/bin/cmake.exe" 
  ARGS "-E remove_directory \"${GEOS_INCLUDE_DIR}\""
  OUTPUT_VARIABLE rm_out
  RETURN_VALUE rm_retval)
if(NOT "${rm_retval}" STREQUAL 0)
  message(FATAL_ERROR "Problem when removing \"${GEOS_INCLUDE_DIR}\"")
endif()
