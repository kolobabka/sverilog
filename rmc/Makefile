VCS := vcs

FILELIST = filelist_rmc 
SIMV = rmc
SRC = readmem_check.sv
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
