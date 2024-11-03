CMAKE_MINIMUM_REQUIRED(VERSION 3.11)
PROJECT(SVerilog)

SET(COMPILER verilator)

SET(OPTS
  -cc
  --timing
  --build
  --main
  --exe)

ADD_CUSTOM_TARGET(build-all ALL)

add_subdirectory(combinational)
add_subdirectory(muxes)
add_subdirectory(latches)
add_subdirectory(rmc)
add_subdirectory(counter)
add_subdirectory(ram)

