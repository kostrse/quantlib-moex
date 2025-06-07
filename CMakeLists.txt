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
find_package(Python3 COMPONENTS Development REQUIRED)

# Include SWIG macros
include(UseSWIG)

# Set SWIG flags
set_property(SOURCE src/qlmoex/moex_gcurve.i PROPERTY CPLUSPLUS ON)
set_property(SOURCE src/qlmoex/moex_gcurve.i PROPERTY SWIG_MODULE_NAME _moex_gcurve)

# Create SWIG library
swig_add_library(moex_gcurve TYPE MODULE LANGUAGE python
                 SOURCES src/qlmoex/moex_gcurve.i
                         src/qlmoex/moex_gcurve.cpp)

# Link libraries - QuantLib statically, Python dynamically
target_link_libraries(moex_gcurve PRIVATE QuantLib Python3::Python)

# Include directories
target_include_directories(moex_gcurve PRIVATE vendor/quantlib)

# Set output name
set_target_properties(moex_gcurve PROPERTIES OUTPUT_NAME "_moex_gcurve")

# Installation
install(TARGETS moex_gcurve LIBRARY DESTINATION qlmoex)
install(FILES src/qlmoex/__init__.py src/qlmoex/py.typed DESTINATION qlmoex)
