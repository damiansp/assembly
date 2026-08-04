CXX      = clang++
CXXFLAGS = -Wall

TARGET = arm64_cpp_hybrid
SRCS   = arm64_cpp_hybrid.cpp arm64_func.s

$(TARGET): $(SRCS)
	$(CXX) $(CXXFLAGS) $(SRCS) -o $(TARGET)

clean:
	rm -f $(TARGET)

.PHONY: clean
