cmake_minimum_required(VERSION 3.18)
project(quantlib_moex LANGUAGES CXX)

find_package(QuantLib REQUIRED)
find_package(SWIG 4.1 REQUIRED COMPONENTS python)
find_package(Python3 COMPONENTS Development REQUIRED)

set(CMAKE_CXX_STANDARD 17)
set(CMAKE_POSITION_INDEPENDENT_CODE ON)

swig_add_library(moex_gcurve TYPE MODULE LANGUAGE python
                 SOURCES src/qlmoex/moex_gcurve.i
                         src/qlmoex/moex_gcurve.cpp)

swig_link_libraries(moex_gcurve PRIVATE QuantLib::QuantLib Python3::Python)

install(TARGETS moex_gcurve LIBRARY DESTINATION qlmoex)
install(FILES src/qlmoex/__init__.py src/qlmoex/py.typed DESTINATION qlmoex)
