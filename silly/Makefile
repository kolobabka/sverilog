VCS := vcs

FILELIST = filelist_silly 
SIMV = silly
SRC = sillyfunction.sv \
      sillyfunction_bench.sv
OPTS = -sverilog -full64 -Mupdate -f $(FILELIST) -o $(SIMV)

.PHONY: all
all: run

.PHONY: compile
compile: $(SIMV)

.PHONY: run
run: $(SIMV)
	./$(SIMV)

$(SIMV): $(SRC)
	$(VCS) $(OPTS)

.PHONY: clean
clean:
	rm -rf *.daidir *.key csrc $(SIMV)
