ROOT_DIR=`pwd`
SRC_DIR=$(ROOT_DIR)/src
DIST_DIR=$(ROOT_DIR)/dist
LEXER_X=$(SRC_DIR)/Lexer.x
OUTPUT=$(DIST_DIR)/hurray

# Actions

all:
	make build

alex:
	alex $(LEXER_X)

uuag:
	cd $(SRC_DIR); uuagc -a AST

delete-files:
	rm $(SRC_DIR)/*.o $(SRC_DIR)/*.hi

clean:
	rm $(OUTPUT)
	make delete-files

build:
	cd $(SRC_DIR); ghc -fglasgow-exts --make -outputdir $(DIST_DIR) -o hurray Main.hs

run-ruby:
	ruby -Ilib/hurray-ruby-sdk -I$(DIR) $(RB)

run-sim:
	jruby -Ilib/hurray-ruby-sdk -I$(DIR) -Itools/hurray-jruby-sim tools/hurray-jruby-sim/simulator.rb $(CL)