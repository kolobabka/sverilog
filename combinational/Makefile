COMPILER := verilator

FILELIST = filelist_silly 
SIMV = silly
SRC = sillyfunction.sv \
      xorfour.sv \
      gates.sv \
      comb_testbench.sv
VECTORS = sillyvectors.txt \
          xor4vectors.txt \
          gatevectors.txt
GSRC = genvectors.cc \
       alltuples.hpp
GEN = vgen
OPTS = -cc --timing --build --main --exe $(SRC) -o $(SIMV)

.PHONY: all
all: run

.PHONY: compile
compile: $(SIMV)

.PHONY: run
run: $(SIMV) $(VECTORS)
	./obj_dir/$(SIMV)

$(SIMV): $(SRC)
	$(COMPILER) $(OPTS)

$(GEN): $(GSRC)
	$(CXX) $(CXXFLAGS) genvectors.cc -o $(GEN)

$(VECTORS): $(GEN)
	./$(GEN)

.PHONY: clean
clean:
	rm -rf obj_dir $(GEN) $(VECTORS)
