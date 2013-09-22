#

HTTP_PARSER_PATH = node.native/http-parser
LIBUV_PATH = node.native/libuv
NODENATIVE_PATH = node.native

LIBUV_NAME=libuv.a
OS_NAME=$(shell uname -s)
ifeq (${OS_NAME},Darwin)
	RTLIB=
	CXXFLAGS = -framework CoreFoundation -framework CoreServices -std=gnu++0x -stdlib=libc++ -g -O0 -I$(LIBUV_PATH)/include -I$(HTTP_PARSER_PATH) -I$(NODENATIVE_PATH) -D_LARGEFILE_SOURCE -D_FILE_OFFSET_BITS=64
	
else
	RTLIB=-lrt
	CXXFLAGS = -std=gnu++0x -g -O0 -I$(LIBUV_PATH)/include -I$(HTTP_PARSER_PATH) -I. -D_LARGEFILE_SOURCE -D_FILE_OFFSET_BITS=64
endif

all: test

test: clean $(LIBUV_PATH)/$(LIBUV_NAME) $(HTTP_PARSER_PATH)/http_parser.o $(wildcard node.native/native/*.h)
	dotc pre test.cc > preprocess.cc
	$(CXX) $(CXXFLAGS) -o test preprocess.cc $(LIBUV_PATH)/$(LIBUV_NAME) $(HTTP_PARSER_PATH)/http_parser.o $(RTLIB) -lm -lpthread


# webclient: webclient.cpp $(LIBUV_PATH)/$(LIBUV_NAME) $(HTTP_PARSER_PATH)/http_parser.o $(wildcard native/*.h)
# 	$(CXX) $(CXXFLAGS) -o webclient webclient.cpp $(LIBUV_PATH)/$(LIBUV_NAME) $(HTTP_PARSER_PATH)/http_parser.o $(RTLIB) -lm -lpthread
	
# webserver: webserver.cpp $(LIBUV_PATH)/$(LIBUV_NAME) $(HTTP_PARSER_PATH)/http_parser.o $(wildcard native/*.h)
# 	$(CXX) $(CXXFLAGS) -o webserver webserver.cpp $(LIBUV_PATH)/$(LIBUV_NAME) $(HTTP_PARSER_PATH)/http_parser.o $(RTLIB) -lm -lpthread
	
# file_test: file_test.cpp $(LIBUV_PATH)/$(LIBUV_NAME) $(HTTP_PARSER_PATH)/http_parser.o $(wildcard native/*.h)
# 	$(CXX) $(CXXFLAGS) -o file_test file_test.cpp $(LIBUV_PATH)/$(LIBUV_NAME) $(HTTP_PARSER_PATH)/http_parser.o $(RTLIB) -lm -lpthread

$(LIBUV_PATH)/$(LIBUV_NAME):
	$(MAKE) -C $(LIBUV_PATH)

$(HTTP_PARSER_PATH)/http_parser.o:
	$(MAKE) -C $(HTTP_PARSER_PATH) http_parser.o
	
clean:
	rm -f test preprocess.cc