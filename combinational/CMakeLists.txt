CMAKE_MINIMUM_REQUIRED(VERSION 3.11)
PROJECT(Combinatorial)

SET(COMPILER verilator)
SET(SIMV silly)
SET(SRC
  sillyfunction.sv
  gates.sv
  muxes.sv
  comb_testbench.sv
)
SET(VECTORS
  sillyvectors.txt
  xor4vectors.txt
  and8vectors.txt
  gatevectors.txt
)
SET(GSRC genvectors.cc)
SET(GEN vgen)
SET(OPTS
  -cc
  --timing
  --build
  --main
  --exe)

ADD_CUSTOM_TARGET(${SIMV}
  COMMAND ${COMPILER} ${OPTS} ${SRC} -o ${SIMV}
  COMMENT "Compile sv files with ${COMPILER}"
  WORKING_DIRECTORY ${CMAKE_CURRENT_SOURCE_DIR}
  DEPENDS ${VERILOG_SOURCES})

ADD_CUSTOM_TARGET(build_simv
  COMMAND ${CMAKE_COMMAND} -E copy
    ${CMAKE_CURRENT_SOURCE_DIR}/obj_dir/${SIMV}
    ${CMAKE_CURRENT_BINARY_DIR}/${SIMV}
  DEPENDS ${SIMV})

ADD_EXECUTABLE(${GEN} ${GSRC})

ADD_CUSTOM_TARGET(vectors
  COMMAND ${GEN}
  WORKING_DIRECTORY ${CMAKE_CURRENT_BINARY_DIR}
  DEPENDS ${GEN})

ADD_CUSTOM_TARGET(runsim
  COMMAND ${CMAKE_CURRENT_BINARY_DIR}/${SIMV}
  WORKING_DIRECTORY ${CMAKE_CURRENT_BINARY_DIR}
  DEPENDS build_simv)
ADD_DEPENDENCIES(runsim vectors)

ADD_CUSTOM_TARGET(build-all ALL)
ADD_DEPENDENCIES(build-all runsim)

