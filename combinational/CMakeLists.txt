SET(GSRC genvectors.cc)
SET(GEN vgen)

# test vector generator (C++ sources)
ADD_EXECUTABLE(${GEN} ${GSRC})

# test generator run
ADD_CUSTOM_TARGET(vectors_${GEN}
  COMMAND ${GEN}
  WORKING_DIRECTORY ${CMAKE_CURRENT_BINARY_DIR}
  DEPENDS ${GEN})

SET(SIMV combinatorial)
SET(SRC
  ${CMAKE_SOURCE_DIR}/util/util.sv
  ${CMAKE_CURRENT_SOURCE_DIR}/sillyfunction.sv
  ${CMAKE_CURRENT_SOURCE_DIR}/gates.sv
  ${CMAKE_CURRENT_SOURCE_DIR}/comb_testbench.sv
)

# build sv files to testbench + dut
ADD_CUSTOM_TARGET(${SIMV}
  COMMAND ${COMPILER} ${OPTS} ${SRC} --Mdir ${CMAKE_CURRENT_BINARY_DIR} -o ${SIMV}
  COMMENT "Compile sv files with ${COMPILER}"
  WORKING_DIRECTORY ${CMAKE_CURRENT_SOURCE_DIR}
  DEPENDS ${VERILOG_SOURCES})

# run testbench
ADD_CUSTOM_TARGET(runsim_${SIMV}
  COMMAND ${CMAKE_CURRENT_BINARY_DIR}/${SIMV}
  WORKING_DIRECTORY ${CMAKE_CURRENT_BINARY_DIR}
  DEPENDS ${SIMV})
ADD_DEPENDENCIES(runsim_${SIMV} vectors_${GEN})

# mandatory
ADD_DEPENDENCIES(build-all runsim_${SIMV})

SET(SIMVX4 combinatorialx4)
SET(SRCX4
  ${CMAKE_SOURCE_DIR}/util/util.sv
  ${CMAKE_CURRENT_SOURCE_DIR}/xorfour.sv
  ${CMAKE_CURRENT_SOURCE_DIR}/xorfour_tb.sv
)

# build sv files to testbench + dut
ADD_CUSTOM_TARGET(${SIMVX4}
  COMMAND ${COMPILER} ${OPTS} ${SRCX4} --Mdir ${CMAKE_CURRENT_BINARY_DIR} -o ${SIMVX4}
  COMMENT "Compile sv files with ${COMPILER}"
  WORKING_DIRECTORY ${CMAKE_CURRENT_SOURCE_DIR}
  DEPENDS ${VERILOG_SOURCES})

# run testbench
ADD_CUSTOM_TARGET(runsim_${SIMVX4}
  COMMAND ${CMAKE_CURRENT_BINARY_DIR}/${SIMVX4}
  WORKING_DIRECTORY ${CMAKE_CURRENT_BINARY_DIR}
  DEPENDS ${SIMVX4})
ADD_DEPENDENCIES(runsim_${SIMVX4} vectors_${GEN})

# mandatory
ADD_DEPENDENCIES(build-all runsim_${SIMVX4})


