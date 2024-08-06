COMPILER := verilator

FILELIST = filelist_silly 
SIMV = silly
SRC = sillyfunction.sv \
      xorfour.sv \
      sillyfunction_bench.sv
OPTS = -cc --timing --build --main --exe $(SRC) -o $(SIMV)

.PHONY: all
all: run

.PHONY: compile
compile: $(SIMV)

.PHONY: run
run: $(SIMV)
	./obj_dir/$(SIMV)

$(SIMV): $(SRC)
	$(COMPILER) $(OPTS)

.PHONY: clean
clean:
	rm -rf obj_dir
