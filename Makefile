override CXXFLAGS += -std=c++17 -Wall -Iinclude

ifeq ($(WITH_SSL),1)
  override LDFLAGS += -Lssl -Lcrypto
endif

.PHONY: all test clean

all:
	mkdir -p bin
	# Temp solution since {2} is not working...
	# perhaps try -regextype sed
	for d in `find . -type d -maxdepth 1 -regex '\.\/[0-9][0-9]_.*'`; \
	  do $(CXX) $(CXXFLAGS) -o bin/$$d $$d/src/*.cpp $(LDFLAGS); \
	  done

get-deps:
	echo "TODO"

test:
	mkdir -p bin/test
	$(CXX) $(CXXFLAGS) -o bin/test/first 01_echo/test/*.cpp
	# for d in `find . -type d -maxdepth 1 -regex '\.\/[0-9][0-9]_.*'`; \
	#   do $(CXX) $(CXXFLAGS) -o test/$$d $$d/test/*.cpp $(LDFLAGS); \
	#   done

clean:
	rm -rf bin
	rm -rf test
