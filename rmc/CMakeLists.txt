# test vector copy
ADD_CUSTOM_TARGET(copy_vectors_rmc
  COMMAND ${CMAKE_COMMAND} -E copy
    ${CMAKE_CURRENT_SOURCE_DIR}/sillyvectors.txt
    ${CMAKE_CURRENT_BINARY_DIR}/
)

SET(SIMV rmc)
SET(SRC
  readmem_check.sv
  randomize.sv
  top.sv
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
ADD_DEPENDENCIES(runsim_${SIMV} copy_vectors_rmc)

# mandatory
ADD_DEPENDENCIES(build-all runsim_${SIMV})
