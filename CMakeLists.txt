cmake_minimum_required(VERSION 3.18)
project(quantlib_moex LANGUAGES CXX)

# Build QuantLib statically from the submodule
set(CMAKE_CXX_STANDARD 17)
set(CMAKE_POSITION_INDEPENDENT_CODE ON)

# QuantLib configuration
set(QL_BUILD_BENCHMARK OFF CACHE BOOL "Build QuantLib benchmarks")
set(QL_BUILD_EXAMPLES OFF CACHE BOOL "Build QuantLib examples")
set(QL_BUILD_TEST_SUITE OFF CACHE BOOL "Build QuantLib test suite")
set(QL_ENABLE_SESSIONS OFF CACHE BOOL "Enable QuantLib sessions")
set(BUILD_SHARED_LIBS OFF CACHE BOOL "Build QuantLib as static library")

# Add QuantLib submodule
add_subdirectory(vendor/quantlib)

# Find SWIG and Python
find_package(SWIG 4.1 REQUIRED COMPONENTS python)

# For cibuildwheel and macOS, help CMake find Python correctly
if(DEFINED ENV{PYTHON})
    set(Python3_EXECUTABLE $ENV{PYTHON})
endif()

find_package(Python3 COMPONENTS Interpreter Development.Module REQUIRED)

# Debug: Print Python information
message(STATUS "Python3_FOUND: ${Python3_FOUND}")
message(STATUS "Python3_EXECUTABLE: ${Python3_EXECUTABLE}")
message(STATUS "Python3_INCLUDE_DIRS: ${Python3_INCLUDE_DIRS}")
message(STATUS "Python3_Development.Module_FOUND: ${Python3_Development.Module_FOUND}")
message(STATUS "Python3_VERSION: ${Python3_VERSION}")

# Include SWIG macros
include(UseSWIG)

# Set SWIG flags
set_property(SOURCE src/qlmoex/moex_gcurve.i PROPERTY CPLUSPLUS ON)
set_property(SOURCE src/qlmoex/moex_gcurve.i PROPERTY SWIG_MODULE_NAME _moex_gcurve)

# Create SWIG library
swig_add_library(moex_gcurve TYPE MODULE LANGUAGE python
                 SOURCES src/qlmoex/moex_gcurve.i
                         src/qlmoex/moex_gcurve.cpp)

# Add explicit dependency on QuantLib library
add_dependencies(moex_gcurve ql_library)

# Link libraries - QuantLib statically, Python dynamically
target_link_libraries(moex_gcurve PRIVATE ql_library Python3::Module)

# Include directories
target_include_directories(moex_gcurve PRIVATE 
    vendor/quantlib
    src/qlmoex
)

# Set output name
set_target_properties(moex_gcurve PROPERTIES OUTPUT_NAME "_moex_gcurve")

# Installation
install(TARGETS moex_gcurve LIBRARY DESTINATION qlmoex)
install(FILES src/qlmoex/__init__.py src/qlmoex/py.typed DESTINATION qlmoex)
